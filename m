Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTAJNhf>; Fri, 10 Jan 2003 08:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTAJNhf>; Fri, 10 Jan 2003 08:37:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23792 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265063AbTAJNhe>; Fri, 10 Jan 2003 08:37:34 -0500
Date: Fri, 10 Jan 2003 14:46:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] #include interrupt.h in epca.c and generic_serial.c
Message-ID: <20030110134614.GK6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below #include's interrupt.h in epca.c and generic_serial.c to 
fix the compilation for !SMP. The proper fix is to remove cli/sti/... 
but until fixes are available I consider it better to have this 
workaround included.

cu
Adrian

--- linux-2.5.55/drivers/char/epca.c.old	2003-01-10 14:31:20.000000000 +0100
+++ linux-2.5.55/drivers/char/epca.c	2003-01-10 14:32:05.000000000 +0100
@@ -40,6 +40,7 @@
 #include <linux/tty_flip.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>  /* for cli/sti/... on !SMP */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
--- linux-2.5.55/drivers/char/generic_serial.c.old	2003-01-10 14:32:13.000000000 +0100
+++ linux-2.5.55/drivers/char/generic_serial.c	2003-01-10 14:32:35.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/serial.h>
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
+#include <linux/interrupt.h>  /* for cli/sti/... on !SMP */
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
