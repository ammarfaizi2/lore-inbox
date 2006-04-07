Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWDGAbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWDGAbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 20:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWDGAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 20:31:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57351 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932242AbWDGAbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 20:31:07 -0400
Date: Fri, 7 Apr 2006 02:31:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] move EXPORT_SYMBOL's away from sound/pci/emu10k1/emu10k1_main.c
Message-ID: <20060407003105.GG7118@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the EXPORT_SYMBOL's from 
sound/pci/emu10k1/emu10k1_main.c to the files with the actual functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/emu10k1/emu10k1_main.c |   12 ------------
 sound/pci/emu10k1/io.c           |    2 ++
 sound/pci/emu10k1/memory.c       |    6 ++++++
 sound/pci/emu10k1/voice.c        |    3 +++
 4 files changed, 11 insertions(+), 12 deletions(-)

--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/emu10k1_main.c.old	2006-04-07 01:08:22.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/emu10k1_main.c	2006-04-07 01:08:32.000000000 +0200
@@ -1419,15 +1419,3 @@
 }
 #endif
 
-/* memory.c */
-EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
-EXPORT_SYMBOL(snd_emu10k1_synth_free);
-EXPORT_SYMBOL(snd_emu10k1_synth_bzero);
-EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
-EXPORT_SYMBOL(snd_emu10k1_memblk_map);
-/* voice.c */
-EXPORT_SYMBOL(snd_emu10k1_voice_alloc);
-EXPORT_SYMBOL(snd_emu10k1_voice_free);
-/* io.c */
-EXPORT_SYMBOL(snd_emu10k1_ptr_read);
-EXPORT_SYMBOL(snd_emu10k1_ptr_write);
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/memory.c.old	2006-04-07 01:09:12.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/memory.c	2006-04-07 01:10:01.000000000 +0200
@@ -286,6 +286,7 @@
 	spin_unlock_irqrestore(&emu->memblk_lock, flags);
 	return err;
 }
+EXPORT_SYMBOL(snd_emu10k1_memblk_map);
 
 /*
  * page allocation for DMA
@@ -386,6 +387,7 @@
 	mutex_unlock(&hdr->block_mutex);
 	return (struct snd_util_memblk *)blk;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
 
 
 /*
@@ -408,6 +410,7 @@
 	mutex_unlock(&hdr->block_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_free);
 
 
 /* check new allocation range */
@@ -539,6 +542,7 @@
 	} while (offset < end_offset);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_bzero);
 
 /*
  * copy_from_user(blk + offset, data, size)
@@ -568,3 +572,5 @@
 	} while (offset < end_offset);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
+
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/voice.c.old	2006-04-07 01:10:14.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/voice.c	2006-04-07 01:10:35.000000000 +0200
@@ -138,6 +138,7 @@
 
 	return result;
 }
+EXPORT_SYMBOL(snd_emu10k1_voice_alloc);
 
 int snd_emu10k1_voice_free(struct snd_emu10k1 *emu,
 			   struct snd_emu10k1_voice *pvoice)
@@ -153,3 +154,5 @@
 	spin_unlock_irqrestore(&emu->voice_lock, flags);
 	return 0;
 }
+EXPORT_SYMBOL(snd_emu10k1_voice_free);
+
--- linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/io.c.old	2006-04-07 01:10:46.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/sound/pci/emu10k1/io.c	2006-04-07 02:19:43.000000000 +0200
@@ -61,6 +61,7 @@
 		return val;
 	}
 }
+EXPORT_SYMBOL(snd_emu10k1_ptr_read);
 
 void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned int chn, unsigned int data)
 {
@@ -91,6 +92,7 @@
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
 	}
 }
+EXPORT_SYMBOL(snd_emu10k1_ptr_write);
 
 unsigned int snd_emu10k1_ptr20_read(struct snd_emu10k1 * emu, 
 					  unsigned int reg, 
