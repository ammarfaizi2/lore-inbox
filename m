Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTIEGEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTIEGEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:04:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2758 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262304AbTIEGEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:04:50 -0400
Date: Fri, 5 Sep 2003 08:04:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] fix KEYBOARD_ATKBD for modular SERIO
Message-ID: <20030905060446.GF1374@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes KEYBOARD_ATKBD for modular SERIO.

Currently on X86 for !EMBEDDED the variable KEYBOARD_ATKBD is wrongly 
set to y if SERIO=m.

Please apply
Adrian

--- linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig.old	2003-09-04 19:03:45.000000000 +0200
+++ linux-2.6.0-test4-mm5-modular-no-smp/drivers/input/keyboard/Kconfig	2003-09-04 19:04:49.000000000 +0200
@@ -13,7 +13,8 @@
 
 config KEYBOARD_ATKBD
 	tristate "AT keyboard support" if EMBEDDED || !X86 
-	default y
+	default y if INPUT=y && INPUT_KEYBOARD=y && SERIO=y
+	default m
 	depends on INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use a standard AT or PS/2 keyboard. Usually
