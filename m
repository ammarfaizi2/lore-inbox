Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJGNeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTJGNeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:34:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:384 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262152AbTJGNeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:34:00 -0400
Date: Tue, 7 Oct 2003 09:33:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Second patch to turn off floppy motor(s)
Message-ID: <Pine.LNX.4.53.0310070932040.501@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For anyone interested.. This has already been discussed-to-death.

--- linux-2.4.22/arch/i386/boot/bootsect.S.orig	Tue Oct  7 08:47:06 2003
+++ linux-2.4.22/arch/i386/boot/bootsect.S	Tue Oct  7 09:23:35 2003
@@ -396,15 +396,10 @@
 # NOTE: Doesn't save %ax or %dx; do it yourself if you need to.

 kill_motor:
-#if 1
-	xorw	%ax, %ax		# reset FDC
-	xorb	%dl, %dl
-	int	$0x13
-#else
 	movw	$0x3f2, %dx
-	xorb	%al, %al
-	outb	%al, %dx
-#endif
+	inb	%dx, %al	# Get R/W bits
+	andb	$0x0f, %al	# Save all but motor-on bits
+	outb	%al, %dx	# Shut off motor
 	ret

 sectors:	.word 0




Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


