Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314640AbSD0XId>; Sat, 27 Apr 2002 19:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314642AbSD0XIc>; Sat, 27 Apr 2002 19:08:32 -0400
Received: from ECE.CMU.EDU ([128.2.136.200]:63972 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S314640AbSD0XIb>;
	Sat, 27 Apr 2002 19:08:31 -0400
Date: Sat, 27 Apr 2002 19:08:16 -0400 (EDT)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
To: jgarzik@mandrakesoft.com
cc: linux-kernel@vger.kernel.org
Subject: via82cxxx_audio bug in kernel-2.4.18
In-Reply-To: <87bsjt59jb.fsf@pixie.eng.ascend.com>
Message-ID: <Pine.LNX.3.96L.1020427185739.8423C-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using 2.4.18 kernel of mandrake-8.2 . Sound is played ok until
'dmesg' shows these error messages:

Assertion failed! chan->is_active ==
sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198
Assertion failed! chan->is_active ==
sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198
Assertion failed! chan->is_active ==
sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198
via_audio: ignoring drain playback error -512
Assertion failed! chan->is_active ==
sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1198
via_audio: ignoring drain playback error -512

The lsmod output after the error shows nothing strange:

Module                  Size  Used by    Not tainted
via82cxxx_audio        18144   0
uart401                 6336   0 [via82cxxx_audio]
ac97_codec              9568   0 [via82cxxx_audio]
sound                  57292   0 [via82cxxx_audio uart401]
soundcore               4068   5 [via82cxxx_audio sound]

After this error no sound is played. Unload and reload of via82cxxx_audio
makes no difference. Only way out is reboot.

Output of 'via-audio-diag -eps':

via-audio-diag.c:v1.00 05/06/2000 Jeff Garzik (jgarzik@mandrakesoft.com)
Index #1: Found a via 686a audio adapter at 0xcc00.
AC97 RESET = 0x6D50 (27984)
AC97 MASTER_VOL_STEREO = 0x0A0A (2570)
AC97 HEADPHONE_VOL = 0x0A0A (2570)
AC97 MASTER_VOL_MONO = 0x000A (10)
AC97 MASTER_TONE = 0x0000 (0)
AC97 PCBEEP_VOL = 0x000A (10)
AC97 PHONE_VOL = 0x000A (10)
AC97 MIC_VOL = 0x8000 (32768)
AC97 LINEIN_VOL = 0x0A0A (2570)
AC97 CD_VOL = 0x0A0A (2570)
AC97 VIDEO_VOL = 0x0A0A (2570)
AC97 AUX_VOL = 0x0A0A (2570)
AC97 PCMOUT_VOL = 0x0000 (0)
AC97 RECORD_SELECT = 0x0000 (0)
AC97 RECORD_GAIN = 0x0A0A (2570)
AC97 RECORD_GAIN_MIC = 0x0000 (0)
AC97 GENERAL_PURPOSE = 0x0000 (0)
AC97 3D_CONTROL = 0x0000 (0)
AC97 MODEM_RATE = 0x0000 (0)
AC97 POWER_CONTROL = 0x000F (15)
AC97 EXTENDED_ID = 0x0201 (513)
AC97 EXTENDED_STATUS = 0x0001 (1)
AC97 PCM_FRONT_DAC_RATE = 0xBB80 (48000)
AC97 PCM_SURR_DAC_RATE = 0x0000 (0)
AC97 PCM_LFE_DAC_RATE = 0x0000 (0)
AC97 PCM_LR_ADC_RATE = 0xBB80 (48000)
AC97 PCM_MIC_ADC_RATE = 0x0000 (0)
AC97 CENTER_LFE_MASTER = 0x0000 (0)
AC97 SURROUND_MASTER = 0x0000 (0)
AC97 RESERVED_3A = 0x0000 (0)
SGD Playback            : 88 00 B7 01EC1088 00000000
SGD Record              : 00 00 00 00000000 00000000
SGD FM                  : 00 00 00 00000000 00000000
SGD Modem Playback      : 00 00 00 00000000 00000000
SGD Modem Record        : 00 00 00 00000000 00000000
SGD reg 0x80 = 0x00BA0000
SGD reg 0x84 = 0x00001000
SGD reg 0x88 = 0x00000000
SGD reg 0x8C = 0x00000000
PCI reg 0x10 = 0xD8000008
PCI reg 0x3C = 0x00
PCI reg 0x40 = 0x00
PCI reg 0x41 = 0x00
PCI reg 0x42 = 0x00
PCI reg 0x43 = 0x00
PCI reg 0x44 = 0x00
PCI reg 0x48 = 0x00

