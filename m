Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUDUUpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUDUUpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbUDUUpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:45:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25997 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263698AbUDUUp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:45:28 -0400
Date: Thu, 22 Apr 2004 02:13:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421204303.GA5014@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF9B34CCE6.C0CD3DC5-ONC1256E7D.005B1592-C1256E7D.005B528B@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9B34CCE6.C0CD3DC5-ONC1256E7D.005B1592-C1256E7D.005B528B@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 06:37:29PM +0200, Martin Schwidefsky wrote:
> > > This would mean that all other arches need to do the above three
> > > statements in rcu_start_batch. If this is acceptable we certainly
> > > can introduce a global idle_cpu_mask. Where? sched.c?
> >
> > My hope was gcc would actually optimize it away if it was a CPP constant
> > instead of a variable.
> 
> Now I got it. You want to introduce a generic idle_cpu_mask which is a
> #define to CPU_MASK_NONE and only an exploiter would use a real variable.
> This is just a matter of test. I'll give it a try.

I think CPU_MASK_NONE can be used only for assignments. You need
to actually declare a generic idle_cpu_mask and set it to CPU_MASK_NONE
for all other archs. Of course, then the compiler will not be able
to optimize it out :)

Thanks
Dipankar
