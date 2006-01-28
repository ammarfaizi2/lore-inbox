Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWA1Wr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWA1Wr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 17:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWA1Wr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 17:47:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37643 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750771AbWA1Wr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 17:47:58 -0500
Date: Sat, 28 Jan 2006 23:47:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, perex@suse.cz
Subject: OSS driver removal, a slightly different approach (v3)
Message-ID: <20060128224758.GR3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My proposal to remove OSS drivers where ALSA drivers for the same
hardware exists had two reasons:

1. remove obsolete and mostly unmaintained code
2. get bugs in the ALSA drivers reported that weren't previously
   reported due to the possible workaround of using the OSS drivers

I'm slowly getting more and more reports for the second case.


The list below divides the OSS drivers into the following three
categories:
1. ALSA drivers for the same hardware
2. ALSA drivers for the same hardware with known problems
3. no ALSA drivers for the same hardware


My proposed timeline is:
- shortly before 2.6.16 is released:
  adjust OBSOLETE_OSS_DRIVER dependencies to match exactly the
  drivers under 1.
- from the release of 2.6.16 till the release of 2.6.17:
  approx. two months for users to report problems with the ALSA
  drivers for the same hardware
- after the release of 2.6.17 (and before 2.6.18):
  remove the subset of drivers marked at OBSOLETE_OSS_DRIVER without
  known regressions in the ALSA drivers for the same hardware


To make a long story short:

If you are using an OSS driver because the ALSA driver doesn't work
equally well on your hardware, send me an email with a bug number in the
ALSA bug tracking system now.


A small FAQ:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.

Q: What about the OSS emulation in ALSA?
A: The OSS emulation in ALSA is not affected by my patches
   (and it's not in any way scheduled for removal).


Please review the following list:


1. ALSA drivers for the same hardware 

SOUND_AD1889
SOUND_AD1980
SOUND_ALI5455
SOUND_AU1000
SOUND_AWE32_SYNTH
SOUND_CMPCI
SOUND_CS4232
SOUND_CS4281
SOUND_ES1370
SOUND_ESSSOLO1
SOUND_FORTE
SOUND_FUSION
SOUND_GUS
SOUND_HARMONY
SOUND_MAD16
SOUND_MAESTRO
SOUND_MAESTRO3
SOUND_MAUI
SOUND_OPL3SA1
SOUND_OPL3SA2
SOUND_RME96XX
SOUND_SGALAXY
SOUND_SONICVIBES
SOUND_SSCAPE
SOUND_VIA82CXXX
SOUND_WAVEFRONT
SOUND_YMFPCI


2. ALSA drivers for the same hardware with known problems

DMASOUND_PMAC
- Olaf Hering regarding regressions in SND_POWERMAC:
  Some tumbler models work only after one plug/unplug cycle of
  the headphone. early powerbooks report/handle the mute settings
  incorrectly. there are likely more bugs.

SOUND_AD1816
- ALSA #1301 (Kernel OSS emulation stops working after a few seconds
              when used with VoIP softphones)

SOUND_EMU10K1
- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
- ALSA #1782 (really poor sound with my SB Live 1024 and ALSA)

SOUND_ES1371
- ALSA #1774 (missing joystick connector support for PCI Ensoniq ES1371) (*)

SOUND_ICH
- ALSA #1764 (Recording signal quality is inacceptable (using OSS API))
- Alan Cox:
  ALSA driver lacks "support for AC97 wired touchscreens and the like"

SOUND_NM256
- ALSA #328 (snd-nm256 freezes Dell Latitude LS)

SOUND_TRIDENT
- ALSA #1293 (device supported by OSS but not by ALSA)
- maintainer of the OSS driver wants his driver to stay


3. no ALSA drivers for the same hardware

DMASOUND_ATARI
DMASOUND_PAULA
DMASOUND_Q40
SOUND_ACI_MIXER
SOUND_ADLIB
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

