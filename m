Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288966AbSAFPIR>; Sun, 6 Jan 2002 10:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288968AbSAFPIH>; Sun, 6 Jan 2002 10:08:07 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:56849 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S288966AbSAFPHy>; Sun, 6 Jan 2002 10:07:54 -0500
Date: Sun, 6 Jan 2002 16:07:51 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compile fix for matrox fb 2.5.2-9
Message-ID: <20020106150751.GA23321@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

attached is a small compile fix for matroxfb.
I'm still unable to link it because of the binutils issues.

I lost the perl script, maybe someone allready has a fix ?

drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols in discarded section .text.exit'
drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in discarded section .text.exit'
make: *** [vmlinux] Error 1

cheers,
Patrick

--- linux-2.5.2-9/drivers/video/matrox/matroxfb_base.c	Fri Nov 23 21:05:59 2001
+++ work-2.5.2-9/drivers/video/matrox/matroxfb_base.c	Sun Jan  6 15:57:18 2002
@@ -1789,7 +1789,7 @@
 
 	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
 	ACCESS_FBINFO(fbcon.changevar) = NULL;
-	ACCESS_FBINFO(fbcon.node) = -1;
+	ACCESS_FBINFO(fbcon.node) = to_kdev_t(-1);
 	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
 	ACCESS_FBINFO(fbcon.disp) = d;
 	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;

