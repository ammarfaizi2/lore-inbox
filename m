Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDPXNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTDPXNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:13:46 -0400
Received: from ulm9-d9bb53ca.pool.mediaWays.net ([217.187.83.202]:16769 "EHLO
	openworld.de") by vger.kernel.org with ESMTP id S261876AbTDPXNn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:13:43 -0400
From: Artjom Simon <hoek@linuxartist.org>
Reply-To: hoek@linuxartist.org
To: linux-kernel@vger.kernel.org
Subject: [2.5.67] SB-AWE32 + ALSA: "snd_sbawe: falsely claims to have parameter pnp"
Date: Thu, 17 Apr 2003 01:26:07 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304170126.07245.hoek@linuxartist.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just compiled the new 2.5.67 kernel.
Everything seems to be (surprisingly) fine, with one exception:
I have a ISA SoundBlaster AWE32 card, it worked perfectly with 2.4.X and
alsa 0.9.x.
I selected the following options when compiling:

---
#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# ISA devices
#
[...]
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
---

OSS is completely disabled.
My /etc/modules.d/alsa (using Gentoo) looks as follows:

---
alias char-major-116 snd
options snd major=116 cards_limit=1

alias char-major-14 soundcore
alias snd-card-0 snd-sbawe
alias sound-slot-0 snd-card-0

alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
---

All sound related modules load correctly, with the exception of snd_sbawe:

FATAL: Error inserting snd_sbawe
(/lib/modules/2.5.67/kernel/sound/isa/sb/snd-sbawe.ko): Invalid argument

The output of dmesg explains the "invalid argument":

---
[...]
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE32 PnP'
isapnp: 1 Plug & Play card detected total
[...]
snd_sbawe: falsely claims to have parameter pnp
snd_sbawe: falsely claims to have parameter pnp
snd_sbawe: falsely claims to have parameter pnp
---

Any hints what I should do now?

Thanks in advance,
 Artjom
