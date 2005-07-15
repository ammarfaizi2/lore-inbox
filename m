Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263360AbVGOUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbVGOUwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbVGOUwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 16:52:24 -0400
Received: from taxbrain.com ([64.162.14.3]:32857 "EHLO petzent.com")
	by vger.kernel.org with ESMTP id S263360AbVGOUwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 16:52:22 -0400
From: "karl malbrain" <karl@petzent.com>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
Date: Fri, 15 Jul 2005 13:52:15 -0700
Message-ID: <NDBBKFNEMLJBNHKPPFILAEAMCEAA.karl@petzent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <20050715213058.B23709@flint.arm.linux.org.uk>
X-Spam-Processed: petzent.com, Fri, 15 Jul 2005 13:48:29 -0700
	(not processed: message from valid local sender)
X-Return-Path: karl@petzent.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: petzent.com, Fri, 15 Jul 2005 13:48:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Russell King
> Sent: Friday, July 15, 2005 1:31 PM
> To: karl malbrain
> Cc: Linux-Kernel@Vger. Kernel. Org
> Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
>
>
> On Fri, Jul 15, 2005 at 01:11:33PM -0700, karl malbrain wrote:
> > > -----Original Message-----
> > > From: Russell King
> > > Sent: Friday, July 15, 2005 12:23 AM
> > > To: karl malbrain
> > > Cc: Linux-Kernel@Vger. Kernel. Org
> > > Subject: Re: 2.6.9 chrdev_open: serial_core: uart_open
> > >
> > >
> > > On Thu, Jul 14, 2005 at 04:50:00PM -0700, karl malbrain wrote:
> > > > chrdev_open issues a lock_kernel() before calling uart_open.
> > > >
> > > > It would appear that servicing the blocking open request
> > > uart_open goes to
> > > > sleep with the kernel locked.  Would this shut down
> subsequent access to
> > > > opening "/dev/tty"???
> > >
> > > No.  lock_kernel() is automatically released when a process sleeps.
> >
> > Drilling down between the uart_open and chrdev_open into tty_open is a
> > semaphore tty_sem that is being held during the sleep cycle in
> uart_open.
>
> chrdev_open() calls tty_open(), which then calls init_dev().  init_dev()
> takes tty_sem, does its stuff, and then releases tty_sem.  A little
> later on, tty_open() calls the uart driver's uart_open() function.
>
> So it does this with tty_sem unlocked.

On my 2.6.9-11EL source it clearly shows the up(&tty_sem) after the call to
uart_open. Init_dev never touches tty_sem.

karl m



