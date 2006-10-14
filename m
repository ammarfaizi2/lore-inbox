Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWJNRti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWJNRti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWJNRti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:49:38 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:12187 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932317AbWJNRti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:49:38 -0400
Date: Sat, 14 Oct 2006 11:49:37 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Amol Lad <amol@verismonetworks.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()	removal
Message-ID: <20061014174936.GN11633@parisc-linux.org>
References: <1160739628.19143.376.camel@amol.verismonetworks.com> <1160835602.5732.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160835602.5732.30.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 03:20:02PM +0100, Alan Cox wrote:
> 1. The irq locking isn't doing anything as the IRQ handler itself is not
> taking the lock

Looks like you reviewed the first version instead of the version Amol
sent after Arjan critiqued that.

> 2. If the irq handler itself dumbly locks to fix this then we get
> tty_flip_buffer_push() re-entering the other code paths and deadlocking
> if low latency is enabled

Yep, still a problem with the revised patch.

> 3. Some of the use of local_save/spin_lock_irq seems over-clever and
> unneeded
> 
> Fixable but how about we just delete the file since it has been broken
> for ages and nobody can be using it ?

Only broken on SMP ...

I wouldn't mind writing a new driver (using the serial core) if someone
wants to send me one.  I need a multiport serial card anyway ...
