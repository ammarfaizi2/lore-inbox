Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289311AbSAIJqv>; Wed, 9 Jan 2002 04:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSAIJqr>; Wed, 9 Jan 2002 04:46:47 -0500
Received: from [213.171.51.190] ([213.171.51.190]:40843 "EHLO ns.yauza.ru")
	by vger.kernel.org with ESMTP id <S289311AbSAIJqb>;
	Wed, 9 Jan 2002 04:46:31 -0500
Date: Wed, 9 Jan 2002 12:46:26 +0300
From: Nikita Gergel <fc@yauza.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 'MINOR' fix in emu10k1 driver
Message-Id: <20020109124626.56f1dd18.fc@yauza.ru>
Organization: YAUZA-Telecom
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i586-alt-linux)
X-Face: /kH/`k:.@|9\`-o$p/YBn<xFr)I]mglEQW0$I${i4Q;J|JXWbc}de_p8c1;:W~5{WV,.l%B S|A4'A1hnId[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fact emu10k1 driver didn't compile in 2.5.2-pre10.
Sound successfully tested.

-- 
Nikita Gergel					System Administrator
Moscow, Russia					YAUZA-Telecom

===
diff -u --recursive --new-file v2.5.1/linux/drivers/sound/emu10k1/audio.c linux/drivers/sound/emu10k1/audio.c
--- v2.5.1/linux/drivers/sound/emu10k1/audio.c       Tue Oct 9 21:53:00 2001
+++ linux/drivers/sound/emu10k1/audio.c      Wed Jan  9 10:00:00 2002
@@ -1098,7 +1098,7 @@
 
 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int emu_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 	struct emu10k1_wavedevice *wave_dev;
@@ -1110,7 +1110,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (!((card->audio_dev ^ minor) & ~0xf) || !((card->audio_dev1 ^ minor) & ~0xf))
+		if (!((card->audio_dev ^ emu_minor) & ~0xf) || !((card->audio_dev1 ^ emu_minor) & ~0xf))
			goto match;
 	}
 
@@ -1206,7 +1206,7 @@
 		woinst->buffer.fragment_size = 0;
 		woinst->buffer.ossfragshift = 0;
 		woinst->buffer.numfrags = 0;
-		woinst->device = (card->audio_dev1 == minor);
+		woinst->device = (card->audio_dev1 == emu_minor);
 		woinst->timer.state = TIMER_STATE_UNINSTALLED;
 		woinst->num_voices = 1;
 		for (i = 0; i < WAVEOUT_MAXVOICES; i++) {
diff -u --recursive --new-file v2.5.1/linux/drivers/sound/emu10k1/midi.c linux/drivers/sound/emu10k1/midi.c
--- v2.5.1/linux/drivers/sound/emu10k1/midi.c       Tue Oct 9 21:53:00 2001
+++ linux/drivers/sound/emu10k1/midi.c      Wed Jan  9 10:00:00 2002
@@ -87,7 +87,7 @@
 
 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int emu_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct emu10k1_mididevice *midi_dev;
 	struct list_head *entry;
@@ -98,7 +98,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (card->midi_dev == minor)
+		if (card->midi_dev == emu_minor)
 			goto match;
 	}
 
diff -u --recursive --new-file v2.5.1/linux/drivers/sound/emu10k1/mixer.c linux/drivers/sound/emu10k1/mixer.c
--- v2.5.1/linux/drivers/sound/emu10k1/mixer.c       Tue Oct 9 21:53:00 2001
+++ linux/drivers/sound/emu10k1/mixer.c      Wed Jan  9 10:00:00 2002
@@ -640,7 +640,7 @@
 
 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int emu_minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 
@@ -649,7 +649,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (card->ac97.dev_mixer == minor)
+		if (card->ac97.dev_mixer == emu_minor)
 			goto match;
 	}
 
