Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315238AbSETA5L>; Sun, 19 May 2002 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSETA5K>; Sun, 19 May 2002 20:57:10 -0400
Received: from gherkin.frus.com ([192.158.254.49]:9345 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S315238AbSETA5J>;
	Sun, 19 May 2002 20:57:09 -0400
Message-Id: <m179bTr-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.14+ ALSA OSS emulation
To: perex@suse.cz
Date: Sun, 19 May 2002 19:56:55 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.5.14 patchset, the following change was made in
linux/sound/core/Config.in:

-bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
+dep_bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND

This breaks the OSS API emulation for people building their ALSA sound
drivers as modules (CONFIG_SND == "m").  The following patch applied
against the 2.5.16 kernel accomplishes what I think the author intended:

--- linux/sound/core/Config.in.orig	Sun May 19 18:44:34 2002
+++ linux/sound/core/Config.in	Sun May 19 18:45:30 2002
@@ -13,7 +13,9 @@
 if [ "$CONFIG_SND_SEQUENCER" != "n" ]; then
   dep_tristate '  Sequencer dummy client' CONFIG_SND_SEQ_DUMMY $CONFIG_SND_SEQUENCER
 fi
-dep_bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
+if [ "$CONFIG_SND" != "n" ]; then
+  bool '  OSS API emulation' CONFIG_SND_OSSEMUL
+fi
 if [ "$CONFIG_SND_OSSEMUL" = "y" ]; then
   dep_tristate '    OSS Mixer API' CONFIG_SND_MIXER_OSS $CONFIG_SND
   dep_tristate '    OSS PCM API' CONFIG_SND_PCM_OSS $CONFIG_SND

Please apply.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
