Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUEGUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUEGUal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUEGU3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:29:17 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:61075 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263750AbUEGU0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:26:53 -0400
Message-ID: <20040507192650.95994.qmail@web14926.mail.yahoo.com>
Date: Fri, 7 May 2004 12:26:50 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
In-Reply-To: <20040507121319.6939b391.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andrew Morton <akpm@osdl.org> wrote:
> Jon Smirl <jonsmirl@yahoo.com> wrote:
> >
> > > If you're in process context you can use acquire_console_sem(), which will
> > > serialise against printk.
> > > 
> > 
> > Won't I deadlock if I have acquire_console_sem(), take an interrupt, and
> then a
> > printk is issued from the interrupt handelr?
> > 
> 
> Nope.  If printk finds the semaphore to be held it queues up the characters
> and returns without printing them.  The console_sem-holding process will
> print the newly buffered characters before releasing the semaphore.

Is this solution sufficient for kernel developers wanting to use printk from
interrupt handlers? I've gotten negative feedback from Linus when I suggested
queuing them before.

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
