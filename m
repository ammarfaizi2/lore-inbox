Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWJPE2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWJPE2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 00:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWJPE2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 00:28:52 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:48040 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751456AbWJPE2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 00:28:52 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Amol Lad <amol@verismonetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: matthew@wil.cx, linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160835602.5732.30.camel@localhost.localdomain>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
	 <1160835602.5732.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 10:02:12 +0530
Message-Id: <1160973132.19143.402.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-14 at 15:20 +0100, Alan Cox wrote:
> Ar Gwe, 2006-10-13 am 17:10 +0530, ysgrifennodd Amol Lad:
> > Removed save_flags()/cli()/sti() and used (light weight) spin locks
> > 
> 
> Three things I see that look problematic

> 2. If the irq handler itself dumbly locks to fix this then we get
> tty_flip_buffer_push() re-entering the other code paths and deadlocking
> if low latency is enabled

The comment above tty_flip_buffer_push() says "This function must not be
called from IRQ context if tty->low_latency is set". In this case
tty_flip_buffer_push() is called from IRQ context. Do you think
tty->low_latency can still be set for this case ? or I misunderstood
your statement completely...

> 3. Some of the use of local_save/spin_lock_irq seems over-clever and
> unneeded

Let me know, I'll fix them too.

> 
> Fixable but how about we just delete the file since it has been broken
> for ages and nobody can be using it ?
> 

If we cannot delete the file then we must fix it. It's not good the
drivers using old and deprecated interfaces in current phase of kernel
development.

