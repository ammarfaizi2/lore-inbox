Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266128AbSL1JMa>; Sat, 28 Dec 2002 04:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266160AbSL1JMa>; Sat, 28 Dec 2002 04:12:30 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:64011 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266128AbSL1JM3> convert rfc822-to-8bit;
	Sat, 28 Dec 2002 04:12:29 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [2.5.53, PATCH] fix uninitialized timer in yenta.c
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 28 Dec 2002 10:07:04 +0100
Message-ID: <87znqqcy13.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes a "uninitialized timer" message when loading
yenta_socket.ko.

--- linux-2.5.53/drivers/pcmcia/yenta.c.jh	2002-12-10 03:46:11.000000000 +0100
+++ linux-2.5.53/drivers/pcmcia/yenta.c	2002-12-28 09:45:56.000000000 +0100
@@ -593,6 +593,7 @@
 	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
+		init_timer(&socket->poll_timer);
 		socket->poll_timer.function = yenta_interrupt_wrapper;
 		socket->poll_timer.data = (unsigned long)socket;
 		socket->poll_timer.expires = jiffies + HZ;

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
