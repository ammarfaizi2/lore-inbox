Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUEIQdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUEIQdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbUEIQdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 12:33:15 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:27738 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264352AbUEIQdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 12:33:10 -0400
Message-ID: <20040509163310.46944.qmail@web14923.mail.yahoo.com>
Date: Sun, 9 May 2004 09:33:10 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
In-Reply-To: <20040507130119.45924379.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how do printk's work in the very early boot? Is the video card active before
the kernel probes it's module, or are these very early printk's being queued
until the video driver is probed?

--- Andrew Morton <akpm@osdl.org> wrote:
> Jon Smirl <jonsmirl@yahoo.com> wrote:
> >
> > 
> > --- Andrew Morton <akpm@osdl.org> wrote:
> > > Jon Smirl <jonsmirl@yahoo.com> wrote:
> > > >
> > > > > If you're in process context you can use acquire_console_sem(), which
> will
> > > > > serialise against printk.
> > > > > 
> > > > 
> > > > Won't I deadlock if I have acquire_console_sem(), take an interrupt, and
> > > then a
> > > > printk is issued from the interrupt handelr?
> > > > 
> > > 
> > > Nope.  If printk finds the semaphore to be held it queues up the
> characters
> > > and returns without printing them.  The console_sem-holding process will
> > > print the newly buffered characters before releasing the semaphore.
> > 
> > Is this solution sufficient for kernel developers wanting to use printk from
> > interrupt handlers? I've gotten negative feedback from Linus when I
> suggested
> > queuing them before.
> > 
> 
> It has been this way for several years.


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
