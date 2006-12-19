Return-Path: <linux-kernel-owner+w=401wt.eu-S1752407AbWLSEMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWLSEMH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbWLSEMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:12:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4453 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752407AbWLSEMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:12:03 -0500
Date: Tue, 19 Dec 2006 05:11:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org
Subject: OSS driver removal, 3nd round
Message-ID: <20061219041159.GA6993@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the second round of removing options for OSS drivers where ALSA 
drivers without regressions exist for the same hardware got included in 
Linus' tree, it's time for a third round amongst the remaining drivers.


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


The proposed timeline is:
- 2.6.20: let the drivers under 1. in the list below depend on
          OSS_OBSOLETE
- 2.6.22: remove the options depending on OSS_OBSOLETE
- 2.6.24: remove the code for the drivers that were depending on
          OSS_OBSOLETE from the kernel tree


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

DMASOUND_PMAC
SOUND_ES1371


2. ALSA drivers for the same hardware with known problems

SOUND_CS4232
- ALSA #1520 (Soundchip was not detected on HP Omnibook 5700 CTX)

SOUND_ICH
- Alan Cox:
  ALSA driver lacks "support for AC97 wired touchscreens and the like"

SOUND_SSCAPE
- ALSA #2234 (driver does not find Soundscape Elite)

SOUND_TRIDENT
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


