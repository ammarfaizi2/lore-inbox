Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSGUThz>; Sun, 21 Jul 2002 15:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSGUThz>; Sun, 21 Jul 2002 15:37:55 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26385 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313419AbSGUThy>; Sun, 21 Jul 2002 15:37:54 -0400
Subject: PATCH: Missing input config check
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:05:12 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WMx6-0007Xt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Q40 keyboards only go on a Q40 and won't even compile on x86.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/drivers/input/serio/Config.in linux-2.5.27-ac1/drivers/input/serio/Config.in
--- linux-2.5.27/drivers/input/serio/Config.in	Sat Jul 20 20:11:26 2002
+++ linux-2.5.27-ac1/drivers/input/serio/Config.in	Sun Jul 21 15:38:48 2002
@@ -12,7 +12,9 @@
 fi
 dep_tristate '  Serial port line discipline' CONFIG_SERIO_SERPORT $CONFIG_SERIO 
 dep_tristate '  ct82c710 Aux port controller' CONFIG_SERIO_CT82C710 $CONFIG_SERIO
-dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
+if [ "$CONFIG_Q40" = "y" ]; then
+   dep_tristate '  Q40 keyboard controller' CONFIG_SERIO_Q40KBD $CONFIG_SERIO
+fi
 dep_tristate '  Parallel port keyboard adapter' CONFIG_SERIO_PARKBD $CONFIG_SERIO $CONFIG_PARPORT
 
 if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
