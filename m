Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWFYTjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFYTjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWFYTjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:39:43 -0400
Received: from ns2.suse.de ([195.135.220.15]:1190 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932233AbWFYTjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:39:42 -0400
From: Andi Kleen <ak@suse.de>
To: perex@suse.cz
Subject: Alsa update in mainline broke ATI-IXP sound driver
Date: Sun, 25 Jun 2006 21:39:35 +0200
User-Agent: KMail/1.9.3
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606252139.36002.ak@suse.de>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since I updated an ATI x86-64 box to 2.6.17-git6 sound doesn't work anymore.

I just get

ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_concat returned error: No such device
ALSA lib confmisc.c:955:(snd_func_refer) error evaluating name
ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_refer returned error: No such device
ALSA lib conf.c:3962:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM default

no matter how often I try. OSS clients also don't seem to work.
(in older kernels it sometimes didn't work on first try after boot, now it doesn't work 
at all)

The module loaded ok:

snd_pcm_oss            39328  0 
snd_mixer_oss          14784  1 snd_pcm_oss
snd_atiixp             16536  0 
snd_ac97_codec         97980  1 snd_atiixp
snd_ac97_bus            2688  1 snd_ac97_codec
snd_pcm                72328  3 snd_pcm_oss,snd_atiixp,snd_ac97_codec
snd_timer              19784  1 snd_pcm
snd_page_alloc          7824  2 snd_atiixp,snd_pcm
snd                    49280  6 snd_pcm_oss,snd_mixer_oss,snd_atiixp,snd_ac97_codec,snd_pcm,snd_timer

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP SB400 AC'97 Audio Controller

I can't find any output from alsa in the kernel log except for


PCI: Enabling device 0000:00:14.5 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 217

when restarting rcalsasoudn

User land is from SUSE 10.0

-Andi

config:


#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_ATIIXP=m
