Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264269AbSIVPc0>; Sun, 22 Sep 2002 11:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264296AbSIVPc0>; Sun, 22 Sep 2002 11:32:26 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1152 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264269AbSIVPcZ>;
	Sun, 22 Sep 2002 11:32:25 -0400
Date: Sun, 22 Sep 2002 10:37:34 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: compile error and fix in v_midi.c
Message-ID: <Pine.LNX.4.44.0209221033440.959-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compiling 2.5.3[78] I get the following:

v_midi.c: In function `v_midi_open':
v_midi.c:55: structure has no member named `lock'
v_midi.c:58: structure has no member named `lock'
v_midi.c:62: structure has no member named `lock'
v_midi.c: In function `v_midi_close':
v_midi.c:83: structure has no member named `lock'
v_midi.c:87: structure has no member named `lock'
v_midi.c: In function `attach_v_midi':
v_midi.c:223: structure has no member named `lock'
v_midi.c:244: structure has no member named `lock'
make[2]: *** [v_midi.o] Error 1
make[1]: *** [oss] Error 2
make: *** [sound] Error 2

The following patch fixes that:

--- linux-2.5-tm/sound/oss/v_midi.h.old	Sun Sep 22 10:01:43 2002
+++ linux-2.5-tm/sound/oss/v_midi.h	Sun Sep 22 10:02:48 2002
@@ -11,5 +11,6 @@
 	   int input_opened;
 	   int intr_active;
 	   void (*midi_input_intr) (int dev, unsigned char data);
+	   spinlock_t lock;
 	} vmidi_devc;
 

