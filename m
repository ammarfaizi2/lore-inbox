Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263728AbUEGUCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUEGUCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUEGUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:02:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:58859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263712AbUEGUBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:01:43 -0400
Date: Fri, 7 May 2004 13:01:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-kernel@vger.kernel.org, keithp@keithp.com
Subject: Re: Is it possible to implement interrupt time printk's reliably?
Message-Id: <20040507130119.45924379.akpm@osdl.org>
In-Reply-To: <20040507192650.95994.qmail@web14926.mail.yahoo.com>
References: <20040507121319.6939b391.akpm@osdl.org>
	<20040507192650.95994.qmail@web14926.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@yahoo.com> wrote:
>
> 
> --- Andrew Morton <akpm@osdl.org> wrote:
> > Jon Smirl <jonsmirl@yahoo.com> wrote:
> > >
> > > > If you're in process context you can use acquire_console_sem(), which will
> > > > serialise against printk.
> > > > 
> > > 
> > > Won't I deadlock if I have acquire_console_sem(), take an interrupt, and
> > then a
> > > printk is issued from the interrupt handelr?
> > > 
> > 
> > Nope.  If printk finds the semaphore to be held it queues up the characters
> > and returns without printing them.  The console_sem-holding process will
> > print the newly buffered characters before releasing the semaphore.
> 
> Is this solution sufficient for kernel developers wanting to use printk from
> interrupt handlers? I've gotten negative feedback from Linus when I suggested
> queuing them before.
> 

It has been this way for several years.
