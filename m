Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbULFSeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbULFSeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbULFSeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:34:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43025 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261603AbULFSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:30:07 -0500
Date: Mon, 6 Dec 2004 19:30:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS: misc cleanups
Message-ID: <20041206183000.GH7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains cleanups under sound/oss/ including the 
following:
- make needlessly global code static
- kill cs4232.h (it contained two function prototypes: one is now static 
  and the other one was already stale)
- removed the following unused global functions:
  - cs4232.c: init_cs4281
  - emu10k1/hwaccess.c: sumVolumeToAttenuation
  - emu10k1/hwaccess.c: emu10k1_set_stop_on_loop
  - sb_common.c: sb_dsp_disable_midi
  - sb_common.c: sb_dsp_disable_recording
  - wavfront.c: attach_wffx
- cs46xx.c: #ifndef CS46XX_ACPI_SUPPORT cs46xx_pm_callback
- emu10k1/hwaccess.c: #ifdef DBGEMU emu10k1_writefn0_2
- opl3sa2.c: remove the unused struct opl3sa2_dev
- removed the following unused EXPORT_SYMBOL's:
  - ac97.c: ac97_set_mixer
  - ac97.c: ac97_get_register
  - ac97.c: ac97_get_mixer_scaled
  - sb_common.c: sb_dsp_disable_midi


diffstat output:
 sound/oss/ac97.c                     |   13 +---
 sound/oss/ac97.h                     |   16 -----
 sound/oss/ad1816.c                   |    7 +-
 sound/oss/ad1848.c                   |    8 +-
 sound/oss/ad1889.c                   |    4 -
 sound/oss/aedsp16.c                  |   10 +--
 sound/oss/awe_wave.c                 |    8 +-
 sound/oss/cs4232.c                   |    3 -
 sound/oss/cs4232.h                   |    3 -
 sound/oss/cs4281/cs4281_wrapper-24.c |    4 -
 sound/oss/cs4281/cs4281m.c           |   38 +++++--------
 sound/oss/cs4281/cs4281pm-24.c       |    6 +-
 sound/oss/cs46xx.c                   |   25 +++++---
 sound/oss/cs46xx_wrapper-24.h        |    2 
 sound/oss/cs46xxpm-24.h              |    1 
 sound/oss/emu10k1/audio.c            |    9 ++-
 sound/oss/emu10k1/audio.h            |    3 -
 sound/oss/emu10k1/cardmi.c           |   59 +++++++++++++-------
 sound/oss/emu10k1/cardmi.h           |   17 ------
 sound/oss/emu10k1/cardwi.c           |    2 
 sound/oss/emu10k1/efxmgr.c           |    4 -
 sound/oss/emu10k1/hwaccess.c         |   38 -------------
 sound/oss/emu10k1/hwaccess.h         |    2 
 sound/oss/emu10k1/main.c             |    4 -
 sound/oss/emu10k1/voicemgr.c         |    3 -
 sound/oss/forte.c                    |    4 -
 sound/oss/gus_wave.c                 |    2 
 sound/oss/maestro.c                  |   10 +--
 sound/oss/maestro3.c                 |   20 +++----
 sound/oss/maestro3.h                 |    4 -
 sound/oss/nm256_audio.c              |    4 -
 sound/oss/opl3sa2.c                  |    5 -
 sound/oss/pas2_card.c                |   10 ---
 sound/oss/pss.c                      |    4 -
 sound/oss/rme96xx.c                  |   26 ++++-----
 sound/oss/sb.h                       |    3 -
 sound/oss/sb_card.c                  |    2 
 sound/oss/sb_common.c                |   11 ---
 sound/oss/sb_ess.c                   |    2 
 sound/oss/sequencer.c                |    2 
 sound/oss/trident.c                  |    3 -
 sound/oss/via82cxxx_audio.c          |    2 
 sound/oss/wavfront.c                 |   76 ++++++++++++---------------
 43 files changed, 193 insertions(+), 286 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/sound/oss/cs4232.h	2004-12-06 17:57:31.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,3 +0,0 @@
-
-int probe_cs4232_mpu (struct address_info *hw_config);
-void attach_cs4232_mpu (struct address_info *hw_config);
--- linux-2.6.10-rc2-mm4-full/sound/oss/ac97.h.old	2004-12-06 17:49:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/ac97.h	2004-12-06 17:51:43.000000000 +0100
@@ -184,26 +184,10 @@
 extern int ac97_set_values (struct ac97_hwint *dev,
 			    struct ac97_mixer_value_list *value_list);
 
-/* Sets one mixer channel OSS_CHANNEL to the scaled value OSS_VALUE.
-   Returns the resulting (rescaled) value, or a negative value
-   representing an error code.
-
-   Stereo channels have two values in OSS_VALUE (the left value is in the
-   lower 8 bits, the right value is in the upper 8 bits). */
-extern int ac97_set_mixer (struct ac97_hwint *dev, int oss_channel,
-			   u16 oss_value);
-
-/* Return the contents of the specified AC97 register REG; it uses the
-   last-written value if it is available.  */
-extern int ac97_get_register (struct ac97_hwint *dev, u8 reg);
-
 /* Writes the specified VALUE to the AC97 register REG in the mixer.
    Takes care of setting the last-written cache as well.  */
 extern int ac97_put_register (struct ac97_hwint *dev, u8 reg, u16 value);
 
-/* Returns the last OSS value written to the OSS_CHANNEL mixer channel.  */
-extern int ac97_get_mixer_scaled (struct ac97_hwint *dev, int oss_channel);
-
 /* Default ioctl. */
 extern int ac97_mixer_ioctl (struct ac97_hwint *dev, unsigned int cmd,
 			     void __user * arg);
--- linux-2.6.10-rc2-mm4-full/sound/oss/ac97.c.old	2004-12-06 17:50:03.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/ac97.c	2004-12-06 17:52:00.000000000 +0100
@@ -133,7 +133,7 @@
 
 /* Return the contents of register REG; use the cache if the value in it
    is valid.  Returns a negative error code on failure. */
-int
+static int
 ac97_get_register (struct ac97_hwint *dev, u8 reg) 
 {
     if (reg > 127 || (reg & 1))
@@ -226,7 +226,7 @@
     }
 }
 
-int
+static int
 ac97_set_mixer (struct ac97_hwint *dev, int oss_channel, u16 oss_value)
 {
     int scaled_value;
@@ -262,7 +262,7 @@
     return result;
 }
 
-int
+static int
 ac97_get_mixer_scaled (struct ac97_hwint *dev, int oss_channel)
 {
     struct ac97_chn_desc *channel = ac97_find_chndesc (dev, oss_channel);
@@ -292,7 +292,7 @@
 				  channel->is_inverted);
 }
 
-int
+static int
 ac97_get_recmask (struct ac97_hwint *dev)
 {
     int recReg = ac97_get_register (dev, AC97_RECORD_SELECT);
@@ -309,7 +309,7 @@
     }
 }
 
-int
+static int
 ac97_set_recmask (struct ac97_hwint *dev, int oss_recmask)
 {
     int x;
@@ -439,10 +439,7 @@
 
 EXPORT_SYMBOL(ac97_init);
 EXPORT_SYMBOL(ac97_set_values);
-EXPORT_SYMBOL(ac97_set_mixer);
-EXPORT_SYMBOL(ac97_get_register);
 EXPORT_SYMBOL(ac97_put_register);
-EXPORT_SYMBOL(ac97_get_mixer_scaled);
 EXPORT_SYMBOL(ac97_mixer_ioctl);
 EXPORT_SYMBOL(ac97_reset);
 MODULE_LICENSE("GPL");
--- linux-2.6.10-rc2-mm4-full/sound/oss/ad1816.c.old	2004-12-06 17:52:16.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/ad1816.c	2004-12-06 17:52:58.000000000 +0100
@@ -1245,8 +1245,9 @@
 MODULE_DEVICE_TABLE(isapnp, isapnp_ad1816_list);
 
 
-void __init ad1816_config_pnp_card(struct pnp_card *card, unsigned short vendor,
-	unsigned short function)
+static void __init ad1816_config_pnp_card(struct pnp_card *card,
+					  unsigned short vendor,
+					  unsigned short function)
 {
 	struct address_info cfg;
   	struct pnp_dev *card_dev = pnp_find_dev(card, vendor, function, NULL);
@@ -1270,7 +1271,7 @@
 	}
 }
 
-void __init ad1816_config_pnp_cards(void)
+static void __init ad1816_config_pnp_cards(void)
 {
 	int nr_pnp_cfg;
 	int i;
--- linux-2.6.10-rc2-mm4-full/sound/oss/ad1848.c.old	2004-12-06 17:53:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/ad1848.c	2004-12-06 17:54:16.000000000 +0100
@@ -123,9 +123,9 @@
 static struct address_info cfg;
 static int nr_ad1848_devs;
 
-int deskpro_xl;
-int deskpro_m;
-int soundpro;
+static int deskpro_xl;
+static int deskpro_m;
+static int soundpro;
 
 static volatile signed char irq2dev[17] = {
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -2922,7 +2922,7 @@
 MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's PnP table. Use the source, Luke.");
 MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search order");
 
-struct pnp_dev	*ad1848_dev  = NULL;
+static struct pnp_dev	*ad1848_dev  = NULL;
 
 /* Please add new entries at the end of the table */
 static struct {
--- linux-2.6.10-rc2-mm4-full/sound/oss/ad1889.c.old	2004-12-06 17:54:42.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/ad1889.c	2004-12-06 17:55:01.000000000 +0100
@@ -308,8 +308,8 @@
 	ad1889_start_wav(&dev->state[AD_WAV_STATE]);
 }
 
-int ad1889_read_proc (char *page, char **start, off_t off,
-		      int count, int *eof, void *data)
+static int ad1889_read_proc (char *page, char **start, off_t off,
+			     int count, int *eof, void *data)
 {
 	char *out = page;
 	int len, i;
--- linux-2.6.10-rc2-mm4-full/sound/oss/aedsp16.c.old	2004-12-06 17:55:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/aedsp16.c	2004-12-06 17:56:34.000000000 +0100
@@ -438,7 +438,7 @@
 	int cdrombase;
 };
 
-struct d_hcfg decoded_hcfg __initdata = {0, };
+static struct d_hcfg decoded_hcfg __initdata = {0, };
 
 #endif /* CONFIG_SC6600 */
 
@@ -610,7 +610,7 @@
 }
 #endif
 
-void __init aedsp16_hard_decode(void) {
+static void __init aedsp16_hard_decode(void) {
 
 	DBG((" aedsp16_hard_decode: 0x%x, 0x%x\n", hard_cfg[0], hard_cfg[1]));
 
@@ -654,7 +654,7 @@
 	DBG(("success.\n"));
 }
 
-void __init aedsp16_hard_encode(void) {
+static void __init aedsp16_hard_encode(void) {
 
 	DBG((" aedsp16_hard_encode: 0x%x, 0x%x\n", hard_cfg[0], hard_cfg[1]));
 
@@ -1252,7 +1252,7 @@
 	DBG(("done.\n"));
 }
 
-int __init init_aedsp16(void)
+static int __init init_aedsp16(void)
 {
 	int initialized = FALSE;
 
@@ -1294,7 +1294,7 @@
 	return initialized;
 }
 
-void __init uninit_aedsp16(void)
+static void __init uninit_aedsp16(void)
 {
 	if (ae_config.mss_base != -1)
 		uninit_aedsp16_mss();
--- linux-2.6.10-rc2-mm4-full/sound/oss/awe_wave.c.old	2004-12-06 17:56:48.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/awe_wave.c	2004-12-06 17:57:18.000000000 +0100
@@ -207,8 +207,8 @@
 #define AWE_DEFAULT_MEM_SIZE	-1	/* autodetect */
 #endif
 
-int io = AWE_DEFAULT_BASE_ADDR; /* Emu8000 base address */
-int memsize = AWE_DEFAULT_MEM_SIZE; /* memory size in Kbytes */
+static int io = AWE_DEFAULT_BASE_ADDR; /* Emu8000 base address */
+static int memsize = AWE_DEFAULT_MEM_SIZE; /* memory size in Kbytes */
 #ifdef CONFIG_PNP
 static int isapnp = -1;
 #else
@@ -6113,12 +6113,12 @@
 	return 0;
 }
 
-int __init attach_awe(void)
+static int __init attach_awe(void)
 {
 	return awe_detect() ? 0 : -ENODEV;
 }
 
-void __exit unload_awe(void)
+static void __exit unload_awe(void)
 {
 	pnp_unregister_driver(&awe_pnp_driver);
 	awe_dettach_device();
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs4232.c.old	2004-12-06 17:58:17.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs4232.c	2004-12-06 17:58:37.000000000 +0100
@@ -54,7 +54,6 @@
 
 #include "sound_config.h"
 
-#include "cs4232.h"
 #include "ad1848.h"
 #include "mpu401.h"
 
@@ -78,7 +77,7 @@
 static int synth_base, synth_irq;
 static int mpu_detected;
 
-int probe_cs4232_mpu(struct address_info *hw_config)
+static int probe_cs4232_mpu(struct address_info *hw_config)
 {
 	/*
 	 *	Just write down the config values.
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281m.c.old	2004-12-06 17:58:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281m.c	2004-12-06 18:06:18.000000000 +0100
@@ -197,7 +197,7 @@
 })
 
 //LIST_HEAD(cs4281_devs);
-struct list_head cs4281_devs = { &cs4281_devs, &cs4281_devs };
+static struct list_head cs4281_devs = { &cs4281_devs, &cs4281_devs };
 
 struct cs4281_state; 
 
@@ -1019,7 +1019,7 @@
 *  Suspend - save the ac97 regs, mute the outputs and power down the part.  
 *
 ****************************************************************************/
-void cs4281_ac97_suspend(struct cs4281_state *s)
+static void cs4281_ac97_suspend(struct cs4281_state *s)
 {
 	int Count,i;
 
@@ -1070,7 +1070,7 @@
 *  Resume - power up the part and restore its registers..  
 *
 ****************************************************************************/
-void cs4281_ac97_resume(struct cs4281_state *s)
+static void cs4281_ac97_resume(struct cs4281_state *s)
 {
 	int Count,i;
 
@@ -1143,7 +1143,7 @@
 } // SavePowerState
 */
 
-void cs4281_SuspendFIFO(struct cs4281_state *s, struct cs4281_pipeline *pl)
+static void cs4281_SuspendFIFO(struct cs4281_state *s, struct cs4281_pipeline *pl)
 {
  /*
  * We need to save the contents of the BASIC FIFO Registers.
@@ -1151,7 +1151,7 @@
 	pl->u32FCRn_Save = readl(s->pBA0 + pl->u32FCRnAddress);
 	pl->u32FSICn_Save = readl(s->pBA0 + pl->u32FSICnAddress);
 }
-void cs4281_ResumeFIFO(struct cs4281_state *s, struct cs4281_pipeline *pl)
+static void cs4281_ResumeFIFO(struct cs4281_state *s, struct cs4281_pipeline *pl)
 {
  /*
  * We need to restore the contents of the BASIC FIFO Registers.
@@ -1159,7 +1159,7 @@
 	writel(pl->u32FCRn_Save,s->pBA0 + pl->u32FCRnAddress);
 	writel(pl->u32FSICn_Save,s->pBA0 + pl->u32FSICnAddress);
 }
-void cs4281_SuspendDMAengine(struct cs4281_state *s, struct cs4281_pipeline *pl)
+static void cs4281_SuspendDMAengine(struct cs4281_state *s, struct cs4281_pipeline *pl)
 {
 	//
 	// We need to save the contents of the BASIC DMA Registers.
@@ -1171,7 +1171,7 @@
 	pl->u32DCCn_Save = readl(s->pBA0 + pl->u32DCCnAddress);
 	pl->u32DCAn_Save = readl(s->pBA0 + pl->u32DCAnAddress);
 }
-void cs4281_ResumeDMAengine(struct cs4281_state *s, struct cs4281_pipeline *pl)
+static void cs4281_ResumeDMAengine(struct cs4281_state *s, struct cs4281_pipeline *pl)
 {
 	//
 	// We need to save the contents of the BASIC DMA Registers.
@@ -1184,7 +1184,7 @@
 	writel( pl->u32DCAn_Save, s->pBA0 + pl->u32DCAnAddress);
 }
 
-int cs4281_suspend(struct cs4281_state *s)
+static int cs4281_suspend(struct cs4281_state *s)
 {
 	int i;
 	u32 u32CLKCR1;
@@ -1340,7 +1340,7 @@
 	return 0;
 }
 
-int cs4281_resume(struct cs4281_state *s)
+static int cs4281_resume(struct cs4281_state *s)
 {
 	int i;
 	unsigned temp1;
@@ -1695,7 +1695,7 @@
 #define DMABUF_MINORDER 1	// ==> min buffer size = 8K.
 
 
-void dealloc_dmabuf(struct cs4281_state *s, struct dmabuf *db)
+static void dealloc_dmabuf(struct cs4281_state *s, struct dmabuf *db)
 {
 	struct page *map, *mapend;
 
@@ -4112,7 +4112,7 @@
 
 
 #ifndef NOT_CS4281_PM
-void __devinit cs4281_BuildFIFO(
+static void __devinit cs4281_BuildFIFO(
 	struct cs4281_pipeline *p, 
 	struct cs4281_state *s)
 {
@@ -4159,7 +4159,7 @@
 
 }
 
-void __devinit cs4281_BuildDMAengine(
+static void __devinit cs4281_BuildDMAengine(
 	struct cs4281_pipeline *p, 
 	struct cs4281_state *s)
 {
@@ -4229,7 +4229,7 @@
 
 }
 
-void __devinit cs4281_InitPM(struct cs4281_state *s)
+static void __devinit cs4281_InitPM(struct cs4281_state *s)
 {
 	int i;
 	struct cs4281_pipeline *p;
@@ -4459,7 +4459,7 @@
 
 MODULE_DEVICE_TABLE(pci, cs4281_pci_tbl);
 
-struct pci_driver cs4281_pci_driver = {
+static struct pci_driver cs4281_pci_driver = {
 	.name	  = "cs4281",
 	.id_table = cs4281_pci_tbl,
 	.probe	  = cs4281_probe,
@@ -4468,7 +4468,7 @@
 	.resume	  = CS4281_RESUME_TBL,
 };
 
-int __init cs4281_init_module(void)
+static int __init cs4281_init_module(void)
 {
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
@@ -4483,7 +4483,7 @@
 	return rtn;
 }
 
-void __exit cs4281_cleanup_module(void)
+static void __exit cs4281_cleanup_module(void)
 {
 	pci_unregister_driver(&cs4281_pci_driver);
 #ifndef NOT_CS4281_PM
@@ -4503,9 +4503,3 @@
 module_init(cs4281_init_module);
 module_exit(cs4281_cleanup_module);
 
-#ifndef MODULE
-int __init init_cs4281(void)
-{
-	return cs4281_init_module();
-}
-#endif
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281pm-24.c.old	2004-12-06 18:02:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281pm-24.c	2004-12-06 19:05:09.000000000 +0100
@@ -30,8 +30,8 @@
 #define cs_pm_register(a, b, c) pm_register((a), (b), (c));
 #define cs_pm_unregister_all(a) pm_unregister_all((a));
 
-int cs4281_suspend(struct cs4281_state *s);
-int cs4281_resume(struct cs4281_state *s);
+static int cs4281_suspend(struct cs4281_state *s);
+static int cs4281_resume(struct cs4281_state *s);
 /* 
 * for now (12/22/00) only enable the pm_register PM support.
 * allow these table entries to be null.
@@ -41,7 +41,7 @@
 #define CS4281_SUSPEND_TBL cs4281_suspend_null
 #define CS4281_RESUME_TBL cs4281_resume_null
 
-int cs4281_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+static int cs4281_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
 	struct cs4281_state *state;
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281_wrapper-24.c.old	2004-12-06 18:04:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs4281/cs4281_wrapper-24.c	2004-12-06 18:04:48.000000000 +0100
@@ -26,8 +26,8 @@
 
 #include <linux/spinlock.h>
 
-int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
-int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
+static int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
+static int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
 
 #define free_dmabuf(state, dmabuf) \
 	pci_free_consistent(state->pcidev, \
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs46xx.c.old	2004-12-06 18:06:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs46xx.c	2004-12-06 19:07:05.000000000 +0100
@@ -219,7 +219,7 @@
 #define CS46XX_ARCH	     	"32"	//architecture key
 #endif
 
-struct list_head cs46xx_devs = { &cs46xx_devs, &cs46xx_devs };
+static struct list_head cs46xx_devs = { &cs46xx_devs, &cs46xx_devs };
 
 /* magic numbers to protect our data structures */
 #define CS_CARD_MAGIC		0x43525553 /* "CRUS" */
@@ -391,6 +391,10 @@
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 
+#ifndef CS46XX_ACPI_SUPPORT
+static int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data);
+#endif
+
 static inline unsigned ld2(unsigned int x)
 {
 	unsigned r = 0;
@@ -426,7 +430,7 @@
 #define SOUND_MIXER_CS_SETDBGMASK 	_SIOWR('M',123, int)
 #define SOUND_MIXER_CS_APM	 	_SIOWR('M',124, int)
 
-void printioctl(unsigned int x)
+static void printioctl(unsigned int x)
 {
     unsigned int i;
     unsigned char vidx;
@@ -964,7 +968,7 @@
  * "SetCaptureSPValues()" -- Initialize record task values before each
  * 	capture startup.  
  */
-void SetCaptureSPValues(struct cs_card *card)
+static void SetCaptureSPValues(struct cs_card *card)
 {
 	unsigned i, offset;
 	CS_DBGOUT(CS_FUNCTION, 8, printk("cs46xx: SetCaptureSPValues()+\n") );
@@ -3490,7 +3494,7 @@
 *  Suspend - save the ac97 regs, mute the outputs and power down the part.  
 *
 ****************************************************************************/
-void cs46xx_ac97_suspend(struct cs_card *card)
+static void cs46xx_ac97_suspend(struct cs_card *card)
 {
 	int Count,i;
 	struct ac97_codec *dev=card->ac97_codec[0];
@@ -3561,7 +3565,7 @@
 *  Resume - power up the part and restore its registers..  
 *
 ****************************************************************************/
-void cs46xx_ac97_resume(struct cs_card *card)
+static void cs46xx_ac97_resume(struct cs_card *card)
 {
 	int Count,i;
 	struct ac97_codec *dev=card->ac97_codec[0];
@@ -4149,7 +4153,6 @@
 	return 0;
 }
 
-void __exit cs46xx_cleanup_module(void);
 static int cs_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd,
 				unsigned long arg)
 {
@@ -5719,7 +5722,7 @@
 
 MODULE_DEVICE_TABLE(pci, cs46xx_pci_tbl);
 
-struct pci_driver cs46xx_pci_driver = {
+static struct pci_driver cs46xx_pci_driver = {
 	.name	  = "cs46xx",
 	.id_table = cs46xx_pci_tbl,
 	.probe	  = cs46xx_probe,
@@ -5728,7 +5731,7 @@
 	.resume	  = CS46XX_RESUME_TBL,
 };
 
-int __init cs46xx_init_module(void)
+static int __init cs46xx_init_module(void)
 {
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
@@ -5746,7 +5749,7 @@
 	return rtn;
 }
 
-void __exit cs46xx_cleanup_module(void)
+static void __exit cs46xx_cleanup_module(void)
 {
 	pci_unregister_driver(&cs46xx_pci_driver);
 	cs_pm_unregister_all(cs46xx_pm_callback);
@@ -5757,7 +5760,8 @@
 module_init(cs46xx_init_module);
 module_exit(cs46xx_cleanup_module);
 
-int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+#ifndef CS46XX_ACPI_SUPPORT
+static int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
 	struct cs_card *card;
 
@@ -5792,6 +5796,7 @@
 
 	return 0;
 }
+#endif
 
 #if CS46XX_ACPI_SUPPORT
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state)
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs46xx_wrapper-24.h.old	2004-12-06 18:08:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs46xx_wrapper-24.h	2004-12-06 18:08:54.000000000 +0100
@@ -30,7 +30,7 @@
 
 #define CS_OWNER .owner =
 #define CS_THIS_MODULE THIS_MODULE,
-void cs46xx_null(struct pci_dev *pcidev) { return; }
+static inline void cs46xx_null(struct pci_dev *pcidev) { return; }
 #define cs4x_mem_map_reserve(page) SetPageReserved(page)
 #define cs4x_mem_map_unreserve(page) ClearPageReserved(page)
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/cs46xxpm-24.h.old	2004-12-06 18:09:58.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/cs46xxpm-24.h	2004-12-06 18:10:03.000000000 +0100
@@ -48,6 +48,5 @@
 #define CS46XX_SUSPEND_TBL cs46xx_null
 #define CS46XX_RESUME_TBL cs46xx_null
 #endif
-int cs46xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data);
 
 #endif
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/audio.h.old	2004-12-06 18:13:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/audio.h	2004-12-06 18:14:14.000000000 +0100
@@ -41,7 +41,4 @@
         u16 enablebits;
 };
 
-void emu10k1_waveout_bh(unsigned long);
-void emu10k1_wavein_bh(unsigned long);
-
 #endif /* _AUDIO_H */
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/audio.c.old	2004-12-06 18:11:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/audio.c	2004-12-06 18:14:34.000000000 +0100
@@ -49,6 +49,9 @@
 static void calculate_ofrag(struct woinst *);
 static void calculate_ifrag(struct wiinst *);
 
+static void emu10k1_waveout_bh(unsigned long refdata);
+static void emu10k1_wavein_bh(unsigned long refdata);
+
 /* Audio file operations */
 static ssize_t emu10k1_audio_read(struct file *file, char __user *buffer, size_t count, loff_t * ppos)
 {
@@ -1032,7 +1035,7 @@
 	return dmapage;
 }
 
-struct vm_operations_struct emu10k1_mm_ops = {
+static struct vm_operations_struct emu10k1_mm_ops = {
 	.nopage         = emu10k1_mm_nopage,
 };
 
@@ -1506,7 +1509,7 @@
 	return;
 }
 
-void emu10k1_wavein_bh(unsigned long refdata)
+static void emu10k1_wavein_bh(unsigned long refdata)
 {
 	struct emu10k1_wavedevice *wave_dev = (struct emu10k1_wavedevice *) refdata;
 	struct wiinst *wiinst = wave_dev->wiinst;
@@ -1537,7 +1540,7 @@
 	return;
 }
 
-void emu10k1_waveout_bh(unsigned long refdata)
+static void emu10k1_waveout_bh(unsigned long refdata)
 {
 	struct emu10k1_wavedevice *wave_dev = (struct emu10k1_wavedevice *) refdata;
 	struct woinst *woinst = wave_dev->woinst;
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardwi.c.old	2004-12-06 18:19:22.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardwi.c	2004-12-06 18:19:29.000000000 +0100
@@ -42,7 +42,7 @@
  * This function will return a valid sound format as close
  * to the requested one as possible. 
  */
-void query_format(int recsrc, struct wave_format *wave_fmt)
+static void query_format(int recsrc, struct wave_format *wave_fmt)
 {
 
 	switch (recsrc) {
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/efxmgr.c.old	2004-12-06 18:19:52.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/efxmgr.c	2004-12-06 18:20:06.000000000 +0100
@@ -101,8 +101,8 @@
 #define VOLCTRL_STEP_SIZE        5
 
 //An internal function for setting OSS mixer controls.
-void emu10k1_set_oss_vol(struct emu10k1_card *card, int oss_mixer,
-			 unsigned int left, unsigned int right)
+static void emu10k1_set_oss_vol(struct emu10k1_card *card, int oss_mixer,
+				unsigned int left, unsigned int right)
 {
 	extern char volume_params[SOUND_MIXER_NRDEVICES];
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/hwaccess.h.old	2004-12-06 18:20:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/hwaccess.h	2004-12-06 18:22:27.000000000 +0100
@@ -212,7 +212,6 @@
 #define TIMEOUT 		    16384
 
 u32 srToPitch(u32);
-u8 sumVolumeToAttenuation(u32);
 
 extern struct list_head emu10k1_devs;
 
@@ -232,7 +231,6 @@
 
 void emu10k1_irq_enable(struct emu10k1_card *, u32);
 void emu10k1_irq_disable(struct emu10k1_card *, u32);
-void emu10k1_set_stop_on_loop(struct emu10k1_card *, u32);
 void emu10k1_clear_stop_on_loop(struct emu10k1_card *, u32);
 
 /* AC97 Codec register access function */
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/hwaccess.c.old	2004-12-06 18:20:37.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/hwaccess.c	2004-12-06 18:22:37.000000000 +0100
@@ -105,31 +105,6 @@
 	return 0;		/* Should never reach this point */
 }
 
-/* Returns an attenuation based upon a cumulative volume value */
-
-/* Algorithm calculates 0x200 - 0x10 log2 (input) */
-u8 sumVolumeToAttenuation(u32 value)
-{
-	u16 count = 16;
-	s16 ans;
-
-	if (value == 0)
-		return 0xFF;
-
-	/* Find first SET bit. This is the integer part of the value */
-	while ((value & 0x10000) == 0) {
-		value <<= 1;
-		count--;
-	}
-
-	/* The REST of the data is the fractional part. */
-	ans = (s16) (0x110 - ((count << 4) + ((value & 0x0FFFFL) >> 12)));
-	if (ans > 0xFF)
-		ans = 0xFF;
-
-	return (u8) ans;
-}
-
 /*******************************************
 * write/read PCI function 0 registers      *
 ********************************************/
@@ -160,6 +135,7 @@
 	return;
 }
 
+#ifdef DBGEMU
 void emu10k1_writefn0_2(struct emu10k1_card *card, u32 reg, u32 data, int size)
 {
 	unsigned long flags;
@@ -177,6 +153,7 @@
 
 	return;
 }
+#endif  /*  DBGEMU  */
 
 u32 emu10k1_readfn0(struct emu10k1_card * card, u32 reg)
 {
@@ -340,17 +317,6 @@
         return;
 }
 
-void emu10k1_set_stop_on_loop(struct emu10k1_card *card, u32 voicenum)
-{
-	/* Voice interrupt */
-	if (voicenum >= 32)
-		sblive_writeptr(card, SOLEH | ((0x0100 | (voicenum - 32)) << 16), 0, 1);
-	else
-		sblive_writeptr(card, SOLEL | ((0x0100 | voicenum) << 16), 0, 1);
-
-	return;
-}
-
 void emu10k1_clear_stop_on_loop(struct emu10k1_card *card, u32 voicenum)
 {
 	/* Voice interrupt */
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/main.c.old	2004-12-06 18:22:51.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/main.c	2004-12-06 18:23:05.000000000 +0100
@@ -309,8 +309,8 @@
 	unregister_sound_dsp(card->audio_dev);
 }
 
-int emu10k1_info_proc (char *page, char **start, off_t off,
-		    int count, int *eof, void *data)
+static int emu10k1_info_proc (char *page, char **start, off_t off,
+			      int count, int *eof, void *data)
 {
 	struct emu10k1_card *card = data;
 	int len = 0;
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/voicemgr.c.old	2004-12-06 18:23:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/voicemgr.c	2004-12-06 18:23:40.000000000 +0100
@@ -39,7 +39,8 @@
 #define PITCH_67882 0x00005a82
 #define PITCH_57081 0x00004c1c
 
-u32 emu10k1_select_interprom(struct emu10k1_card *card, struct emu_voice *voice)
+static u32 emu10k1_select_interprom(struct emu10k1_card *card,
+				    struct emu_voice *voice)
 {
 	if(voice->pitch_target==PITCH_48000)
 		return CCCA_INTERPROM_0;
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardmi.h.old	2004-12-06 18:27:14.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardmi.h	2004-12-06 18:29:36.000000000 +0100
@@ -91,24 +91,7 @@
 int emu10k1_mpuin_stop(struct emu10k1_card *);
 int emu10k1_mpuin_reset(struct emu10k1_card *);
 
-int sblive_miStateInit(struct emu10k1_mpuin *);
-int sblive_miStateEntry(struct emu10k1_mpuin *, u8);
-int sblive_miStateParse(struct emu10k1_mpuin *, u8);
-int sblive_miState3Byte(struct emu10k1_mpuin *, u8);
-int sblive_miState3ByteKey(struct emu10k1_mpuin *, u8);
-int sblive_miState3ByteVel(struct emu10k1_mpuin *, u8);
-int sblive_miState2Byte(struct emu10k1_mpuin *, u8);
-int sblive_miState2ByteKey(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysCommon2(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysCommon2Key(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysCommon3(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysCommon3Key(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysCommon3Vel(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysExNorm(struct emu10k1_mpuin *, u8);
-int sblive_miStateSysReal(struct emu10k1_mpuin *, u8);
-
 int emu10k1_mpuin_irqhandler(struct emu10k1_card *);
 void emu10k1_mpuin_bh(unsigned long);
-int emu10k1_mpuin_callback(struct emu10k1_mpuin *card_mpuin, u32 msg, unsigned long data, u32 bytesvalid);
 
 #endif  /* _CARDMI_H */
--- linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardmi.c.old	2004-12-06 18:27:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/emu10k1/cardmi.c	2004-12-06 18:33:22.000000000 +0100
@@ -38,6 +38,26 @@
 #include "cardmi.h"
 #include "irqmgr.h"
 
+
+static int emu10k1_mpuin_callback(struct emu10k1_mpuin *card_mpuin, u32 msg, unsigned long data, u32 bytesvalid);
+
+static int sblive_miStateInit(struct emu10k1_mpuin *);
+static int sblive_miStateEntry(struct emu10k1_mpuin *, u8);
+static int sblive_miStateParse(struct emu10k1_mpuin *, u8);
+static int sblive_miState3Byte(struct emu10k1_mpuin *, u8);
+static int sblive_miState3ByteKey(struct emu10k1_mpuin *, u8);
+static int sblive_miState3ByteVel(struct emu10k1_mpuin *, u8);
+static int sblive_miState2Byte(struct emu10k1_mpuin *, u8);
+static int sblive_miState2ByteKey(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysCommon2(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysCommon2Key(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysCommon3(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysCommon3Key(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysCommon3Vel(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysExNorm(struct emu10k1_mpuin *, u8);
+static int sblive_miStateSysReal(struct emu10k1_mpuin *, u8);
+
+
 static struct {
 	int (*Fn) (struct emu10k1_mpuin *, u8);
 } midistatefn[] = {
@@ -69,6 +89,7 @@
 	sblive_miStateSysReal}	/* 0xF4 - 0xF6 ,0xF8 - 0xFF     */
 };
 
+
 /* Installs the IRQ handler for the MPU in port                 */
 
 /* and initialize parameters                                    */
@@ -269,7 +290,7 @@
 /* Passes the message with the data back to the client          */
 
 /* via IRQ & DPC callbacks to Ring 3                            */
-int emu10k1_mpuin_callback(struct emu10k1_mpuin *card_mpuin, u32 msg, unsigned long data, u32 bytesvalid)
+static int emu10k1_mpuin_callback(struct emu10k1_mpuin *card_mpuin, u32 msg, unsigned long data, u32 bytesvalid)
 {
 	unsigned long timein;
 	struct midi_queue *midiq;
@@ -374,7 +395,7 @@
 /*****************************************************************************/
 
 /* FIXME: This should be a macro */
-int sblive_miStateInit(struct emu10k1_mpuin *card_mpuin)
+static int sblive_miStateInit(struct emu10k1_mpuin *card_mpuin)
 {
 	card_mpuin->status = 0;	/* For MIDI running status */
 	card_mpuin->fstatus = 0;	/* For 0xFn status only */
@@ -388,12 +409,12 @@
 }
 
 /* FIXME: This should be a macro */
-int sblive_miStateEntry(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateEntry(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	return midistatefn[card_mpuin->curstate].Fn(card_mpuin, data);
 }
 
-int sblive_miStateParse(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateParse(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	switch (data & 0xf0) {
 	case 0x80:
@@ -457,7 +478,7 @@
 	return midistatefn[card_mpuin->curstate].Fn(card_mpuin, data);
 }
 
-int sblive_miState3Byte(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miState3Byte(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	u8 temp = data & 0xf0;
 
@@ -473,8 +494,7 @@
 	return midistatefn[STIN_PARSE].Fn(card_mpuin, data);
 }
 
-int sblive_miState3ByteKey(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miState3ByteKey(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 1 */
 {
 	unsigned long tmp;
@@ -502,8 +522,7 @@
 	return CTSTATUS_NEXT_BYTE;
 }
 
-int sblive_miState3ByteVel(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miState3ByteVel(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 2 */
 {
 	unsigned long tmp;
@@ -539,7 +558,7 @@
 	return 0;
 }
 
-int sblive_miState2Byte(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miState2Byte(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	u8 temp = data & 0xf0;
 
@@ -556,8 +575,7 @@
 	return midistatefn[STIN_PARSE].Fn(card_mpuin, data);
 }
 
-int sblive_miState2ByteKey(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miState2ByteKey(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 1 */
 {
 	unsigned long tmp;
@@ -590,7 +608,7 @@
 	return 0;
 }
 
-int sblive_miStateSysCommon2(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateSysCommon2(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	card_mpuin->fstatus = data;
 	card_mpuin->curstate = STIN_SYS_COMMON_2_KEY;
@@ -598,8 +616,7 @@
 	return CTSTATUS_NEXT_BYTE;
 }
 
-int sblive_miStateSysCommon2Key(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miStateSysCommon2Key(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 1 */
 {
 	unsigned long tmp;
@@ -632,7 +649,7 @@
 	return 0;
 }
 
-int sblive_miStateSysCommon3(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateSysCommon3(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	card_mpuin->fstatus = data;
 	card_mpuin->curstate = STIN_SYS_COMMON_3_KEY;
@@ -640,8 +657,7 @@
 	return CTSTATUS_NEXT_BYTE;
 }
 
-int sblive_miStateSysCommon3Key(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miStateSysCommon3Key(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 1 */
 {
 	unsigned long tmp;
@@ -670,8 +686,7 @@
 	return CTSTATUS_NEXT_BYTE;
 }
 
-int sblive_miStateSysCommon3Vel(struct emu10k1_mpuin *card_mpuin, u8 data)
-
+static int sblive_miStateSysCommon3Vel(struct emu10k1_mpuin *card_mpuin, u8 data)
 /* byte 2 */
 {
 	unsigned long tmp;
@@ -708,7 +723,7 @@
 	return 0;
 }
 
-int sblive_miStateSysExNorm(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateSysExNorm(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	unsigned long flags;
 
@@ -809,7 +824,7 @@
 	return CTSTATUS_NEXT_BYTE;
 }
 
-int sblive_miStateSysReal(struct emu10k1_mpuin *card_mpuin, u8 data)
+static int sblive_miStateSysReal(struct emu10k1_mpuin *card_mpuin, u8 data)
 {
 	emu10k1_mpuin_callback(card_mpuin, ICARDMIDI_INDATA, data, 1);
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/forte.c.old	2004-12-06 18:33:39.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/forte.c	2004-12-06 18:33:56.000000000 +0100
@@ -238,7 +238,7 @@
  * @reg:	register to read
  */
 
-u16
+static u16
 forte_ac97_read (struct ac97_codec *codec, u8 reg)
 {
 	u16 ret = 0;
@@ -283,7 +283,7 @@
  * @val:	value to write
  */
 
-void
+static void
 forte_ac97_write (struct ac97_codec *codec, u8 reg, u16 val)
 {
 	struct forte_chip *chip = codec->private_data;
--- linux-2.6.10-rc2-mm4-full/sound/oss/gus_wave.c.old	2004-12-06 18:35:00.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/gus_wave.c	2004-12-06 18:35:14.000000000 +0100
@@ -94,7 +94,7 @@
 static int      only_read_access;
 static int      only_8_bits;
 
-int             iw_mode = 0;
+static int      iw_mode = 0;
 int             gus_wave_volume = 60;
 int             gus_pcm_volume = 80;
 int             have_gus_max = 0;
--- linux-2.6.10-rc2-mm4-full/sound/oss/maestro.c.old	2004-12-06 18:35:29.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/maestro.c	2004-12-06 18:36:29.000000000 +0100
@@ -344,7 +344,7 @@
 
 /* these masks indicate which units we care about at
 	which states */
-u16 acpi_state_mask[] = {
+static u16 acpi_state_mask[] = {
 	[ACPI_D0] = ACPI_ALL,
 	[ACPI_D1] = ACPI_SLEEP,
 	[ACPI_D2] = ACPI_SLEEP,
@@ -610,7 +610,7 @@
 	be sure to fill it in if you add oss mixers
 	to anyone's supported mixer defines */
 
- unsigned int mixer_defaults[SOUND_MIXER_NRDEVICES] = {
+static unsigned int mixer_defaults[SOUND_MIXER_NRDEVICES] = {
 	[SOUND_MIXER_VOLUME] =          0x3232,
 	[SOUND_MIXER_BASS] =            0x3232,
 	[SOUND_MIXER_TREBLE] =          0x3232,
@@ -3363,7 +3363,7 @@
 /* this guy tries to find the pci power management
  * register bank.  this should really be in core
  * code somewhere.  1 on success. */
-int
+static int
 parse_power(struct ess_card *card, struct pci_dev *pcidev)
 {
 	u32 n;
@@ -3629,7 +3629,7 @@
 	.remove	  = maestro_remove,
 };
 
-int __init init_maestro(void)
+static int __init init_maestro(void)
 {
 	int rc;
 
@@ -3666,7 +3666,7 @@
 /* --------------------------------------------------------------------- */
 
 
-void cleanup_maestro(void) {
+static void cleanup_maestro(void) {
 	M_printk("maestro: unloading\n");
 	pci_unregister_driver(&maestro_pci_driver);
 	pm_unregister_all(maestro_pm_callback);
--- linux-2.6.10-rc2-mm4-full/sound/oss/maestro3.h.old	2004-12-06 18:37:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/maestro3.h	2004-12-06 18:37:44.000000000 +0100
@@ -695,7 +695,7 @@
  * DSP Code images
  */
 
-u16 assp_kernel_image[] = {
+static u16 assp_kernel_image[] = {
     0x7980, 0x0030, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x00FB, 0x7980, 0x00DD, 0x7980, 0x03B4, 
     0x7980, 0x0332, 0x7980, 0x0287, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 
     0x7980, 0x031A, 0x7980, 0x03B4, 0x7980, 0x022F, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 
@@ -782,7 +782,7 @@
  * Mini sample rate converter code image
  * that is to be loaded at 0x400 on the DSP.
  */
-u16 assp_minisrc_image[] = {
+static u16 assp_minisrc_image[] = {
 
     0xBF80, 0x101E, 0x906E, 0x006E, 0x8B88, 0x6980, 0xEF88, 0x906F, 0x0D6F, 0x6900, 0xEB08, 0x0412, 
     0xBC20, 0x696E, 0xB801, 0x906E, 0x7980, 0x0403, 0xB90E, 0x8807, 0xBE43, 0xBF01, 0xBE47, 0xBE41, 
--- linux-2.6.10-rc2-mm4-full/sound/oss/maestro3.c.old	2004-12-06 18:36:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/maestro3.c	2004-12-06 18:39:54.000000000 +0100
@@ -378,7 +378,7 @@
 static int m3_suspend(struct pci_dev *pci_dev, u32 state);
 static void check_suspend(struct m3_card *card);
 
-struct notifier_block m3_reboot_nb = {
+static struct notifier_block m3_reboot_nb = {
 	.notifier_call = m3_notifier,
 };
 
@@ -1024,8 +1024,8 @@
     DPRINTK(DPINT,"set_dmac??\n");
 }
 
-u32 get_dma_pos(struct m3_card *card,
-        int instance_addr)
+static u32 get_dma_pos(struct m3_card *card,
+		       int instance_addr)
 {
     u16 hi = 0, lo = 0;
     int retry = 10;
@@ -1047,7 +1047,7 @@
     return lo | (hi<<16);
 }
 
-u32 get_dmaa(struct m3_state *s)
+static u32 get_dmaa(struct m3_state *s)
 {
     u32 offset;
 
@@ -1059,7 +1059,7 @@
     return offset;
 }
 
-u32 get_dmac(struct m3_state *s)
+static u32 get_dmac(struct m3_state *s)
 {
     u32 offset;
 
@@ -2102,7 +2102,7 @@
     return i == 0;
 }
 
-u16 m3_ac97_read(struct ac97_codec *codec, u8 reg)
+static u16 m3_ac97_read(struct ac97_codec *codec, u8 reg)
 {
     u16 ret = 0;
     struct m3_card *card = codec->private_data;
@@ -2129,7 +2129,7 @@
     return ret;
 }
 
-void m3_ac97_write(struct ac97_codec *codec, u8 reg, u16 val)
+static void m3_ac97_write(struct ac97_codec *codec, u8 reg, u16 val)
 {
     struct m3_card *card = codec->private_data;
 
@@ -2187,7 +2187,7 @@
 	.release = m3_release_mixdev,
 };
 
-void remote_codec_config(int io, int isremote)
+static void remote_codec_config(int io, int isremote)
 {
     isremote = isremote ? 1 : 0;
 
@@ -2571,7 +2571,7 @@
 };
 
 #ifdef CONFIG_PM
-int alloc_dsp_suspendmem(struct m3_card *card)
+static int alloc_dsp_suspendmem(struct m3_card *card)
 {
     int len = sizeof(u16) * (REV_B_CODE_MEMORY_LENGTH + REV_B_DATA_MEMORY_LENGTH);
 
@@ -2580,7 +2580,7 @@
 
     return 0;
 }
-void free_dsp_suspendmem(struct m3_card *card)
+static void free_dsp_suspendmem(struct m3_card *card)
 {
    if(card->suspend_mem)
        vfree(card->suspend_mem);
--- linux-2.6.10-rc2-mm4-full/sound/oss/nm256_audio.c.old	2004-12-06 18:40:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/nm256_audio.c	2004-12-06 18:41:14.000000000 +0100
@@ -157,7 +157,7 @@
  * attempted.
  */
 
-int
+static int
 nm256_setInfo (int dev, struct nm256_info *card)
 {
     int x;
@@ -1673,7 +1673,7 @@
 MODULE_LICENSE("GPL");
 
 
-struct pci_driver nm256_pci_driver = {
+static struct pci_driver nm256_pci_driver = {
 	.name		= "nm256_audio",
 	.id_table	= nm256_pci_tbl,
 	.probe		= nm256_probe,
--- linux-2.6.10-rc2-mm4-full/sound/oss/opl3sa2.c.old	2004-12-06 18:41:32.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/opl3sa2.c	2004-12-06 18:42:09.000000000 +0100
@@ -177,9 +177,6 @@
 static int __initdata isapnp = 1;
 static int __initdata multiple = 1;
 
-/* PnP devices */
-struct pnp_dev* opl3sa2_dev[OPL3SA2_CARDS_MAX];
-
 /* Whether said devices have been activated */
 static int opl3sa2_activated[OPL3SA2_CARDS_MAX];
 #else
@@ -775,7 +772,7 @@
 }
 
 #ifdef CONFIG_PNP
-struct pnp_device_id pnp_opl3sa2_list[] = {
+static struct pnp_device_id pnp_opl3sa2_list[] = {
 	{.id = "YMH0021", .driver_data = 0},
 	{.id = ""}
 };
--- linux-2.6.10-rc2-mm4-full/sound/oss/pss.c.old	2004-12-06 18:42:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/pss.c	2004-12-06 18:42:53.000000000 +0100
@@ -649,7 +649,7 @@
 	.ioctl	= pss_mixer_ioctl
 };
 
-void disable_all_emulations(void)
+static void disable_all_emulations(void)
 {
 	outw(0x0000, REG(CONF_PSS));	/* 0x0400 enables joystick */
 	outw(0x0000, REG(CONF_WSS));
@@ -658,7 +658,7 @@
 	outw(0x0000, REG(CONF_CDROM));
 }
 
-void configure_nonsound_components(void)
+static void configure_nonsound_components(void)
 {
 	/* Configure Joystick port */
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/rme96xx.c.old	2004-12-06 18:43:05.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/rme96xx.c	2004-12-06 18:45:19.000000000 +0100
@@ -339,7 +339,7 @@
 
 /* fiddling with the card (first level hardware control) */
 
-inline void rme96xx_set_ctrl(rme96xx_info* s,int mask)
+static inline void rme96xx_set_ctrl(rme96xx_info* s,int mask)
 {
 
 	s->control_register|=mask;
@@ -347,7 +347,7 @@
 
 }
 
-inline void rme96xx_unset_ctrl(rme96xx_info* s,int mask)
+static inline void rme96xx_unset_ctrl(rme96xx_info* s,int mask)
 {
 
 	s->control_register&=(~mask);
@@ -355,7 +355,7 @@
 
 }
 
-inline int rme96xx_get_sample_rate_status(rme96xx_info* s)
+static inline int rme96xx_get_sample_rate_status(rme96xx_info* s)
 {
 	int val;
 	u32 status;
@@ -366,7 +366,7 @@
 	return val;
 }
 
-inline int rme96xx_get_sample_rate_ctrl(rme96xx_info* s)
+static inline int rme96xx_get_sample_rate_ctrl(rme96xx_info* s)
 {
 	int val;
 	val = (s->control_register & RME96xx_freq) ? 48000 : 44100;
@@ -539,7 +539,7 @@
 /* the function returns the hardware pointer in bytes */
 #define RME96xx_BURSTBYTES -64  /* bytes by which hwptr could be off */
 
-inline int rme96xx_gethwptr(rme96xx_info* s,int exact)
+static inline int rme96xx_gethwptr(rme96xx_info* s,int exact)
 {
 	unsigned long flags;
 	if (exact) {
@@ -557,7 +557,7 @@
 	return (s->hwbufid ? s->fragsize : 0);
 }
 
-inline void rme96xx_setlatency(rme96xx_info* s,int l)
+static inline void rme96xx_setlatency(rme96xx_info* s,int l)
 {
 	s->latency = l;
 	s->fragsize = 1<<(8+l);
@@ -626,7 +626,7 @@
 }
 
 
-inline int rme96xx_getospace(struct dmabuf * dma, unsigned int hwp)
+static inline int rme96xx_getospace(struct dmabuf * dma, unsigned int hwp)
 {
 	int cnt;
 	int  swptr;
@@ -643,7 +643,7 @@
 	return cnt;
 }
 
-inline int rme96xx_getispace(struct dmabuf * dma, unsigned int hwp)
+static inline int rme96xx_getispace(struct dmabuf * dma, unsigned int hwp)
 {
 	int cnt;
 	int  swptr;
@@ -661,7 +661,7 @@
 }
 
 
-inline int rme96xx_copyfromuser(struct dmabuf* dma,const char __user * buffer,int count,int hop)
+static inline int rme96xx_copyfromuser(struct dmabuf* dma,const char __user * buffer,int count,int hop)
 {
 	int swptr = dma->writeptr;
 	switch (dma->format) {
@@ -710,7 +710,7 @@
 }
 
 /* The count argument is the number of bytes */
-inline int rme96xx_copytouser(struct dmabuf* dma,const char __user* buffer,int count,int hop)
+static inline int rme96xx_copytouser(struct dmabuf* dma,const char __user* buffer,int count,int hop)
 {
 	int swptr = dma->readptr;
 	switch (dma->format) {
@@ -793,7 +793,7 @@
  PCI detection and module initialization stuff 
  ----------------------------------------------------------------------------*/
 
-void* busmaster_malloc(int size) {
+static void* busmaster_malloc(int size) {
      int pg; /* 2 s exponent of memory size */
         char *buf;
 
@@ -819,7 +819,7 @@
 	return NULL;
 }
 
-void busmaster_free(void* ptr,int size) {
+static void busmaster_free(void* ptr,int size) {
         int pg;
 	struct page* page, *last_page;
 
@@ -866,7 +866,7 @@
 }
 
 
-int rme96xx_init(rme96xx_info* s)
+static int rme96xx_init(rme96xx_info* s)
 {
 	int i;
 	int status;
--- linux-2.6.10-rc2-mm4-full/sound/oss/sb_card.c.old	2004-12-06 18:45:54.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sb_card.c	2004-12-06 18:46:02.000000000 +0100
@@ -49,7 +49,7 @@
 static int __initdata acer 	= 0; /* Do acer notebook init? */
 static int __initdata sm_games 	= 0; /* Logitech soundman games? */
 
-struct sb_card_config *legacy = NULL;
+static struct sb_card_config *legacy = NULL;
 
 #ifdef CONFIG_PNP
 static int __initdata pnp       = 1;
--- linux-2.6.10-rc2-mm4-full/sound/oss/sb.h.old	2004-12-06 18:46:20.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sb.h	2004-12-06 18:48:28.000000000 +0100
@@ -176,11 +176,8 @@
 int sb_audio_open(int dev, int mode);
 void sb_audio_close(int dev);
 
-extern sb_devc *last_sb;
-
 /*	From sb_common.c */
 void sb_dsp_disable_midi(int port);
-void sb_dsp_disable_recording(int port);
 int probe_sbmpu (struct address_info *hw_config, struct module *owner);
 void unload_sbmpu (struct address_info *hw_config);
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/sb_common.c.old	2004-12-06 18:46:32.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sb_common.c	2004-12-06 18:48:45.000000000 +0100
@@ -81,7 +81,7 @@
 
 #endif
 
-sb_devc *last_sb;		/* Last sb loaded */
+static sb_devc *last_sb;		/* Last sb loaded */
 
 int sb_dsp_command(sb_devc * devc, unsigned char val)
 {
@@ -876,14 +876,6 @@
 	return 1;
 }
 
-void sb_dsp_disable_midi(int io_base)
-{
-}
-
-void sb_dsp_disable_recording(int io_base)
-{
-}
-
 /* if (sbmpu) below we allow mpu401 to manage the midi devs
    otherwise we have to unload them. (Andrzej Krzysztofowicz) */
    
@@ -1292,7 +1284,6 @@
 EXPORT_SYMBOL(sb_dsp_init);
 EXPORT_SYMBOL(sb_dsp_detect);
 EXPORT_SYMBOL(sb_dsp_unload);
-EXPORT_SYMBOL(sb_dsp_disable_midi);
 EXPORT_SYMBOL(sb_be_quiet);
 EXPORT_SYMBOL(probe_sbmpu);
 EXPORT_SYMBOL(unload_sbmpu);
--- linux-2.6.10-rc2-mm4-full/sound/oss/pas2_card.c.old	2004-12-06 18:48:55.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/pas2_card.c	2004-12-06 18:49:24.000000000 +0100
@@ -240,8 +240,6 @@
 	mix_write(0x80 | 5, 0x078B);
 	mix_write(5, 0x078B);
 
-#if !defined(DISABLE_SB_EMULATION)
-
 	{
 		struct address_info *sb_config;
 
@@ -279,9 +277,6 @@
 		else
 			pas_write(0x00, 0xF788);
 	}
-#else
-	pas_write(0x00, 0xF788);
-#endif
 
 	if (!ok)
 		printk(KERN_WARNING "PAS16: Driver not enabled\n");
@@ -349,11 +344,6 @@
 		if (config_pas_hw(hw_config))
 		{
 			pas_pcm_init(hw_config);
-
-#if !defined(MODULE) && !defined(DISABLE_SB_EMULATION)
-			sb_dsp_disable_midi(pas_sb_base);	/* No MIDI capability */
-#endif
-
 			pas_midi_init();
 			pas_init_mixer();
 		}
--- linux-2.6.10-rc2-mm4-full/sound/oss/sb_ess.c.old	2004-12-06 18:49:42.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sb_ess.c	2004-12-06 18:49:48.000000000 +0100
@@ -1696,7 +1696,7 @@
 	sb_common_mixer_set(devc, dev, left, right);
 }
 
-int es_rec_set_recmask(sb_devc * devc, int mask)
+static int es_rec_set_recmask(sb_devc * devc, int mask)
 {
 	int i, i_mask, cur_mask, diff_mask;
 	int value, left, right;
--- linux-2.6.10-rc2-mm4-full/sound/oss/sequencer.c.old	2004-12-06 18:51:13.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/sequencer.c	2004-12-06 18:51:27.000000000 +0100
@@ -1091,7 +1091,7 @@
 	return 0;
 }
 
-void seq_drain_midi_queues(void)
+static void seq_drain_midi_queues(void)
 {
 	int i, n;
 
--- linux-2.6.10-rc2-mm4-full/sound/oss/trident.c.old	2004-12-06 18:52:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/trident.c	2004-12-06 18:53:45.000000000 +0100
@@ -4014,7 +4014,8 @@
 	}
 }
 
-struct proc_dir_entry *res;
+static struct proc_dir_entry *res;
+
 static int
 ali_write_proc(struct file *file, const char __user *buffer, unsigned long count, void *data)
 {
--- linux-2.6.10-rc2-mm4-full/sound/oss/via82cxxx_audio.c.old	2004-12-06 18:55:33.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/via82cxxx_audio.c	2004-12-06 18:55:40.000000000 +0100
@@ -2174,7 +2174,7 @@
 #endif /* VM_RESERVED */
 
 
-struct vm_operations_struct via_mm_ops = {
+static struct vm_operations_struct via_mm_ops = {
 	.nopage		= via_mm_nopage,
 
 #ifndef VM_RESERVED
--- linux-2.6.10-rc2-mm4-full/sound/oss/wavfront.c.old	2004-12-06 18:55:53.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/oss/wavfront.c	2004-12-06 18:59:35.000000000 +0100
@@ -157,14 +157,14 @@
 		   board and load the firmware anyway.
 		*/
 		   
-int fx_raw = 1; /* if this is zero, we'll leave the FX processor in
-		   whatever state it is when the driver is loaded.
-		   The default is to download the microprogram and
-		   associated coefficients to set it up for "default"
-		   operation, whatever that means.
-		*/
+static int fx_raw = 1; /* if this is zero, we'll leave the FX processor in
+		          whatever state it is when the driver is loaded.
+		          The default is to download the microprogram and
+		          associated coefficients to set it up for "default"
+		          operation, whatever that means.
+		       */
 
-int debug_default;      /* you can set this to control debugging
+static int debug_default;  /* you can set this to control debugging
 			      during driver loading. it takes any combination
 			      of the WF_DEBUG_* flags defined in
 			      wavefront.h
@@ -172,33 +172,35 @@
 
 /* XXX this needs to be made firmware and hardware version dependent */
 
-char *ospath = "/etc/sound/wavefront.os"; /* where to find a processed
-					     version of the WaveFront OS
-					  */
-
-int wait_polls = 2000;	/* This is a number of tries we poll the status register
-			   before resorting to sleeping. WaveFront being an ISA
-			   card each poll takes about 1.2us. So before going to
-			   sleep we wait up to 2.4ms in a loop.
-			*/
+static char *ospath = "/etc/sound/wavefront.os"; /* where to find a processed
+					            version of the WaveFront OS
+					          */
+
+static int wait_polls = 2000; /* This is a number of tries we poll the
+				 status register before resorting to sleeping.
+				 WaveFront being an ISA card each poll takes
+				 about 1.2us. So before going to
+			         sleep we wait up to 2.4ms in a loop.
+			     */
+
+static int sleep_length = HZ/100; /* This says how long we're going to
+				     sleep between polls.
+			             10ms sounds reasonable for fast response.
+			          */
 
-int sleep_length = HZ/100; /* This says how long we're going to sleep between polls.
-			      10ms sounds reasonable for fast response.
-			   */
+static int sleep_tries = 50;       /* Wait for status 0.5 seconds total. */
 
-int sleep_tries = 50;       /* Wait for status 0.5 seconds total. */
-
-int reset_time = 2;        /* hundreths of a second we wait after a HW reset for
+static int reset_time = 2; /* hundreths of a second we wait after a HW reset for
 			      the expected interrupt.
 			   */
 
-int ramcheck_time = 20;    /* time in seconds to wait while ROM code
-			      checks on-board RAM.
-			   */
-
-int osrun_time = 10;       /* time in seconds we wait for the OS to
-			      start running.
-			   */
+static int ramcheck_time = 20;    /* time in seconds to wait while ROM code
+			             checks on-board RAM.
+			          */
+
+static int osrun_time = 10;  /* time in seconds we wait for the OS to
+			        start running.
+			     */
 
 module_param(wf_raw, int, 0);
 module_param(fx_raw, int, 0);
@@ -2036,7 +2038,7 @@
 	}
 }
 
-int
+static int
 wavefront_oss_load_patch (int devno, int format, const char __user *addr,
 			  int offs, int count, int pmgr_flag)
 {
@@ -2165,7 +2167,7 @@
 7 Unused
 */
 
-int
+static int
 wavefront_interrupt_bits (int irq)
 
 {
@@ -2193,7 +2195,7 @@
 	return bits;
 }
 
-void
+static void
 wavefront_should_cause_interrupt (int val, int port, int timeout)
 
 {
@@ -2895,16 +2897,6 @@
 	return 0;
 }	
 
-int __init attach_wffx (void)
-{
-	if ((dev.fx_mididev = sound_alloc_mididev ()) < 0) {
-		printk (KERN_WARNING LOGNAME "cannot install FX Midi driver\n");
-		return -1;
-	}
-
-	return 0;
-}
-
 void
 wffx_mute (int onoff)
     

