Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271633AbRHUKJJ>; Tue, 21 Aug 2001 06:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271631AbRHUKI7>; Tue, 21 Aug 2001 06:08:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:11278 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271630AbRHUKIx>;
	Tue, 21 Aug 2001 06:08:53 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Juha =?ISO-8859-1?Q?Yrj=F6l=E4?= <jyrjola@cc.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.9 emu10k1 circular dependency
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Aug 2001 20:09:02 +1000
Message-ID: <2271.998388542@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.9 drivers/sound/emu10k1/passthrough.h includes hwaccess.h which
includes passthrough.h.  Since passthrough.h is only called from two
sources, both of which already include hwaccess.h, remove hwaccess.h
from passthrough.h and remove passthrough.h from the sources.

Index: 9.1/drivers/sound/emu10k1/audio.c
--- 9.1/drivers/sound/emu10k1/audio.c Tue, 21 Aug 2001 16:48:26 +1000 kaos (linux-2.4/M/b/33_audio.c 1.3.2.1.1.1.1.4 644)
+++ 9.1(w)/drivers/sound/emu10k1/audio.c Tue, 21 Aug 2001 20:07:15 +1000 kaos (linux-2.4/M/b/33_audio.c 1.3.2.1.1.1.1.4 644)
@@ -49,7 +49,6 @@
 #include "irqmgr.h"
 #include "audio.h"
 #include "8010.h"
-#include "passthrough.h"
 
 static void calculate_ofrag(struct woinst *);
 static void calculate_ifrag(struct wiinst *);
Index: 9.1/drivers/sound/emu10k1/passthrough.h
--- 9.1/drivers/sound/emu10k1/passthrough.h Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/Q/e/0_passthroug 1.1.1.1 644)
+++ 9.1(w)/drivers/sound/emu10k1/passthrough.h Tue, 21 Aug 2001 20:07:33 +1000 kaos (linux-2.4/Q/e/0_passthroug 1.1.1.1 644)
@@ -32,7 +32,6 @@
 #ifndef _PASSTHROUGH_H
 #define _PASSTHROUGH_H
 
-#include "hwaccess.h"
 #include "audio.h"
 
 /* number of 16-bit stereo samples in XTRAM buffer */
Index: 9.1/drivers/sound/emu10k1/passthrough.c
--- 9.1/drivers/sound/emu10k1/passthrough.c Sat, 11 Aug 2001 14:45:11 +1000 kaos (linux-2.4/Q/e/1_passthroug 1.1 644)
+++ 9.1(w)/drivers/sound/emu10k1/passthrough.c Tue, 21 Aug 2001 20:07:25 +1000 kaos (linux-2.4/Q/e/1_passthroug 1.1 644)
@@ -47,7 +47,6 @@
 #include "irqmgr.h"
 #include "audio.h"
 #include "8010.h"
-#include "passthrough.h"
 
 static void pt_putsamples(struct pt_data *pt, u16 *ptr, u16 left, u16 right)
 {

