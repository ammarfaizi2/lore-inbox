Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269267AbUIHSJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269267AbUIHSJr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUIHSJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:09:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11423 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269267AbUIHSJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:09:44 -0400
Date: Wed, 8 Sep 2004 13:45:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       raybry@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@redhat.com, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040908164549.GA4284@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <413D8FB2.1060705@cyberone.com.au> <413D93EF.80305@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413D93EF.80305@kolivas.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 08:56:47PM +1000, Con Kolivas wrote:
> Nick Piggin wrote:
> >
> >
> >Marcelo Tosatti wrote:
> >
> >>
> >>Hi kernel fellows,
> >>
> >>I volunteer. I'll try something tomorrow to compare swappiness of 
> >>older kernels like  2.6.5 and 2.6.6, which were fine on SGI's Altix 
> >>tests, up to current newer kernels (on small memory boxes of course).
> >>
> >
> >Hi Marcelo,
> >
> >Just a suggestion - I'd look at the thrashing control patch first.
> >I bet that's the cause.
> 
> Good point!
> 
> I recall one of my users found his workload which often hit swap lightly 
> was swapping much heavier and his performance dropped dramatically until 
> I stopped including the swap thrash control patch. I informed Rik about 
> it some time back so I'm not sure if he addressed it in the meantime.

Swap thrashing code doesnt affect anything, at least on my simple contained test.
With the same test, the amount of swapped out memory with 2.6.6/2.6.7 is 100-150MB,
 while 2.6.8/2.6.9-mm* swaps out around 250MB.

I tried 2.6.7's "vmscan.c" on 2.6.8 without noticeable difference, I wonder why. 

What I've noticed before with the swap token code is total crap interactivity 
when memory hog is running. Which doesnt happen without it.

Con, I've seen your hard swappiness patch, why do you remove the current
swap_tendency calculation? Can you give us some insight into it? 

The thing is, if the user thinks the machine is swapping out too heavily
he can always decrease vm_swappinness. Whatever change that might happen
on VM swapout policy can be tuned with vm_swappinness. 

It works - its not very smooth, changing from "53" to "50" causes the 
amount of swapped data to be 4 times smaller (due to 
if (swap_tendency >= 100) I believe). Apart from that its fine, 
and behaves as expected.

Maybe the current value of "60" is too high for most desktop users, 
if so it can be decreased a little bit. 

But whats the point of your patch?
