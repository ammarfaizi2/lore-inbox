Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274300AbRITDob>; Wed, 19 Sep 2001 23:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274301AbRITDoM>; Wed, 19 Sep 2001 23:44:12 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:9428 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274300AbRITDoI>; Wed, 19 Sep 2001 23:44:08 -0400
Date: Wed, 19 Sep 2001 21:45:37 -0600
Message-Id: <200109200345.f8K3jbr29597@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com, crutcher+kernel@datastacks.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for drivers/char/sysrq.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Linus. The appended patch fixes drivers/char/sysrq.c so that it
doesn't do a bugus redefine of wakeup_bdflush(), nor attempt to pass
arguments to it. The changes in 2.4.10-pre12 broke sysrq.c compiling.

<whinge>
How did something this basic get submitted in the first place?!?
Doesn't anyone bother compiling patches before sending to Linus?
This is the second time today I've had to patch the kernel just to get
the rotten thing to compile. I'm not happy that whoever put in those
__builtin_expect()'s didn't bother testing with THE RECOMMENDED
COMPILER!!! It's not the first time that sort of thing has happened.
</whinge>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

--- sysrq.c~	Wed Sep 19 21:25:45 2001
+++ sysrq.c	Wed Sep 19 21:37:31 2001
@@ -32,7 +32,6 @@
 
 #include <asm/ptrace.h>
 
-extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
@@ -221,7 +220,7 @@
 static void sysrq_handle_sync(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_SYNC;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_sync_op = {
 	handler:	sysrq_handle_sync,
@@ -232,7 +231,7 @@
 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
 	emergency_sync_scheduled = EMERG_REMOUNT;
-	wakeup_bdflush(0);
+	wakeup_bdflush();
 }
 static struct sysrq_key_op sysrq_mountro_op = {
 	handler:	sysrq_handle_mountro,
