Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWF2TYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWF2TYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWF2TWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:22:53 -0400
Received: from [141.84.69.5] ([141.84.69.5]:37136 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932297AbWF2TW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:22:27 -0400
Date: Thu, 29 Jun 2006 21:21:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz, Olaf Hering <olh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: OSS driver removal, 2nd round
Message-ID: <20060629192128.GE19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I've sent the first round of actually removing the code for OSS 
drivers where ALSA drivers without regressions exist for the same 
hardware, it's time for a second round amongst the remaining drivers.


Removing OSS drivers where ALSA drivers for the same hardware exists has 
two reasons:

1. remove obsolete and mostly unmaintained code
2. get bugs in the ALSA drivers reported that weren't previously
   reported due to the possible workaround of using the OSS drivers


The list below divides the OSS drivers into the following three
categories:
1. ALSA drivers for the same hardware
2. ALSA drivers for the same hardware with known problems
3. no ALSA drivers for the same hardware


My proposed timeline is:
- 2.6.18: let the drivers under 1. in the list below depend on
          OSS_OBSOLETE_DRIVER
- 2.6.20: remove the options depending on OSS_OBSOLETE_DRIVER
- 2.6.22: remove the code for the drivers that were depending on
          OSS_OBSOLETE_DRIVER from the kernel tree


To make a long story short:

If you are using an OSS driver because the ALSA driver doesn't work 
equally well on your hardware listed under 1. below, send me an email 
with a bug number in the ALSA bug tracking system now.


A small FAQ:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.

Q: What about the OSS emulation in ALSA?
A: The OSS emulation in ALSA is not affected by my patches
   (and it's not in any way scheduled for removal).


Please review the following list:


1. ALSA drivers for the same hardware

SOUND_ACI_MIXER and RADIO_MIROPCM20
SOUND_AD1889
SOUND_ADLIB
SOUND_FUSION
SOUND_NM256
SOUND_OPL3SA2

2. ALSA drivers for the same hardware with known problems

DMASOUND_PMAC
- Olaf Hering regarding regressions in SND_POWERMAC:
  Some tumbler models work only after one plug/unplug cycle of
  the headphone. early powerbooks report/handle the mute settings
  incorrectly. there are likely more bugs.

SOUND_AD1816
- ALSA #1301 (Kernel OSS emulation stops working after a few seconds
              when used with VoIP softphones)

SOUND_CS4232
- ALSA #1520 (Soundchip was not detected on HP Omnibook 5700 CTX)

SOUND_EMU10K1
- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
- ALSA #1782 (really poor sound with my SB Live 1024 and ALSA)

SOUND_ES1371
- ALSA #1774 (missing joystick connector support for PCI Ensoniq ES1371)

SOUND_ICH
- ALSA #1764 (Recording signal quality is inacceptable (using OSS API))
- Alan Cox:
  ALSA driver lacks "support for AC97 wired touchscreens and the like"

SOUND_SSCAPE
- ALSA #2234 (driver does not find Soundscape Elite)

SOUND_TRIDENT
- ALSA #1293 (device supported by OSS but not by ALSA)
- maintainer of the OSS driver wants his driver to stay

SOUND_VIA82CXXX
- ALSA #1906 (1-second overruns reported by arecord,
              complete system hang with jackd -d alsa)


3. no ALSA drivers for the same hardware

DMASOUND_ATARI
DMASOUND_PAULA
DMASOUND_Q40
SOUND_AEDSP16
SOUND_AU1550_AC97
SOUND_BCM_CS4297A
SOUND_HAL2
SOUND_IT8172
SOUND_KAHLUA
SOUND_MSNDCLAS
SOUND_MSNDPIN
SOUND_MSS (also due to SOUND_PSS, SOUND_TRIX and perhaps SOUND_AEDSP16)
SOUND_PAS
SOUND_PSS
SOUND_SB (also due to SOUND_KAHLUA, SOUND_PAS and perhaps SOUND_AEDSP16)
SOUND_SH_DAC_AUDIO
SOUND_TRIX
SOUND_VIDC
SOUND_VRC5477
SOUND_VWSND
SOUND_WAVEARTIST


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

