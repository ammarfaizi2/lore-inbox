Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJ2BpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 20:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJ2BpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 20:45:22 -0500
Received: from web13012.mail.yahoo.com ([216.136.172.93]:35226 "HELO
	web13012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261837AbTJ2BpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 20:45:18 -0500
Message-ID: <20031029014517.60577.qmail@web13012.mail.yahoo.com>
Date: Tue, 28 Oct 2003 17:45:17 -0800 (PST)
From: Amit Patel <patelamitv@yahoo.com>
Subject: Re: as_arq scheduler alloc with 2.6.0-test8-mm1
To: Nick Piggin <piggin@cyberone.com.au>, Amit Patel <patelamitv@YAHOO.COM>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3F9DABE6.7050501@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

After doing some printk debugging looks like for each
block device we allocate elevator structure. But
during cleanup the elevator->elevator_data is never
freed. In printk I put printk in as-iosched.c:as_alloc
where I see elevator_data is allocated from as_arq
pool and it should have been freed as a part of block
device cleanup through elevator_release function. I
never see it coming to elevatore_release function. 

I will try to walk through code some more and see if I
can figure out who was supposed to call
elevator_release as part of cleanup. Let me know if I
am going on wrong track here.

Thanks
Amit
--- Nick Piggin <piggin@cyberone.com.au> wrote:
> 
> 
> Mr Amit Patel wrote:
> 
> >Hi Andrew,
> >
> >The qlogic driver is for Fibre Channel HBA QLA2342.
> >This is a beta driver which is part of the mjb1
> patch
> >against 2.6.0-test8. As a part of driver insmod,
> >driver tries to find fiber channel device and maps
> it
> >to scsi block device. Actually I don't have any
> fibre
> >channel target attached, so driver does not find
> any
> >scsi devices and discovery finishes without adding
> any
> >block device. 
> >
> >I am trying to go through driver scsi_scan process
> and
> >see when does actual allocation from as_arq
> happens.
> >But for some reason after going to kgdb I get
> SIGEMT
> >and I cannot debug further. What is causing SIGEMT
> >cause after doing some search looks like its
> actually
> >SIGUSR but linux treats it as SIGEMT. Is there any
> way
> >to prevent SIGEMT when I want to use kgdb ? 
> >
> >Thanks for your help,
> >
> 
> Hi Amit,
> 
> I'm a little bit busy to look at this now, however
> someone
> is looking into all these refcounting problems.
> 
> If you would like to narrow it down a bit, check
> that the
> request queues that are allocated are all released
> when the
> driver is unloaded (drivers/block/ll_rw_blk.c
> blk_alloc_queue
> and blk_cleanup_queue). Just stick a couple of
> printks there
> if your debugger isn't working.
> 
> 


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
