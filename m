Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUEGNeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUEGNeI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 09:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUEGNeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 09:34:07 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:58016 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263032AbUEGNeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 09:34:04 -0400
Message-ID: <20040507133403.39224.qmail@web14923.mail.yahoo.com>
Date: Fri, 7 May 2004 06:34:03 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Is it possible to implement interrupt time printk's reliably?
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
In-Reply-To: <20040506221746.7bb45421.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Jon Smirl <jonsmirl@yahoo.com> wrote:
> >
> > Problem:
> >  1) Some operations on graphics cards cannot be stopped once they are
> started.
> >  It's not reasonable to turn interrupts off around these operations.
> >  2) Kernel developers want console printk's to work from interrupt routines.
> > 
> >  How do you fix this situation?
> 
> Really you should use spin_lock_irqsave() on some driver-private lock
> around the operation.  Why is it not reasonable to disable irq's? 
> Duration, presumably?

The operations take a while and would ruin latency. You might be copying 8MB of
data.

> If you're in process context you can use acquire_console_sem(), which will
> serialise against printk.
> 

Won't I deadlock if I have acquire_console_sem(), take an interrupt, and then a
printk is issued from the interrupt handelr?


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 
