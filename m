Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318711AbSHQTro>; Sat, 17 Aug 2002 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318712AbSHQTrn>; Sat, 17 Aug 2002 15:47:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47322 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318711AbSHQTrn>; Sat, 17 Aug 2002 15:47:43 -0400
Date: Sat, 17 Aug 2002 21:51:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <ak@muc.de>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.20-pre1
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0208172130200.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Marcelo Tosatti wrote:

>...
> Summary of changes from v2.4.19 to v2.4.20-pre1
> ============================================
>...
> <ak@muc.de> (02/08/05 1.657)
> 	[PATCH] Ftape 64bit/x86-64 fixes
>...

This broke the modular building of ftape. In -pre3:

<--  snip  -->

...
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre3/kernel/drivers/char/ftape/lowlevel/ftape.o
depmod:         i8253_lock
...

<--  snip  -->


Alan made the following patch to fix it (already in -ac):


--- linux.20pre2/arch/i386/kernel/time.c	2002-08-13 13:58:33.000000000 +0100
+++ linux.20pre2-ac3/arch/i386/kernel/time.c	2002-08-12 15:17:04.000000000 +0100
@@ -31,6 +31,7 @@
  */

 #include <linux/errno.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/param.h>
@@ -116,6 +117,8 @@

 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;

+EXPORT_SYMBOL(i8253_lock);
+
 extern spinlock_t i8259A_lock;

 #ifndef CONFIG_X86_TSC



cu
Adrian




