Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUIAQuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUIAQuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUIAP4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:40 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1459 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267345AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMwt000680@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove pointless code from ALSA emu10k1 midi driver.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/emu10k1/midi.c linux-2.6/sound/oss/emu10k1/midi.c
--- bk-linus/sound/oss/emu10k1/midi.c	2004-08-09 13:12:18.000000000 +0100
+++ linux-2.6/sound/oss/emu10k1/midi.c	2004-08-23 14:08:26.000000000 +0100
@@ -320,7 +320,6 @@ static ssize_t emu10k1_midi_write(struct
 {
 	struct emu10k1_mididevice *midi_dev = (struct emu10k1_mididevice *) file->private_data;
 	struct midi_hdr *midihdr;
-	ssize_t ret = 0;
 	unsigned long flags;
 
 	DPD(4, "emu10k1_midi_write(), count=%#x\n", (u32) count);
@@ -344,7 +343,7 @@ static ssize_t emu10k1_midi_write(struct
 	if (copy_from_user(midihdr->data, buffer, count)) {
 		kfree(midihdr->data);
 		kfree(midihdr);
-		return ret ? ret : -EFAULT;
+		return -EFAULT;
 	}
 
 	spin_lock_irqsave(&midi_spinlock, flags);
