Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWHKWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWHKWWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWHKWWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:22:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:58816 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750862AbWHKWWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:22:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lmHDhQcrhNoNis2Hg91GQO8P8QJi7nZ6giDtIc22szKUyMoRmOPWnWc9Kwp5gB3rNSV9XsJRwXNYObKaFWSETWv5aBN0bxbdMRsTBBcfgXitT5QPYjmkz9eTGC9eGRfzVNWLEPO8hvBg9E8mssZSklu9rFHyrFxp5diDQSvVBY8=
Date: Sat, 12 Aug 2006 02:22:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PM=n slim: sound/oss/trident.c
Message-ID: <20060811222250.GI6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/oss/trident.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/sound/oss/trident.c
+++ b/sound/oss/trident.c
@@ -488,10 +488,6 @@ static void ali_set_spdif_out_rate(struc
 static void ali_enable_special_channel(struct trident_state *stat);
 static struct trident_channel *ali_alloc_rec_pcm_channel(struct trident_card *card);
 static struct trident_channel *ali_alloc_pcm_channel(struct trident_card *card);
-static void ali_restore_regs(struct trident_card *card);
-static void ali_save_regs(struct trident_card *card);
-static int trident_suspend(struct pci_dev *dev, pm_message_t unused);
-static int trident_resume(struct pci_dev *dev);
 static void ali_free_pcm_channel(struct trident_card *card, unsigned int channel);
 static int ali_setup_multi_channels(struct trident_card *card, int chan_nums);
 static unsigned int ali_get_spdif_in_rate(struct trident_card *card);
@@ -507,13 +503,6 @@ static int ali_allocate_other_states_res
 					       int chan_nums);
 static void ali_free_other_states_resources(struct trident_state *state);
 
-/* save registers for ALi Power Management */
-static struct ali_saved_registers {
-	unsigned long global_regs[ALI_GLOBAL_REGS];
-	unsigned long channel_regs[ALI_CHANNELS][ALI_CHANNEL_REGS];
-	unsigned mixer_regs[ALI_MIXER_REGS];
-} ali_registers;
-
 #define seek_offset(dma_ptr, buffer, cnt, offset, copy_count)	do { \
         (dma_ptr) += (offset);	  \
 	(buffer) += (offset);	  \
@@ -3653,6 +3642,14 @@ ali_allocate_other_states_resources(stru
 	return 0;
 }
 
+#ifdef CONFIG_PM
+/* save registers for ALi Power Management */
+static struct ali_saved_registers {
+	unsigned long global_regs[ALI_GLOBAL_REGS];
+	unsigned long channel_regs[ALI_CHANNELS][ALI_CHANNEL_REGS];
+	unsigned mixer_regs[ALI_MIXER_REGS];
+} ali_registers;
+
 static void
 ali_save_regs(struct trident_card *card)
 {
@@ -3746,6 +3743,7 @@ trident_resume(struct pci_dev *dev)
 	}
 	return 0;
 }
+#endif
 
 static struct trident_channel *
 ali_alloc_pcm_channel(struct trident_card *card)
@@ -4616,8 +4614,10 @@ static struct pci_driver trident_pci_dri
 	.id_table = trident_pci_tbl,
 	.probe = trident_probe,
 	.remove = __devexit_p(trident_remove),
+#ifdef CONFIG_PM
 	.suspend = trident_suspend,
 	.resume = trident_resume
+#endif
 };
 
 static int __init

