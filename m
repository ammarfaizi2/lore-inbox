Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267289AbTBIQvz>; Sun, 9 Feb 2003 11:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBIQvz>; Sun, 9 Feb 2003 11:51:55 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:7043 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S267289AbTBIQvz>;
	Sun, 9 Feb 2003 11:51:55 -0500
Date: Sun, 9 Feb 2003 19:59:26 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: 2.4.21-pre4 - two simple compile fixes
Message-ID: <20030209165926.GA19461@linuxhacker.ru>
References: <20030208171838.GA2230@linuxhacker.ru> <20030209165408.GA19368@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209165408.GA19368@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

  With this trivial patch below I am able to compile with support
  for come Cadet radio card and NatSemi SCx200

Bye,
    Oleg

===== drivers/char/Makefile 1.30 vs edited =====
--- 1.30/drivers/char/Makefile	Tue Jan  7 18:03:18 2003
+++ edited/drivers/char/Makefile	Sun Feb  9 17:48:17 2003
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o hp_psaux.o nvram.o
+			au1000_gpio.o hp_psaux.o nvram.o scx200.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 
===== drivers/media/radio/radio-cadet.c 1.5 vs edited =====
--- 1.5/drivers/media/radio/radio-cadet.c	Fri Jan 31 15:03:08 2003
+++ edited/drivers/media/radio/radio-cadet.c	Sun Feb  9 17:59:13 2003
@@ -558,7 +558,7 @@
 static int __init cadet_init(void)
 {
 
-	spin_lock_init(&cadet_lock);
+	spin_lock_init(&cadet_io_lock);
 	
 	/*
 	 *	If a probe was requested then probe ISAPnP first (safest)
