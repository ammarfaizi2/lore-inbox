Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWFZQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWFZQgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWFZQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:36:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:43745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750780AbWFZQgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:36:02 -0400
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver II
Date: Mon, 26 Jun 2006 18:35:47 +0200
User-Agent: KMail/1.9.3
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <200606252139.36002.ak@suse.de> <s5hpsgw9qgz.wl%tiwai@suse.de>
In-Reply-To: <s5hpsgw9qgz.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261835.47796.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 12:11, Takashi Iwai wrote:
> At Sun, 25 Jun 2006 21:39:35 +0200,
> Andi Kleen wrote:
> > 
> > 
> > Since I updated an ATI x86-64 box to 2.6.17-git6 sound doesn't work anymore.
> > 
> > I just get
> > 
> > ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> > ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
> (snip) 
> > User land is from SUSE 10.0
> 
> First check /proc/asound/cards after loading snd-atiixp.

Checking it now. There is no /proc/asound.

% ls /proc/asound
/bin/ls: /proc/asound: No such file or directory


These are my config options

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
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set

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


> If the ATI 
> IXP entry appears, the device was initialized and set up.  If not,
> something wrong in the driver initialization.
> 
> Then check whether /dev/snd/controlC0 exists.  If not, it's likely a
> udev thingy.  Possibly upgrading udev package might help...

% ls -l /dev/snd/controlC0 
crw-------  1 andi audio 116, 0 2006-06-25 21:38 /dev/snd/controlC0

% grep sound /proc/devices 
14 sound

-Andi

