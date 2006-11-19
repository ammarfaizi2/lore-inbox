Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756576AbWKSLuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbWKSLuj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756586AbWKSLui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 06:50:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40873 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1756576AbWKSLuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 06:50:37 -0500
Date: Sun, 19 Nov 2006 12:49:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Siemens SX1: sound cleanups
Message-ID: <20061119114938.GA22514@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are cleanups for codingstyle in sound parts of siemens sx1. They
should not change any code. Please apply,

								Pavel

diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.c b/sound/arm/omap/omap-alsa-sx1-mixer.c
index 8ca4c95..b036b3b 100644
--- a/sound/arm/omap/omap-alsa-sx1-mixer.c
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.c
@@ -29,41 +29,34 @@ #define M_DPRINTK(ARGS...)  		/* nop */
 
 static int current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
 static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
-static int current_volume 		= 0;	//current volume, we cant read it
-static int current_fm_volume 		= 0;	//current FM radio volume, we cant read it
+static int current_volume 		= 0;	/* current volume, we cant read it */
+static int current_fm_volume 		= 0;	/* current FM radio volume, we cant read it */
 
-/* TODO
- * For selecting SX1 recourd source.
+/* 
+ * Select SX1 recording source.
  */
 static void set_record_source(int val)
 {
-	// TODO	Recording is done on McBSP2	and Mic only
+	/* TODO Recording is done on McBSP2 and Mic only */
 	current_rec_src	= val;
 }
 
-/*
- * Converts the Alsa mixer volume (0 - 100) to SX1
- * (0 - 9) volume.
- */
-int set_mixer_volume(int mixerVol)
+int set_mixer_volume(int mixer_vol)
 {
-	int retVal;
+	/* FIXME: Alsa has mixer_vol in 0-100 range, while SX1 needs 0-9 range */
 
-	if ((mixerVol < 0) ||
-	    (mixerVol > 9) ){
-		printk(KERN_ERR "Trying a bad mixer volume (%d)!\n", mixerVol);
+	if ((mixer_vol < 0) || (mixer_vol > 9)) {
+		printk(KERN_ERR "Trying a bad mixer volume (%d)!\n", mixer_vol);
 		return -EPERM;
 	}
-	current_volume = mixerVol;	// set current volume, we cant read it
-	M_DPRINTK("mixer volume = %d\n", mixerVol);
+	current_volume = mixer_vol;	/* set current volume, we cant read it */
 
-	retVal	= cn_sx1snd_send(DAC_VOLUME_UPDATE, mixerVol, 0 );
-	return retVal;
+	return cn_sx1snd_send(DAC_VOLUME_UPDATE, mixer_vol, 0);
 }
 
 void set_loudspeaker_to_playback_target(void)
 {
-	// TODO
+	/* TODO */
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_SPEAKER, 0);
 
 	current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
@@ -71,7 +64,7 @@ void set_loudspeaker_to_playback_target(
 
 void set_headphone_to_playback_target(void)
 {
-	// TODO
+	/* TODO */
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_HEADPHONE, 0);
 
 	current_playback_target	= PLAYBACK_TARGET_HEADPHONE;
@@ -79,7 +72,7 @@ void set_headphone_to_playback_target(vo
 
 void set_telephone_to_playback_target(void)
 {
-	// TODO
+	/* TODO */
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
 
 	current_playback_target	= PLAYBACK_TARGET_CELLPHONE;
@@ -93,26 +86,21 @@ static void set_telephone_to_record_sour
 void init_playback_targets(void)
 {
 	set_loudspeaker_to_playback_target();
-
 	set_mixer_volume(DEFAULT_OUTPUT_VOLUME);
 }
 
 /*
- * Initializes SX1 recourd source (to mic) and playback target (to loudspeaker)
+ * Initializes SX1 record source (to mic) and playback target (to loudspeaker)
  */
 void snd_omap_init_mixer(void)
 {
-	FN_IN;
-
-	/* Select headset to record source (MIC_INHED)*/
+	/* Select headset to record source */
 	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
 	/* Init loudspeaker as a default playback target*/
 	init_playback_targets();
-
-	FN_OUT(0);
 }
 
-/*--------------------------------------------------------------------------------------------*/
+/* ---------------------------------------------------------------------------------------- */
 static int __pcm_playback_target_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	static char *texts[PLAYBACK_TARGET_COUNT] = {
@@ -125,8 +113,8 @@ static int __pcm_playback_target_info(sn
 	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1) {
         	uinfo->value.enumerated.item = PLAYBACK_TARGET_COUNT - 1;
 	}
-	strcpy(uinfo->value.enumerated.name,
-       	texts[uinfo->value.enumerated.item]);
+	strcpy(uinfo->value.enumerated.name, 
+	       texts[uinfo->value.enumerated.item]);
 	return 0;
 }
 
@@ -138,29 +126,27 @@ static int __pcm_playback_target_get(snd
 
 static int __pcm_playback_target_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	int	retVal;
-	int	curVal;
+	int ret_val = 0;
+	int cur_val = ucontrol->value.integer.value[0];
 
-	retVal	= 0;
-	curVal	= ucontrol->value.integer.value[0];
-	if ((curVal >= 0) &&
-	    (curVal < PLAYBACK_TARGET_COUNT) &&
-	    (curVal != current_playback_target)) {
-		if (curVal == PLAYBACK_TARGET_LOUDSPEAKER) {
+	if ((cur_val >= 0) &&
+	    (cur_val < PLAYBACK_TARGET_COUNT) &&
+	    (cur_val != current_playback_target)) {
+		if (cur_val == PLAYBACK_TARGET_LOUDSPEAKER) {
 			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
 			set_loudspeaker_to_playback_target();
  		}
-		else if (curVal == PLAYBACK_TARGET_HEADPHONE) {
+		else if (cur_val == PLAYBACK_TARGET_HEADPHONE) {
 			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HND);
  			set_headphone_to_playback_target();
  		}
-		else if (curVal == PLAYBACK_TARGET_CELLPHONE) {
+		else if (cur_val == PLAYBACK_TARGET_CELLPHONE) {
 			set_telephone_to_record_source();
 			set_telephone_to_playback_target();
 		}
-		retVal	= 1;
+		ret_val	= 1;
 	}
-	return retVal;
+	return ret_val;
 }
 
 /*--------------------------------------------------------------------------------------------*/
@@ -175,14 +161,11 @@ static int __pcm_playback_volume_info(sn
 
 /*
  * Alsa mixer interface function for getting the volume read from the SX1 in a
- * 0 -100 alsa mixer format.
+ * 0-100 alsa mixer format.
  */
 static int __pcm_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-
-	ucontrol->value.integer.value[0]	= current_volume;
-
-	M_DPRINTK("mixer volume = %ld\n", current_volume);
+	ucontrol->value.integer.value[0] = current_volume;
 	return 0;
 }
 
@@ -202,17 +185,17 @@ static int __pcm_playback_switch_info(sn
 
 static int __pcm_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= 1;
+	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int __pcm_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-//	return dac_gain_control_unmute(ucontrol->value.integer.value[0],
-//					ucontrol->value.integer.value[1]);
 	return 0;
 }
-/*--------------------------------------------------------------------------------------------*/
+
+/* -------------------------------------------------------------------------------------------- */
+
 static int __headset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -225,8 +208,6 @@ static int __headset_playback_volume_inf
 static int __headset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	ucontrol->value.integer.value[0]	= current_volume;
-
-	M_DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
 	return 0;
 }
 
@@ -246,19 +227,21 @@ static int __headset_playback_switch_inf
 
 static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= 1;
+	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	// mute/unmute headset
-//	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
-//				TSC2101_HEADSET_GAIN_CTRL,
-//				15);
+	/* mute/unmute headset */
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_HEADSET_GAIN_CTRL,
+				15);
+#endif
 	return 0;
 }
-/*--------------------------------------------------------------------------------------------*/
+/* -------------------------------------------------------------------------------------------- */
 static int __fmradio_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -270,9 +253,7 @@ static int __fmradio_playback_volume_inf
 
 static int __fmradio_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= current_fm_volume;
-
-	M_DPRINTK("mixer volume returned = %ld\n", ucontrol->value.integer.value[0]);
+	ucontrol->value.integer.value[0] = current_fm_volume;
 	return 0;
 }
 
@@ -294,21 +275,21 @@ static int __fmradio_playback_switch_inf
 
 static int __fmradio_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= 1;
+	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int __fmradio_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	// mute/unmute FM radio
-	if(ucontrol->value.integer.value[0])
+	/* mute/unmute FM radio */
+	if (ucontrol->value.integer.value[0])
 		cn_sx1snd_send(DAC_FMRADIO_OPEN, current_fm_volume, 0);
 	else
 		cn_sx1snd_send(DAC_FMRADIO_CLOSE, 0, 0);
 
 	return 0;
 }
-/*--------------------------------------------------------------------------------------------*/
+/* -------------------------------------------------------------------------------------------- */
 static int __cellphone_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
 	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -320,18 +301,19 @@ static int __cellphone_input_switch_info
 
 static int __cellphone_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= 1;
+	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int __cellphone_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-//	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
-//				TSC2101_BUZZER_GAIN_CTRL,
-//				15);
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL, 15);
+#endif
 	return 0;
 }
-/*--------------------------------------------------------------------------------------------*/
+/* -------------------------------------------------------------------------------------------- */
 
 static int __buzzer_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
@@ -344,15 +326,16 @@ static int __buzzer_input_switch_info(sn
 
 static int __buzzer_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-	ucontrol->value.integer.value[0]	= 1;
+	ucontrol->value.integer.value[0] = 1;
 	return 0;
 }
 
 static int __buzzer_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
-//	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
-//				TSC2101_BUZZER_GAIN_CTRL,
-//				6);
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL, 6);
+#endif
 	return 0;
 }
 /*--------------------------------------------------------------------------------------------*/
@@ -434,7 +417,6 @@ static snd_kcontrol_new_t egold_control[
 };
 
 #ifdef CONFIG_PM
-
 void snd_omap_suspend_mixer(void)
 {
 }
@@ -447,18 +429,16 @@ #endif
 
 int snd_omap_mixer(struct snd_card_omap_codec *egold)
 {
-	int i=0;
-	int err=0;
+	int i = 0;
+	int err = 0;
 
-	if (!egold) {
+	if (!egold)
 		return -EINVAL;
-	}
+
 	for (i=0; i < ARRAY_SIZE(egold_control); i++) {
-		if ((err = snd_ctl_add(egold->card,
-				snd_ctl_new1(&egold_control[i],
-				egold->card))) < 0) {
+		err = snd_ctl_add(egold->card, snd_ctl_new1(&egold_control[i], egold->card));
+		if (err < 0)
 			return err;
-		}
 	}
 	return 0;
 }
diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.h b/sound/arm/omap/omap-alsa-sx1-mixer.h
index e67f48a..02b8b6a 100644
--- a/sound/arm/omap/omap-alsa-sx1-mixer.h
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.h
@@ -30,8 +30,8 @@ #define PLAYBACK_TARGET_CELLPHONE	0x02
 
 /* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
 #define REC_SRC_TARGET_COUNT		0x08
-#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	// oss code referred to MIXER_LINE
-#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	// oss code referred to MIXER_MIC
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	/* oss code referred to MIXER_LINE */
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	/* oss code referred to MIXER_MIC */
 #define REC_SRC_SINGLE_ENDED_AUX1	0x02
 #define REC_SRC_SINGLE_ENDED_AUX2	0x03
 #define REC_SRC_MICIN_HED_AND_AUX1	0x04
@@ -39,7 +39,7 @@ #define REC_SRC_MICIN_HED_AND_AUX2	0x05
 #define REC_SRC_MICIN_HND_AND_AUX1	0x06
 #define REC_SRC_MICIN_HND_AND_AUX2	0x07
 
-#define DEFAULT_OUTPUT_VOLUME		5	// default output volume to dac dgc
-#define DEFAULT_INPUT_VOLUME		2	// default record volume
+#define DEFAULT_OUTPUT_VOLUME		5	/* default output volume to dac dgc */
+#define DEFAULT_INPUT_VOLUME		2	/* default record volume */
 
-#endif /*OMAPALSATSC2101MIXER_H_*/
+#endif
diff --git a/sound/arm/omap/omap-alsa-sx1.c b/sound/arm/omap/omap-alsa-sx1.c
index 0edaf95..64c09dc 100644
--- a/sound/arm/omap/omap-alsa-sx1.c
+++ b/sound/arm/omap/omap-alsa-sx1.c
@@ -20,9 +20,7 @@ #include <asm/io.h>
 #include <asm/arch/mcbsp.h>
 
 #include <linux/slab.h>
-#ifdef CONFIG_PM
 #include <linux/pm.h>
-#endif
 #include <asm/mach-types.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/clock.h>
@@ -31,18 +29,11 @@ #include <asm/arch/gpio.h>
 #include <asm/arch/omap-alsa.h>
 #include "omap-alsa-sx1.h"
 
-//#include <linux/skbuff.h>
 #include <linux/connector.h>
 
-//#define M_DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
-#define M_DPRINTK(ARGS...)  		/* nop */
-
-//static struct clk *egold_mclk = 0;
-
 /* Connector implementation */
 static struct cb_id cn_sx1snd_id = { CN_IDX_SX1SND, CN_VAL_SX1SND };
 static char cn_sx1snd_name[] = "cn_sx1snd";
-//static struct sock *nls;
 
 void cn_sx1snd_callback(void *data)
 {
@@ -52,39 +43,39 @@ void cn_sx1snd_callback(void *data)
            __func__, jiffies, msg->id.idx, msg->id.val,
            msg->seq, msg->ack, msg->len, (char *)msg->data);
 }
+
 /* Send IPC message to sound server */
 extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2)
 {
 	struct cn_msg *m;
 	unsigned short data[3];
-	int	err;
+	int err;
 
-	m = kmalloc(sizeof(*m) + sizeof(data), GFP_ATOMIC);
-	if (m) {
-		memset(m, 0, sizeof(*m) + sizeof(data));
+	m = kzalloc(sizeof(*m) + sizeof(data), GFP_ATOMIC);
+	if (!m)
+		return -1; 
 
-		memcpy(&m->id, &cn_sx1snd_id, sizeof(m->id));
-		m->seq = 1;//cn_test_timer_counter;
-		m->len = sizeof(data);
+	memcpy(&m->id, &cn_sx1snd_id, sizeof(m->id));
+	m->seq = 1;
+	m->len = sizeof(data);
 
-		data[0] = (unsigned short)cmd;
-		data[1] = (unsigned short)arg1;
-		data[2] = (unsigned short)arg2;
+	data[0] = (unsigned short)cmd;
+	data[1] = (unsigned short)arg1;
+	data[2] = (unsigned short)arg2;
 
-		memcpy(m + 1, data, m->len);
+	memcpy(m + 1, data, m->len);
 
-		err = cn_netlink_send(m, CN_IDX_SX1SND, gfp_any());
-		M_DPRINTK("sent= %02X %02X %02X, err=%d\n", cmd,arg1,arg2,err);
-		kfree(m);
-		if(err == -ESRCH)
-			return -1;	// there are no listeners on socket
-		return 0;
-	}
-	return -1;	// some error
+	err = cn_netlink_send(m, CN_IDX_SX1SND, gfp_any());
+	snd_printd("sent= %02X %02X %02X, err=%d\n", cmd,arg1,arg2,err);
+	kfree(m);
+
+	if (err == -ESRCH)
+		return -1;	/* there are no listeners on socket */
+	return 0;
 }
 
-/* * Hardware capabilities */
-/*
+/* Hardware capabilities
+ *
  * DAC USB-mode sampling rates (MCLK = 12 MHz)
  * The rates and rate_reg_into MUST be in the same order
  */
@@ -142,7 +133,7 @@ static snd_pcm_hardware_t egold_snd_omap
 	.fifo_size = 0,
 };
 
-static long current_rate = -1;// current rate in egold format 0..8
+static long current_rate = -1; /* current rate in egold format 0..8 */
 /*
  * ALSA operations according to board file
  */
@@ -154,14 +145,14 @@ void egold_set_samplerate(long sample_ra
 {
 	int egold_rate = 0;
 	int clkgdv = 0;
-
 	u16 srgr1, srgr2;
-	ADEBUG();
 
 	/* Set the sample rate */
-//	clkgdv	= CODEC_CLOCK / (sample_rate * (DEFAULT_BITPERSAMPLE * 2 - 1)); //fw15: 5005E490 - divs are different !!!
-	switch(sample_rate)
-	 {
+#if 0
+	/* fw15: 5005E490 - divs are different !!! */
+	clkgdv	= CODEC_CLOCK / (sample_rate * (DEFAULT_BITPERSAMPLE * 2 - 1));
+#endif
+	switch (sample_rate) {
 		case 8000:	clkgdv = 71; egold_rate = FRQ_8000; break;
 		case 11025:	clkgdv = 51; egold_rate = FRQ_11025; break;
 		case 12000:	clkgdv = 47; egold_rate = FRQ_12000; break;
@@ -171,7 +162,7 @@ void egold_set_samplerate(long sample_ra
 		case 32000:	clkgdv = 17; egold_rate = FRQ_32000; break;
 		case 44100:	clkgdv = 12; egold_rate = FRQ_44100; break;
 		case 48000:	clkgdv = 11; egold_rate = FRQ_48000; break;
-	 }
+	}
 
 	srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
 	srgr2 = ((FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1)));
@@ -179,7 +170,7 @@ void egold_set_samplerate(long sample_ra
 	OMAP_MCBSP_WRITE(OMAP1510_MCBSP1_BASE, SRGR2, srgr2);
 	OMAP_MCBSP_WRITE(OMAP1510_MCBSP1_BASE, SRGR1, srgr1);
 	current_rate = egold_rate;
-	M_DPRINTK("set samplerate=%ld\n", sample_rate);
+	snd_printd("set samplerate=%ld\n", sample_rate);
 
 }
 
@@ -201,8 +192,8 @@ void egold_configure(void)
 void egold_clock_setup(void)
 {
 	omap_request_gpio(OSC_EN);
-	omap_set_gpio_direction(OSC_EN, 0); // output pin
-	M_DPRINTK("\n");
+	omap_set_gpio_direction(OSC_EN, 0); /* output */
+	snd_printd("\n");
 }
 
 /*
@@ -211,10 +202,10 @@ void egold_clock_setup(void)
 int egold_clock_on(void)
 {
 	omap_set_gpio_dataout(OSC_EN, 1);
-	egold_set_samplerate(44100);// TODO
+	egold_set_samplerate(44100); /* TODO */
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_SPEAKER, 0);
 	cn_sx1snd_send(DAC_OPEN_DEFAULT, current_rate , 4);
-	M_DPRINTK("\n");
+	snd_printd("\n");
 	return 0;
 }
 
@@ -226,37 +217,37 @@ int egold_clock_off(void)
 	cn_sx1snd_send(DAC_CLOSE, 0 , 0);
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
 	omap_set_gpio_dataout(OSC_EN, 0);
-	M_DPRINTK("\n");
+	snd_printd("\n");
 	return 0;
 }
 
 int egold_get_default_samplerate(void)
 {
-	M_DPRINTK("\n");
+	snd_printd("\n");
 	return DEFAULT_SAMPLE_RATE;
 }
 
 static int __init snd_omap_alsa_egold_probe(struct platform_device *pdev)
 {
-	int	ret;
-	struct	omap_alsa_codec_config *codec_cfg;
+	int ret;
+	struct omap_alsa_codec_config *codec_cfg;
 
 	codec_cfg = pdev->dev.platform_data;
-	if (codec_cfg != NULL) {
-		codec_cfg->hw_constraints_rates	= &egold_hw_constraints_rates;
-		codec_cfg->snd_omap_alsa_playback  = &egold_snd_omap_alsa_playback;
-		codec_cfg->snd_omap_alsa_capture  = &egold_snd_omap_alsa_capture;
-		codec_cfg->codec_configure_dev	= egold_configure;
-		codec_cfg->codec_set_samplerate	= egold_set_samplerate;
-		codec_cfg->codec_clock_setup	= egold_clock_setup;
-		codec_cfg->codec_clock_on	= egold_clock_on;
-		codec_cfg->codec_clock_off	= egold_clock_off;
-		codec_cfg->get_default_samplerate = egold_get_default_samplerate;
-		ret	= snd_omap_alsa_post_probe(pdev, codec_cfg);
-	}
-	else
-		ret = -ENODEV;
-	M_DPRINTK("\n");
+	if (!codec_cfg)
+		return -ENODEV;
+
+	codec_cfg->hw_constraints_rates	= &egold_hw_constraints_rates;
+	codec_cfg->snd_omap_alsa_playback  = &egold_snd_omap_alsa_playback;
+	codec_cfg->snd_omap_alsa_capture  = &egold_snd_omap_alsa_capture;
+	codec_cfg->codec_configure_dev	= egold_configure;
+	codec_cfg->codec_set_samplerate	= egold_set_samplerate;
+	codec_cfg->codec_clock_setup	= egold_clock_setup;
+	codec_cfg->codec_clock_on	= egold_clock_on;
+	codec_cfg->codec_clock_off	= egold_clock_off;
+	codec_cfg->get_default_samplerate = egold_get_default_samplerate;
+	ret = snd_omap_alsa_post_probe(pdev, codec_cfg);
+
+	snd_printd("\n");
 	return ret;
 }
 
@@ -273,7 +264,7 @@ static struct platform_driver omap_alsa_
 static int __init omap_alsa_egold_init(void)
 {
 	int	retval;
-	ADEBUG();
+
 	retval = cn_add_callback(&cn_sx1snd_id, cn_sx1snd_name, cn_sx1snd_callback);
 	if(retval)
 		printk(KERN_WARNING "cn_sx1snd failed to register\n");
@@ -282,7 +273,6 @@ static int __init omap_alsa_egold_init(v
 
 static void __exit omap_alsa_egold_exit(void)
 {
-	ADEBUG();
 	cn_del_callback(&cn_sx1snd_id);
 	platform_driver_unregister(&omap_alsa_driver);
 }
diff --git a/sound/arm/omap/omap-alsa-sx1.h b/sound/arm/omap/omap-alsa-sx1.h
index fdf55ee..34e26fc 100644
--- a/sound/arm/omap/omap-alsa-sx1.h
+++ b/sound/arm/omap/omap-alsa-sx1.h
@@ -27,14 +27,14 @@ #define DEFAULT_BITPERSAMPLE		16
 #endif
 
 #define DEFAULT_SAMPLE_RATE		44100
-// fw15: 18356000
+/* fw15: 18356000 */
 #define CODEC_CLOCK 			18359000
-// McBSP for playing music
+/* McBSP for playing music */
 #define AUDIO_MCBSP        		OMAP_MCBSP1
-// McBSP for record/play audio from phone and mic
+/* McBSP for record/play audio from phone and mic */
 #define AUDIO_MCBSP_PCM    		OMAP_MCBSP2
-// gpio pin for enable/disable clock
-#define OSC_EN					2
+/* gpio pin for enable/disable clock */
+#define OSC_EN				2
 
 /*
  * Defines codec specific functions pointers that can be used from the
@@ -49,25 +49,25 @@ int egold_get_default_samplerate(void);
 
 /* Send IPC message to sound server */
 extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2);
-// cmd for IPC_GROUP_DAC
+/* cmd for IPC_GROUP_DAC */
 #define DAC_VOLUME_UPDATE		0
 #define DAC_SETAUDIODEVICE		1
 #define DAC_OPEN_RING			2
 #define DAC_OPEN_DEFAULT		3
-#define DAC_CLOSE				4
+#define DAC_CLOSE			4
 #define DAC_FMRADIO_OPEN		5
 #define DAC_FMRADIO_CLOSE		6
 #define DAC_PLAYTONE			7
-// cmd for IPC_GROUP_PCM
-#define PCM_PLAY				(0+8)
+/* cmd for IPC_GROUP_PCM */
+#define PCM_PLAY			(0+8)
 #define PCM_RECORD			(1+8)
-#define PCM_CLOSE				(2+8)
+#define PCM_CLOSE			(2+8)
 
-// for DAC_SETAUDIODEVICE
+/* for DAC_SETAUDIODEVICE */
 #define SX1_DEVICE_SPEAKER		0
 #define SX1_DEVICE_HEADPHONE		4
 #define SX1_DEVICE_PHONE		3
-// frequencies for MdaDacOpenDefaultL,  MdaDacOpenRingL
+/* frequencies for MdaDacOpenDefaultL,  MdaDacOpenRingL */
 #define FRQ_8000        0
 #define FRQ_11025       1
 #define FRQ_12000       2
@@ -78,6 +78,4 @@ #define FRQ_32000       6
 #define FRQ_44100       7
 #define FRQ_48000       8
 
- /* Netlink socket defs for connection with userspace MUX */
-
-#endif /*OMAP_ALSA_SX1_H_*/
+#endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
