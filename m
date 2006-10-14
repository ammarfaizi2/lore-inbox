Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJNNxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJNNxe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 09:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWJNNxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 09:53:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31113 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422638AbWJNNxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 09:53:34 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160739628.19143.376.camel@amol.verismonetworks.com>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 15:20:02 +0100
Message-Id: <1160835602.5732.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 17:10 +0530, ysgrifennodd Amol Lad:
> Removed save_flags()/cli()/sti() and used (light weight) spin locks
> 

Three things I see that look problematic

1. The irq locking isn't doing anything as the IRQ handler itself is not
taking the lock
2. If the irq handler itself dumbly locks to fix this then we get
tty_flip_buffer_push() re-entering the other code paths and deadlocking
if low latency is enabled
3. Some of the use of local_save/spin_lock_irq seems over-clever and
unneeded

Fixable but how about we just delete the file since it has been broken
for ages and nobody can be using it ?

