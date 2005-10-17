Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVJQTFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVJQTFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVJQTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:05:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62891 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932270AbVJQTFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:05:36 -0400
Date: Mon, 17 Oct 2005 12:04:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <20051017184523.GB26239@granada.merseine.nu>
Message-ID: <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de>
 <20051017182755.GA26239@granada.merseine.nu> <200510172032.45972.ak@suse.de>
 <20051017184523.GB26239@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Muli Ben-Yehuda wrote:
>
> On Mon, Oct 17, 2005 at 08:32:45PM +0200, Andi Kleen wrote:
> 
> > > and would like to be able to run 2.6.14 on them when it 
> > > comes out...
> > 
> > So you're saying you tested it and it doesn't work? 
> 
> Not quite; I'm saying that form the description up-thread it sounds
> like there's a good chance it won't. Jon Mason (CC'd) has access to
> such a  machine. Jon, can you please try the latest hg tree with and
> without the patch and see how it fares?

NOTE! Even if the machine has 4GB or more of memory, it's entirely likely 
that the quick "use NODE(0)" hack will work fine. 

Why? Because the bootmem memory should still be allocated low-to-high by 
default, which means that as logn as NODE(0) has _enough_ memory in the 
DMA range, we should be ok.

So I _think_ the simple one-liner NODE(0) patch is sufficient, and should 
work (and is a lot more acceptable for 2.6.14 than switching the node 
ordering around yet again, or doing bigger surgery on the bootmem code).

So the only thing that worried me (and made me ask whether there might be 
machines where it doesn't work) is if some machines might have their high 
memory (or no memory at all) on NODE(0). It does sound unlikely, but I 
simple don't know what kind of strange NUMA configs there are out there.

And I'm definitely only interested in machines that are out there, not 
some theoretical issues.

			Linus
