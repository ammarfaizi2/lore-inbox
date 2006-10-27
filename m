Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWJ0PuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWJ0PuL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJ0PuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:50:11 -0400
Received: from opensubscriber.com ([206.222.18.114]:10885 "EHLO
	mail.opensubscriber.com") by vger.kernel.org with ESMTP
	id S1750933AbWJ0PuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:50:10 -0400
Date: Fri, 27 Oct 2006 23:50:09 +0800
Message-ID: <5263041.1161964209062.JavaMail.websites@opensubscriber>
From: saravanan_sprt@hotmail.com
Reply-To: saravanan_sprt@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: UCB1400 pxa2xx-ac97 failed with error -13 on PXA2xx
In-Reply-To: <200507281729.j6SHTtTa005793@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I am facing the following problem with ALSA and UCB1400 codec on Colibri PXA270. After having applied Nicolas patches and platform entries in colibri.c, I get the following boot up error messages which annoys me a lot. 
......... 
ts: UCB1x00 touchscreen protocol output
ts: Compaq touchscreen protocol output 
Colibri MMC/SD setup done. 
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC). 
pxa2xx_ac97_reset: cold reset timeout (GSR=0x0) 
pxa2xx_ac97_reset: warm reset timeout (GSR=0x0) 
pxa2xx_ac97_read: CAR_CAIP already set 
pxa2xx_ac97_write: CAR_CAIP already set 
pxa2xx_ac97_read: CAR_CAIP already set 
pxa2xx_ac97_read: CAR_CAIP already set 
ALSA sound/pci/ac97/ac97_codec.c:1932: AC'97 0 access error (not audio or modem codec) 
pxa2xx-ac97: probe of pxa2xx-ac97 failed with error -13 
ALSA device list: 
  No soundcards found. 
..... 
Can anyone tell me what went wrong and here's the kernel config which I use similar to the previous posts by Takács Áron. 
# 
# Sound 
# 
CONFIG_SOUND=y 
# 
# Advanced Linux Sound Architecture 
# 
CONFIG_SND=y 
CONFIG_SND_TIMER=y 
CONFIG_SND_PCM=y 
# CONFIG_SND_SEQUENCER is not set 
CONFIG_SND_OSSEMUL=y 
CONFIG_SND_MIXER_OSS=y 
CONFIG_SND_PCM_OSS=y 
CONFIG_SND_VERBOSE_PRINTK=y 
CONFIG_SND_DEBUG=y 
# CONFIG_SND_DEBUG_MEMORY is not set 
# CONFIG_SND_DEBUG_DETECT is not set 
# 
# Generic devices 
# 
# CONFIG_SND_DUMMY is not set 
# CONFIG_SND_MTPAV is not set 
# CONFIG_SND_SERIAL_U16550 is not set 
# CONFIG_SND_MPU401 is not set 
CONFIG_SND_AC97_CODEC=y 
# 
# ALSA ARM devices 
# 
CONFIG_SND_PXA2xx_AC97=y 
CONFIG_SND_PXA2xx_PCM=y 
and made the following changes in the colibri.c for platform entries 
static struct platform_device ucb1400_audio_device = { 
.name = "pxa2xx-ac97", 
.id = -1, 
}; 
static struct platform_device *devices[] __initdata = { 
#ifdef CONFIG_DM9000 
    &dm9000_device, 
#endif 
    &ucb1400_audio_device, 
}; 

It would be garteful, if anyone could help me to fix these issues. 
Thanks 
Sara 

--
This message was sent on behalf of saravanan_sprt@hotmail.com at openSubscriber.com
http://www.opensubscriber.com/message/linux-kernel@vger.kernel.org/1825733.html
