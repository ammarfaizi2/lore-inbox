Return-Path: <linux-kernel-owner+w=401wt.eu-S1755145AbWL3PoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbWL3PoW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbWL3PoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 10:44:22 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:26714 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755145AbWL3PoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 10:44:21 -0500
Message-Id: <20061230154318.694072000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sat, 30 Dec 2006 07:43:18 -0800
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] compile error in drivers/media/video
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  LD      drivers/media/video/built-in.o
drivers/media/video/saa7134/built-in.o:(.data+0x86ac): multiple definition of `ir_rc5_remote_gap'
drivers/media/video/bt8xx/built-in.o:(.data+0x71b4): first defined here
drivers/media/video/saa7134/built-in.o:(.data+0x86b0): multiple definition of `ir_rc5_key_timeout'
drivers/media/video/bt8xx/built-in.o:(.data+0x71b8): first defined here
make[2]: *** [drivers/media/video/built-in.o] Error 1
make[1]: *** [drivers/media/video] Error 2
make: *** [drivers/media/] Error 2

Looks like something was unfinished here. I just made the two variables
static.


Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 drivers/media/video/bt8xx/bttv-input.c      |    4 ++--
 drivers/media/video/saa7134/saa7134-input.c |    4 ++--
 include/media/ir-common.h                   |    3 ---
 3 files changed, 4 insertions(+), 7 deletions(-)

Index: linux-2.6.19/drivers/media/video/bt8xx/bttv-input.c
===================================================================
--- linux-2.6.19.orig/drivers/media/video/bt8xx/bttv-input.c
+++ linux-2.6.19/drivers/media/video/bt8xx/bttv-input.c
@@ -36,9 +36,9 @@ module_param(repeat_delay, int, 0644);
 static int repeat_period = 33;
 module_param(repeat_period, int, 0644);
 
-int ir_rc5_remote_gap = 885;
+static int ir_rc5_remote_gap = 885;
 module_param(ir_rc5_remote_gap, int, 0644);
-int ir_rc5_key_timeout = 200;
+static int ir_rc5_key_timeout = 200;
 module_param(ir_rc5_key_timeout, int, 0644);
 
 #define DEVNAME "bttv-input"
Index: linux-2.6.19/drivers/media/video/saa7134/saa7134-input.c
===================================================================
--- linux-2.6.19.orig/drivers/media/video/saa7134/saa7134-input.c
+++ linux-2.6.19/drivers/media/video/saa7134/saa7134-input.c
@@ -41,9 +41,9 @@ static int pinnacle_remote = 0;
 module_param(pinnacle_remote, int, 0644);    /* Choose Pinnacle PCTV remote */
 MODULE_PARM_DESC(pinnacle_remote, "Specify Pinnacle PCTV remote: 0=coloured, 1=grey (defaults to 0)");
 
-int ir_rc5_remote_gap = 885;
+static int ir_rc5_remote_gap = 885;
 module_param(ir_rc5_remote_gap, int, 0644);
-int ir_rc5_key_timeout = 115;
+static int ir_rc5_key_timeout = 115;
 module_param(ir_rc5_key_timeout, int, 0644);
 
 #define dprintk(fmt, arg...)	if (ir_debug) \
Index: linux-2.6.19/include/media/ir-common.h
===================================================================
--- linux-2.6.19.orig/include/media/ir-common.h
+++ linux-2.6.19/include/media/ir-common.h
@@ -36,9 +36,6 @@
 #define IR_KEYCODE(tab,code)	(((unsigned)code < IR_KEYTAB_SIZE) \
 				 ? tab[code] : KEY_RESERVED)
 
-extern int ir_rc5_remote_gap;
-extern int ir_rc5_key_timeout;
-
 #define RC5_START(x)	(((x)>>12)&3)
 #define RC5_TOGGLE(x)	(((x)>>11)&1)
 #define RC5_ADDR(x)	(((x)>>6)&31)
--
