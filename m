Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJONGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJONGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUJONGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:06:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:34279 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266459AbUJONGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:06:17 -0400
Date: Fri, 15 Oct 2004 08:06:02 -0500
From: Robin Holt <holt@sgi.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: Yet another crash dump tool
Message-ID: <20041015130602.GA32020@lnx-holt.americas.sgi.com>
References: <20041014074718.26E6.ODA@valinux.co.jp> <20041014112938.GE19122@lnx-holt.americas.sgi.com> <20041015081246.26EB.ODA@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015081246.26EB.ODA@valinux.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:08:41AM +0900, Itsuro Oda wrote:
> Hi,
> 
> > dump device.  Can you dump device span multiple volumes?  If I
> yes. (maybe. suppose logical volume.)

1TB of memory being written to device at 200Mb/sec will take
1 1/2 hours to dump.  That seems like a long time.  I start
getting frustrated at a few minutes of lost production.  Can
you add a feature to only dump kernel pages, kernel pages +
page/buffer cache, or all of memory?  If not, this is a step
backwards in dumping.  We have seen RFPs from some potential
customers for as much as 16PB of memory.  I am not sure that
anybody builds hardware that scales to that level, but it
certainly shows you a problem.

> 
> > have a system using 1TB of physical memory, but 98% of that
> > is allocated as huge TLB pages for users, do I _REALLY_ need to
> > dump them all?
> yes, absolutely, for us.
> 
> Our target is customer's production system, not developping/debugging
> system. The chance of capturing fault analysis materials may be only
> one time. If a kernel destroy the memory using user process(page cache
> , buffer cache), looking the pattern of destroy is great helpful to 
> analyze. (note that I have encountered such case many times)
> We also analyze user proccesses at the crash time from the dump.

I have analyzed many dumps and never even had the desire to look at
the user processes.  Additionally, some of our customers have
classified data.  They require assurances that the minimal amount
of their unclassified data is being sent outside their control to
reduce the chance that someone can infer their methods.

> 
> > lkcd, and I would hope others, only dump kernel pages unless
> > configured to do otherwise.
> 
> You should chose a dump tool you like.
> 
> We believe we need whole memory. But we understand there is an opinion
> like you (reduce saving memory is better). We don't force to use our
> tool. We make "mini kernel dump" as independent from kernel as possible.
> 


Thanks,
Robin Holt
