Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281213AbRKLXuI>; Mon, 12 Nov 2001 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKLXtx>; Mon, 12 Nov 2001 18:49:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:62226 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281213AbRKLXtg>;
	Mon, 12 Nov 2001 18:49:36 -0500
Date: Mon, 12 Nov 2001 22:06:30 -0200
From: sergio@bruder.net
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: via82cxxx_audio problems
Message-ID: <20011112220630.A1200@bruder.net>
Reply-To: sergio@bruder.net
Mail-Followup-To: sergio@bruder.net, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a little problem with an via82cxxx_audio sound
(on-)board, someone already saw this?

kernel 2.4.14 + 1.1.19 version of via82cxxx_audio driver:

With rapid fast-forward in mplayer, The sound just mutes itself and
mplayer just crawls down to 1-2 frames per second. Looking at
/var/log/messages Ive got:

Nov 12 21:51:36 stratus kernel: via_audio: ignoring drain playback error -11
Nov 12 21:52:08 stratus last message repeated 2 times
Nov 12 21:52:19 stratus kernel: via_audio: ignoring drain playback error -11
Nov 12 21:55:32 stratus kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1206
Nov 12 21:55:47 stratus last message repeated 8 times

these "drain playback error" are generally harmless, I get it all
times that artsd 'gets' or 'releases' /dev/dsp (I configured it to
release /dev/dsp before 10s of inactivity).

'Assertion failed' is the culprit (or the simptom of it).

After that all tryes to use sound got no results.

"./via-audio-diag -aps" follows:
via-audio-diag.c:v1.00 05/06/2000 Jeff Garzik (jgarzik@mandrakesoft.com)
Index #1: Found a via 686a audio adapter at 0xdc00.
AC97 RESET = 0x6D50 (27984)
AC97 MASTER_VOL_STEREO = 0x0303 (771)
AC97 HEADPHONE_VOL = 0x0A0A (2570)
AC97 MASTER_VOL_MONO = 0x000A (10)
AC97 MASTER_TONE = 0x0000 (0)
AC97 PCBEEP_VOL = 0x0002 (2)
AC97 PHONE_VOL = 0x000A (10)
AC97 MIC_VOL = 0x8000 (32768)
AC97 LINEIN_VOL = 0x0A0A (2570)
AC97 CD_VOL = 0x0303 (771)
AC97 VIDEO_VOL = 0x0A0A (2570)
AC97 AUX_VOL = 0x0A0A (2570)
AC97 PCMOUT_VOL = 0x0B0B (2827)
AC97 RECORD_SELECT = 0x0000 (0)
AC97 RECORD_GAIN = 0x0A0A (2570)
AC97 RECORD_GAIN_MIC = 0x0000 (0)
AC97 GENERAL_PURPOSE = 0x0000 (0)
AC97 3D_CONTROL = 0x0000 (0)
AC97 MODEM_RATE = 0x0000 (0)
AC97 POWER_CONTROL = 0x000F (15)
AC97 EXTENDED_ID = 0x0201 (513)
AC97 EXTENDED_STATUS = 0x0001 (1)
AC97 PCM_FRONT_DAC_RATE = 0x2B11 (11025)
AC97 PCM_SURR_DAC_RATE = 0x0000 (0)
AC97 PCM_LFE_DAC_RATE = 0x0000 (0)
AC97 PCM_LR_ADC_RATE = 0xBB80 (48000)
AC97 PCM_MIC_ADC_RATE = 0x0000 (0)
AC97 CENTER_LFE_MASTER = 0x0000 (0)
AC97 SURROUND_MASTER = 0x0000 (0)
AC97 RESERVED_3A = 0x0000 (0)
SGD Playback            : 88 00 87 0533D0A8 00000000
SGD Record              : 00 00 00 00000000 00000000
SGD FM                  : 00 00 00 00000000 00000000
SGD Modem Playback      : 00 00 00 00000000 00000000
SGD Modem Record        : 00 00 00 00000000 00000000
SGD reg 0x80 = 0x00BA0000
SGD reg 0x84 = 0x00001000
SGD reg 0x88 = 0x00000000
SGD reg 0x8C = 0x00000000
PCI reg 0x10 = 0xD0000008
PCI reg 0x3C = 0x00
PCI reg 0x40 = 0x00
PCI reg 0x41 = 0x00
PCI reg 0x42 = 0x00
PCI reg 0x43 = 0x00
PCI reg 0x44 = 0x00
PCI reg 0x48 = 0x00

Sergio Bruder
--
http://pontobr.org, http://sergio.bruder.net, http://bruder.homeip.net:81
-----------------------------------------------------------------------------
pub  1024D/0C7D9F49 2000-05-26 Sergio Devojno Bruder <sergio@bruder.net>
     Key fingerprint = 983F DBDF FB53 FE55 87DF  71CA 6B01 5E44 0C7D 9F49
sub  1024g/138DF93D 2000-05-26
