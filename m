Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbTGOP2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbTGOP12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:27:28 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:24265 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268932AbTGOP0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:26:11 -0400
Date: Tue, 15 Jul 2003 17:40:47 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][2.6.0-test] fix emu10k1 module oops when being removed
Message-ID: <20030715174046.A18899@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

The emu10k1 module in 2.6.0-test1 and any recent 2.5.X oopses when being
removed because some of the cleanup functions that get called from
emu10k1_remove() are incorrectly marked as __devinit.

This trivial patch solves the problem.

Linus, please apply.

Bye for now.

Rudo.

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="emu10k1-removing-oops.patch"

diff -u linux-2.6.0-test1-vanilla-emu10k1-not-fixed/sound/oss/emu10k1/main.c linux-2.6.0-test1-vanilla/sound/oss/emu10k1/main.c
--- linux-2.6.0-test1-vanilla-emu10k1-not-fixed/sound/oss/emu10k1/main.c	2003-07-14 05:38:46.000000000 +0200
+++ linux-2.6.0-test1-vanilla/sound/oss/emu10k1/main.c	2003-07-15 02:51:13.000000000 +0200
@@ -213,7 +213,7 @@
 	return -ENODEV;
 }
 
-static void __devinit emu10k1_audio_cleanup(struct emu10k1_card *card)
+static void emu10k1_audio_cleanup(struct emu10k1_card *card)
 {
 	unregister_sound_dsp(card->audio_dev1);
 	unregister_sound_dsp(card->audio_dev);
@@ -298,7 +298,7 @@
 	return -EIO;
 }
 
-static void __devinit emu10k1_mixer_cleanup(struct emu10k1_card *card)
+static void emu10k1_mixer_cleanup(struct emu10k1_card *card)
 {
 	char s[32];
 
@@ -402,7 +402,7 @@
 	return ret;
 }
 
-static void __devinit emu10k1_midi_cleanup(struct emu10k1_card *card)
+static void emu10k1_midi_cleanup(struct emu10k1_card *card)
 {
 	tasklet_kill(&card->mpuout->tasklet);
 	kfree(card->mpuout);
@@ -450,7 +450,7 @@
 	card->emupagetable[1] = MAXPAGES - 1;
 }
 
-static void __devinit fx_cleanup(struct patch_manager *mgr)
+static void fx_cleanup(struct patch_manager *mgr)
 {
 	int i;
 	for(i = 0; i < mgr->current_pages; i++)
@@ -967,7 +967,7 @@
 	return 0;
 }
 
-static void __devinit emu10k1_cleanup(struct emu10k1_card *card)
+static void emu10k1_cleanup(struct emu10k1_card *card)
 {
 	int ch;
 

--zhXaljGHf11kAtnf--
