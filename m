Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268920AbRHLCZF>; Sat, 11 Aug 2001 22:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbRHLCYy>; Sat, 11 Aug 2001 22:24:54 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35087 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268920AbRHLCYk>;
	Sat, 11 Aug 2001 22:24:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sun, 12 Aug 2001 01:03:00 +1000."
             <1904.997542180@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 12:24:46 +1000
Message-ID: <7130.997583086@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fixes against 2.4.8 + kbuild-2.5-2.4.8-1.  I will put up a -2 later
today.

Index: 8.7/drivers/sound/emu10k1/Makefile.in
--- 8.7/drivers/sound/emu10k1/Makefile.in Sat, 11 Aug 2001 22:55:17 +1000 kaos (linux-2.4/G/d/38_Makefile.i 1.2 644)
+++ 8.7(w)/drivers/sound/emu10k1/Makefile.in Sun, 12 Aug 2001 12:21:44 +1000 kaos (linux-2.4/G/d/38_Makefile.i 1.2 644)
@@ -3,8 +3,9 @@
 #
 # 12 Apr 2000 Rui Sousa
 
-objlink(emu10k1.o efxmgr.o emuadxmg.o hwaccess.o irqmgr.o joystick.o main.o
-	midi.o mixer.o passthrough.o recmgr.o timer.o voicemgr.o)
+objlink(emu10k1.o audio.o cardmi.o cardmo.o cardwi.o cardwo.o ecard.o efxmgr.o
+        emuadxmg.o hwaccess.o irqmgr.o joystick.o main.o midi.o mixer.o
+        passthrough.o recmgr.o timer.o voicemgr.o)
 
 select(CONFIG_SOUND_EMU10K1 emu10k1.o)
 
Index: 8.7/scripts/pp_makefile2.c
--- 8.7/scripts/pp_makefile2.c Sat, 11 Aug 2001 22:45:22 +1000 kaos (linux-2.4/I/d/36_pp_makefil 1.24 644)
+++ 8.7(w)/scripts/pp_makefile2.c Sun, 12 Aug 2001 11:43:58 +1000 kaos (linux-2.4/I/d/36_pp_makefil 1.24 644)
@@ -754,7 +754,10 @@ int special_oais(PP_DIRENT *dirent, PP_D
   }
   if (dirent->value.db) {
     DB *db = db_list[dirent->value.db];
-    if (!dirent->istarget) {
+    /* FIXME: when the go faster stripes are added, make sure that
+     * dirent->istarget and db->istarget are synced earlier.
+     */
+    if (!db->istarget && !dirent->istarget) {
       return(0);
     }
     switch (type) {

