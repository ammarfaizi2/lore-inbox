Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbTDBPCq>; Wed, 2 Apr 2003 10:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263027AbTDBPCq>; Wed, 2 Apr 2003 10:02:46 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:60935 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S263026AbTDBPCm>; Wed, 2 Apr 2003 10:02:42 -0500
Date: Wed, 2 Apr 2003 09:14:06 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] C99 initializers for sound/oss/emu10k1
Message-ID: <20030402151406.GE22242@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here are a set of patches for converting files in sound/oss/emu10k1 to
use C99 initializers. The patches are against the current BK.

Art Haas

===== sound/oss/emu10k1/audio.c 1.14 vs edited =====
--- 1.14/sound/oss/emu10k1/audio.c	Thu Mar 13 18:52:26 2003
+++ edited/sound/oss/emu10k1/audio.c	Tue Apr  1 19:44:13 2003
@@ -1020,7 +1020,7 @@
 }
 
 struct vm_operations_struct emu10k1_mm_ops = {
-	nopage:         emu10k1_mm_nopage,
+	.nopage         = emu10k1_mm_nopage,
 };
 
 static int emu10k1_audio_mmap(struct file *file, struct vm_area_struct *vma)
@@ -1558,13 +1558,13 @@
 }
 
 struct file_operations emu10k1_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		emu10k1_audio_read,
-	write:		emu10k1_audio_write,
-	poll:		emu10k1_audio_poll,
-	ioctl:		emu10k1_audio_ioctl,
-	mmap:		emu10k1_audio_mmap,
-	open:		emu10k1_audio_open,
-	release:	emu10k1_audio_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= emu10k1_audio_read,
+	.write		= emu10k1_audio_write,
+	.poll		= emu10k1_audio_poll,
+	.ioctl		= emu10k1_audio_ioctl,
+	.mmap		= emu10k1_audio_mmap,
+	.open		= emu10k1_audio_open,
+	.release	= emu10k1_audio_release,
 };
===== sound/oss/emu10k1/main.c 1.13 vs edited =====
--- 1.13/sound/oss/emu10k1/main.c	Sun Feb 16 18:30:06 2003
+++ edited/sound/oss/emu10k1/main.c	Tue Apr  1 19:44:27 2003
@@ -1144,10 +1144,10 @@
 MODULE_LICENSE("GPL");
 
 static struct pci_driver emu10k1_pci_driver = {
-	name:		"emu10k1",
-	id_table:	emu10k1_pci_tbl,
-	probe:		emu10k1_probe,
-	remove:		__devexit_p(emu10k1_remove),
+	.name		= "emu10k1",
+	.id_table	= emu10k1_pci_tbl,
+	.probe		= emu10k1_probe,
+	.remove		= __devexit_p(emu10k1_remove),
 };
 
 static int __init emu10k1_init_module(void)
===== sound/oss/emu10k1/midi.c 1.10 vs edited =====
--- 1.10/sound/oss/emu10k1/midi.c	Thu Mar 13 18:52:26 2003
+++ edited/sound/oss/emu10k1/midi.c	Tue Apr  1 19:44:42 2003
@@ -465,12 +465,12 @@
 
 /* MIDI file operations */
 struct file_operations emu10k1_midi_fops = {
-	owner:		THIS_MODULE,
-	read:		emu10k1_midi_read,
-	write:		emu10k1_midi_write,
-	poll:		emu10k1_midi_poll,
-	open:		emu10k1_midi_open,
-	release:	emu10k1_midi_release,
+	.owner		= THIS_MODULE,
+	.read		= emu10k1_midi_read,
+	.write		= emu10k1_midi_write,
+	.poll		= emu10k1_midi_poll,
+	.open		= emu10k1_midi_open,
+	.release	= emu10k1_midi_release,
 };
 
 
===== sound/oss/emu10k1/mixer.c 1.6 vs edited =====
--- 1.6/sound/oss/emu10k1/mixer.c	Thu Mar 13 18:52:26 2003
+++ edited/sound/oss/emu10k1/mixer.c	Tue Apr  1 19:44:55 2003
@@ -675,9 +675,9 @@
 }
 
 struct file_operations emu10k1_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		emu10k1_mixer_ioctl,
-	open:		emu10k1_mixer_open,
-	release:	emu10k1_mixer_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= emu10k1_mixer_ioctl,
+	.open		= emu10k1_mixer_open,
+	.release	= emu10k1_mixer_release,
 };
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
