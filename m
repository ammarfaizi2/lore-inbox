Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285666AbSADWdg>; Fri, 4 Jan 2002 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSADWd2>; Fri, 4 Jan 2002 17:33:28 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:7690 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285570AbSADWdP>;
	Fri, 4 Jan 2002 17:33:15 -0500
Date: Fri, 4 Jan 2002 10:01:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: [patch] Assorted kdev_t fixes
Message-ID: <20020104100107.A11585@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes compile, please apply.
									Pavel
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/block/nbd.c linux-swsusp.pre/drivers/block/nbd.c
--- clean-pre/drivers/block/nbd.c	Fri Jan  4 09:18:07 2002
+++ linux-swsusp.pre/drivers/block/nbd.c	Fri Jan  4 09:39:09 2002
@@ -78,7 +78,7 @@
 
 	if (!inode)
 		return -EINVAL;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 
@@ -253,7 +253,7 @@
 		if (req != blkdev_entry_prev_request(&lo->queue_head)) {
 			printk(KERN_ALERT "NBD: I have problem...\n");
 		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[minor(req->rq_dev)]) {
 			printk(KERN_ALERT "NBD: request corrupted!\n");
 			continue;
 		}
@@ -291,7 +291,7 @@
 			printk( KERN_ALERT "NBD: panic, panic, panic\n" );
 			break;
 		}
-		if (lo != &nbd_dev[MINOR(req->rq_dev)]) {
+		if (lo != &nbd_dev[minor(req->rq_dev)]) {
 			printk(KERN_ALERT "NBD: request corrupted when clearing!\n");
 			continue;
 		}
@@ -328,7 +328,7 @@
 		if (!req)
 			FAIL("que not empty but no request?");
 #endif
-		dev = MINOR(req->rq_dev);
+		dev = minor(req->rq_dev);
 #ifdef PARANOIA
 		if (dev >= MAX_NBD)
 			FAIL("Minor too big.");		/* Probably can not happen */
@@ -381,7 +381,7 @@
 		return -EPERM;
 	if (!inode)
 		return -EINVAL;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 
@@ -473,7 +473,7 @@
 
 	if (!inode)
 		return -ENODEV;
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_NBD)
 		return -ENODEV;
 	lo = &nbd_dev[dev];
@@ -528,7 +528,7 @@
 		nbd_blksize_bits[i] = 10;
 		nbd_bytesizes[i] = 0x7ffffc00; /* 2GB */
 		nbd_sizes[i] = nbd_bytesizes[i] >> BLOCK_SIZE_BITS;
-		register_disk(NULL, MKDEV(MAJOR_NR,i), 1, &nbd_fops,
+		register_disk(NULL, mk_kdev(MAJOR_NR,i), 1, &nbd_fops,
 				nbd_bytesizes[i]>>9);
 	}
 	devfs_handle = devfs_mk_dir (NULL, "nbd", NULL);
Only in linux-swsusp.pre/drivers/char: consolemap_deftbl.c
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/char/serial.c linux-swsusp.pre/drivers/char/serial.c
--- clean-pre/drivers/char/serial.c	Fri Jan  4 09:18:08 2002
+++ linux-swsusp.pre/drivers/char/serial.c	Fri Jan  4 09:41:48 2002
@@ -5827,7 +5827,7 @@
 
 static kdev_t serial_console_device(struct console *c)
 {
-	return MKDEV(TTY_MAJOR, 64 + c->index);
+	return mk_kdev(TTY_MAJOR, 64 + c->index);
 }
 
 /*
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/media/video/tvmixer.c linux-swsusp.pre/drivers/media/video/tvmixer.c
--- clean-pre/drivers/media/video/tvmixer.c	Wed Oct 17 23:19:20 2001
+++ linux-swsusp.pre/drivers/media/video/tvmixer.c	Fri Jan  4 09:43:16 2002
@@ -177,7 +177,7 @@
 
 static int tvmixer_open(struct inode *inode, struct file *file)
 {
-        int i, minor = MINOR(inode->i_rdev);
+        int i, minor = minor(inode->i_rdev);
         struct TVMIXER *mix = NULL;
 	struct i2c_client *client = NULL;
 
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: gentbl
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_afsk1200.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_afsk2400_7.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_afsk2400_8.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_afsk2666.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_fsk9600.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_hapn4800.h
Only in linux-swsusp.pre/drivers/net/hamradio/soundmodem: sm_tbl_psk4800.h
Only in linux-swsusp.pre/drivers/pci: classlist.h
Only in linux-swsusp.pre/drivers/pci: devlist.h
Only in linux-swsusp.pre/drivers/pci: gen-devlist
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/sound/emu10k1/audio.c linux-swsusp.pre/drivers/sound/emu10k1/audio.c
--- clean-pre/drivers/sound/emu10k1/audio.c	Tue Oct  9 19:53:17 2001
+++ linux-swsusp.pre/drivers/sound/emu10k1/audio.c	Fri Jan  4 09:44:49 2002
@@ -1098,7 +1098,7 @@
 
 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 	struct emu10k1_wavedevice *wave_dev;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/sound/emu10k1/midi.c linux-swsusp.pre/drivers/sound/emu10k1/midi.c
--- clean-pre/drivers/sound/emu10k1/midi.c	Tue Oct  9 19:53:18 2001
+++ linux-swsusp.pre/drivers/sound/emu10k1/midi.c	Fri Jan  4 09:45:23 2002
@@ -87,7 +87,7 @@
 
 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct emu10k1_mididevice *midi_dev;
 	struct list_head *entry;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/sound/emu10k1/mixer.c linux-swsusp.pre/drivers/sound/emu10k1/mixer.c
--- clean-pre/drivers/sound/emu10k1/mixer.c	Tue Oct  9 19:53:18 2001
+++ linux-swsusp.pre/drivers/sound/emu10k1/mixer.c	Fri Jan  4 09:46:38 2002
@@ -640,7 +640,7 @@
 
 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/drivers/sound/via82cxxx_audio.c linux-swsusp.pre/drivers/sound/via82cxxx_audio.c
--- clean-pre/drivers/sound/via82cxxx_audio.c	Wed Dec 19 22:38:14 2001
+++ linux-swsusp.pre/drivers/sound/via82cxxx_audio.c	Fri Jan  4 09:47:19 2002
@@ -1358,7 +1358,7 @@
 
 static int via_mixer_open (struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct pci_driver *drvr;
@@ -2974,7 +2974,7 @@
 
 static int via_dsp_open (struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct via_channel *chan;
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean-pre/fs/coda/psdev.c linux-swsusp.pre/fs/coda/psdev.c
--- clean-pre/fs/coda/psdev.c	Fri Jan  4 09:18:10 2002
+++ linux-swsusp.pre/fs/coda/psdev.c	Fri Jan  4 09:48:50 2002
@@ -293,7 +293,7 @@
 	int idx;
 
 	lock_kernel();
-	idx = MINOR(inode->i_rdev);
+	idx = minor(inode->i_rdev);
 	if(idx >= MAX_CODADEVS) {
 		unlock_kernel();
 		return -ENODEV;

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
