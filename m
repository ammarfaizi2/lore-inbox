Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbSLEKrT>; Thu, 5 Dec 2002 05:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbSLEKqN>; Thu, 5 Dec 2002 05:46:13 -0500
Received: from holomorphy.com ([66.224.33.161]:43913 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267276AbSLEKqE>;
	Thu, 5 Dec 2002 05:46:04 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [2/8] fix uninitialized quot in drivers/serial/core.c
Message-ID: <0212050252.AaCdAbid6d9cabJbEbmaTdZb7daa.c5a20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.hdcd1a.b3aUbzb5bCbGc3dkcCd8a1atc20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give quot a default value so it's initialized. rmk, this is yours
to ack.

===== drivers/serial/core.c 1.24 vs edited =====
--- 1.24/drivers/serial/core.c	Sun Dec  1 08:37:25 2002
+++ edited/drivers/serial/core.c	Thu Dec  5 00:59:44 2002
@@ -387,7 +387,7 @@
 uart_get_divisor(struct uart_port *port, struct termios *termios,
 		 struct termios *old_termios)
 {
-	unsigned int quot, try;
+	unsigned int quot = 0, try;
 
 	for (try = 0; try < 3; try ++) {
 		unsigned int baud;
@@ -416,7 +416,7 @@
 		termios->c_cflag |= B9600;
 	}
 
-	return quot;
+	return quot ? quot : 1;
 }
 
 EXPORT_SYMBOL(uart_get_divisor);
