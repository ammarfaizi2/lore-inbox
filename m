Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVINDxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVINDxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 23:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVINDxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 23:53:06 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:34357 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932583AbVINDxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 23:53:05 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] add PCI IDs so RME32 and RME96 drivers build
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 13 Sep 2005 20:52:53 -0700
Message-ID: <52r7bs2tm2.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Sep 2005 03:52:54.0888 (UTC) FILETIME=[C9912E80:01C5B8DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While doing an allyesconfig build, I noticed that the commit

    commit 8cdfd2519c6c9a1e6057dc5970b2542b35895738
    Author: Takashi Iwai <tiwai@suse.de>
    Date:   Wed Sep 7 14:08:11 2005 +0200
    
        [ALSA] Remove superfluous PCI ID definitions

broke the RME32 and RME96 drivers, since the PCI IDs they use seem to
have changed names.  Here's a patch to fix this -- compile tested
only, since I have no idea what the hardware even is.


Fix the build of the RME32 and RME96 drivers by having them use the
PCI_DEVICE_ID_RME_xxx names defined in <linux/pci_ids.h> instead of
the PCI_DEVICE_ID_xxx names that they used to define themselves.

Also fix the typo in the id PCI_DEVICE_IDRME__DIGI96_8_PAD_OR_PST
so the name is PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1355,7 +1355,7 @@
 #define PCI_DEVICE_ID_RME_DIGI96	0x3fc0
 #define PCI_DEVICE_ID_RME_DIGI96_8	0x3fc1
 #define PCI_DEVICE_ID_RME_DIGI96_8_PRO	0x3fc2
-#define PCI_DEVICE_IDRME__DIGI96_8_PAD_OR_PST 0x3fc3
+#define PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST 0x3fc3
 #define PCI_DEVICE_ID_XILINX_HAMMERFALL	0x3fc4
 #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP 0x3fc5
 #define PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP_MADI 0x3fc6
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -228,11 +228,11 @@ typedef struct snd_rme32 {
 } rme32_t;
 
 static struct pci_device_id snd_rme32_ids[] = {
-	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_DIGI32,
+	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_RME_DIGI32,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
-	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_DIGI32_8,
+	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_RME_DIGI32_8,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
-	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_DIGI32_PRO,
+	{PCI_VENDOR_ID_XILINX_RME, PCI_DEVICE_ID_RME_DIGI32_PRO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},
 	{0,}
 };
@@ -240,7 +240,7 @@ static struct pci_device_id snd_rme32_id
 MODULE_DEVICE_TABLE(pci, snd_rme32_ids);
 
 #define RME32_ISWORKING(rme32) ((rme32)->wcreg & RME32_WCR_START)
-#define RME32_PRO_WITH_8414(rme32) ((rme32)->pci->device == PCI_DEVICE_ID_DIGI32_PRO && (rme32)->rev == RME32_PRO_REVISION_WITH_8414)
+#define RME32_PRO_WITH_8414(rme32) ((rme32)->pci->device == PCI_DEVICE_ID_RME_DIGI32_PRO && (rme32)->rev == RME32_PRO_REVISION_WITH_8414)
 
 static int snd_rme32_playback_prepare(snd_pcm_substream_t * substream);
 
@@ -527,21 +527,21 @@ static int snd_rme32_playback_setrate(rm
 			RME32_WCR_FREQ_1;
 		break;
 	case 64000:
-		if (rme32->pci->device != PCI_DEVICE_ID_DIGI32_PRO)
+		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
 		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) & 
 			~RME32_WCR_FREQ_1;
 		break;
 	case 88200:
-		if (rme32->pci->device != PCI_DEVICE_ID_DIGI32_PRO)
+		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
 		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_1) & 
 			~RME32_WCR_FREQ_0;
 		break;
 	case 96000:
-		if (rme32->pci->device != PCI_DEVICE_ID_DIGI32_PRO)
+		if (rme32->pci->device != PCI_DEVICE_ID_RME_DIGI32_PRO)
 			return -EINVAL;
 		rme32->wcreg |= RME32_WCR_DS_BM;
 		rme32->wcreg = (rme32->wcreg | RME32_WCR_FREQ_0) | 
@@ -881,7 +881,7 @@ static int snd_rme32_playback_spdif_open
 		runtime->hw = snd_rme32_spdif_fd_info;
 	else
 		runtime->hw = snd_rme32_spdif_info;
-	if (rme32->pci->device == PCI_DEVICE_ID_DIGI32_PRO) {
+	if (rme32->pci->device == PCI_DEVICE_ID_RME_DIGI32_PRO) {
 		runtime->hw.rates |= SNDRV_PCM_RATE_64000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000;
 		runtime->hw.rate_max = 96000;
 	}
@@ -1408,8 +1408,8 @@ static int __devinit snd_rme32_create(rm
 	}
 
 	/* set up ALSA pcm device for ADAT */
-	if ((pci->device == PCI_DEVICE_ID_DIGI32) ||
-	    (pci->device == PCI_DEVICE_ID_DIGI32_PRO)) {
+	if ((pci->device == PCI_DEVICE_ID_RME_DIGI32) ||
+	    (pci->device == PCI_DEVICE_ID_RME_DIGI32_PRO)) {
 		/* ADAT is not available on DIGI32 and DIGI32 Pro */
 		rme32->adat_pcm = NULL;
 	}
@@ -1639,11 +1639,11 @@ snd_rme32_info_inputtype_control(snd_kco
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	switch (rme32->pci->device) {
-	case PCI_DEVICE_ID_DIGI32:
-	case PCI_DEVICE_ID_DIGI32_8:
+	case PCI_DEVICE_ID_RME_DIGI32:
+	case PCI_DEVICE_ID_RME_DIGI32_8:
 		uinfo->value.enumerated.items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI32_PRO:
+	case PCI_DEVICE_ID_RME_DIGI32_PRO:
 		uinfo->value.enumerated.items = 4;
 		break;
 	default:
@@ -1670,11 +1670,11 @@ snd_rme32_get_inputtype_control(snd_kcon
 	ucontrol->value.enumerated.item[0] = snd_rme32_getinputtype(rme32);
 
 	switch (rme32->pci->device) {
-	case PCI_DEVICE_ID_DIGI32:
-	case PCI_DEVICE_ID_DIGI32_8:
+	case PCI_DEVICE_ID_RME_DIGI32:
+	case PCI_DEVICE_ID_RME_DIGI32_8:
 		items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI32_PRO:
+	case PCI_DEVICE_ID_RME_DIGI32_PRO:
 		items = 4;
 		break;
 	default:
@@ -1697,11 +1697,11 @@ snd_rme32_put_inputtype_control(snd_kcon
 	int change, items = 3;
 
 	switch (rme32->pci->device) {
-	case PCI_DEVICE_ID_DIGI32:
-	case PCI_DEVICE_ID_DIGI32_8:
+	case PCI_DEVICE_ID_RME_DIGI32:
+	case PCI_DEVICE_ID_RME_DIGI32_8:
 		items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI32_PRO:
+	case PCI_DEVICE_ID_RME_DIGI32_PRO:
 		items = 4;
 		break;
 	default:
@@ -1982,13 +1982,13 @@ snd_rme32_probe(struct pci_dev *pci, con
 
 	strcpy(card->driver, "Digi32");
 	switch (rme32->pci->device) {
-	case PCI_DEVICE_ID_DIGI32:
+	case PCI_DEVICE_ID_RME_DIGI32:
 		strcpy(card->shortname, "RME Digi32");
 		break;
-	case PCI_DEVICE_ID_DIGI32_8:
+	case PCI_DEVICE_ID_RME_DIGI32_8:
 		strcpy(card->shortname, "RME Digi32/8");
 		break;
-	case PCI_DEVICE_ID_DIGI32_PRO:
+	case PCI_DEVICE_ID_RME_DIGI32_PRO:
 		strcpy(card->shortname, "RME Digi32 PRO");
 		break;
 	}
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -233,13 +233,13 @@ typedef struct snd_rme96 {
 } rme96_t;
 
 static struct pci_device_id snd_rme96_ids[] = {
-	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96,
+	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96_8,
+	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96_8,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96_8_PRO,
+	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96_8_PRO,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST,
+	{ PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, }, 
 	{ 0, }
 };
@@ -248,12 +248,12 @@ MODULE_DEVICE_TABLE(pci, snd_rme96_ids);
 
 #define RME96_ISPLAYING(rme96) ((rme96)->wcreg & RME96_WCR_START)
 #define RME96_ISRECORDING(rme96) ((rme96)->wcreg & RME96_WCR_START_2)
-#define	RME96_HAS_ANALOG_IN(rme96) ((rme96)->pci->device == PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST)
-#define	RME96_HAS_ANALOG_OUT(rme96) ((rme96)->pci->device == PCI_DEVICE_ID_DIGI96_8_PRO || \
-				     (rme96)->pci->device == PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST)
+#define	RME96_HAS_ANALOG_IN(rme96) ((rme96)->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST)
+#define	RME96_HAS_ANALOG_OUT(rme96) ((rme96)->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PRO || \
+				     (rme96)->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST)
 #define	RME96_DAC_IS_1852(rme96) (RME96_HAS_ANALOG_OUT(rme96) && (rme96)->rev >= 4)
-#define	RME96_DAC_IS_1855(rme96) (((rme96)->pci->device == PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST && (rme96)->rev < 4) || \
-			          ((rme96)->pci->device == PCI_DEVICE_ID_DIGI96_8_PRO && (rme96)->rev == 2))
+#define	RME96_DAC_IS_1855(rme96) (((rme96)->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST && (rme96)->rev < 4) || \
+			          ((rme96)->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PRO && (rme96)->rev == 2))
 #define	RME96_185X_MAX_OUT(rme96) ((1 << (RME96_DAC_IS_1852(rme96) ? RME96_AD1852_VOL_BITS : RME96_AD1855_VOL_BITS)) - 1)
 
 static int
@@ -830,9 +830,9 @@ snd_rme96_setinputtype(rme96_t *rme96,
 			RME96_WCR_INP_1;
 		break;
 	case RME96_INPUT_XLR:
-		if ((rme96->pci->device != PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST &&
-		     rme96->pci->device != PCI_DEVICE_ID_DIGI96_8_PRO) ||
-		    (rme96->pci->device == PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST &&
+		if ((rme96->pci->device != PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST &&
+		     rme96->pci->device != PCI_DEVICE_ID_RME_DIGI96_8_PRO) ||
+		    (rme96->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST &&
 		     rme96->rev > 4))
 		{
 			/* Only Digi96/8 PRO and Digi96/8 PAD supports XLR */
@@ -1598,7 +1598,7 @@ snd_rme96_create(rme96_t *rme96)
 	rme96->spdif_pcm->info_flags = 0;
 
 	/* set up ALSA pcm device for ADAT */
-	if (pci->device == PCI_DEVICE_ID_DIGI96) {
+	if (pci->device == PCI_DEVICE_ID_RME_DIGI96) {
 		/* ADAT is not available on the base model */
 		rme96->adat_pcm = NULL;
 	} else {
@@ -1858,14 +1858,14 @@ snd_rme96_info_inputtype_control(snd_kco
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
 	switch (rme96->pci->device) {
-	case PCI_DEVICE_ID_DIGI96:
-	case PCI_DEVICE_ID_DIGI96_8:
+	case PCI_DEVICE_ID_RME_DIGI96:
+	case PCI_DEVICE_ID_RME_DIGI96_8:
 		uinfo->value.enumerated.items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PRO:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PRO:
 		uinfo->value.enumerated.items = 4;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST:
 		if (rme96->rev > 4) {
 			/* PST */
 			uinfo->value.enumerated.items = 4;
@@ -1895,14 +1895,14 @@ snd_rme96_get_inputtype_control(snd_kcon
 	ucontrol->value.enumerated.item[0] = snd_rme96_getinputtype(rme96);
 	
 	switch (rme96->pci->device) {
-	case PCI_DEVICE_ID_DIGI96:
-	case PCI_DEVICE_ID_DIGI96_8:
+	case PCI_DEVICE_ID_RME_DIGI96:
+	case PCI_DEVICE_ID_RME_DIGI96_8:
 		items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PRO:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PRO:
 		items = 4;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST:
 		if (rme96->rev > 4) {
 			/* for handling PST case, (INPUT_ANALOG is moved to INPUT_XLR */
 			if (ucontrol->value.enumerated.item[0] == RME96_INPUT_ANALOG) {
@@ -1932,14 +1932,14 @@ snd_rme96_put_inputtype_control(snd_kcon
 	int change, items = 3;
 	
 	switch (rme96->pci->device) {
-	case PCI_DEVICE_ID_DIGI96:
-	case PCI_DEVICE_ID_DIGI96_8:
+	case PCI_DEVICE_ID_RME_DIGI96:
+	case PCI_DEVICE_ID_RME_DIGI96_8:
 		items = 3;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PRO:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PRO:
 		items = 4;
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST:
 		if (rme96->rev > 4) {
 			items = 4;
 		} else {
@@ -1953,7 +1953,7 @@ snd_rme96_put_inputtype_control(snd_kcon
 	val = ucontrol->value.enumerated.item[0] % items;
 	
 	/* special case for PST */
-	if (rme96->pci->device == PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST && rme96->rev > 4) {
+	if (rme96->pci->device == PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST && rme96->rev > 4) {
 		if (val == RME96_INPUT_XLR) {
 			val = RME96_INPUT_ANALOG;
 		}
@@ -2375,16 +2375,16 @@ snd_rme96_probe(struct pci_dev *pci,
 	
 	strcpy(card->driver, "Digi96");
 	switch (rme96->pci->device) {
-	case PCI_DEVICE_ID_DIGI96:
+	case PCI_DEVICE_ID_RME_DIGI96:
 		strcpy(card->shortname, "RME Digi96");
 		break;
-	case PCI_DEVICE_ID_DIGI96_8:
+	case PCI_DEVICE_ID_RME_DIGI96_8:
 		strcpy(card->shortname, "RME Digi96/8");
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PRO:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PRO:
 		strcpy(card->shortname, "RME Digi96/8 PRO");
 		break;
-	case PCI_DEVICE_ID_DIGI96_8_PAD_OR_PST:
+	case PCI_DEVICE_ID_RME_DIGI96_8_PAD_OR_PST:
 		pci_read_config_byte(rme96->pci, 8, &val);
 		if (val < 5) {
 			strcpy(card->shortname, "RME Digi96/8 PAD");
