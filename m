Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317883AbSGPQas>; Tue, 16 Jul 2002 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317884AbSGPQar>; Tue, 16 Jul 2002 12:30:47 -0400
Received: from stargate.bse.bg ([212.91.180.1]:55561 "EHLO stargate.bse.bg")
	by vger.kernel.org with ESMTP id <S317883AbSGPQap> convert rfc822-to-8bit;
	Tue, 16 Jul 2002 12:30:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Petrov <jhs@bse.bg>
Reply-To: jhs@bse.bg
To: linux-kernel@vger.kernel.org
Subject: A problem with i815 (AC97) integrated audio
Date: Tue, 16 Jul 2002 19:34:29 +0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207161934.29819.jhs@bse.bg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slackware 8.1.01, kernel 2.4.18
Mainboard chipset: i815

root@darkstar:~# modprobe i810_audio

root@darkstar:~# dmesg
Intel 810 + AC97 Audio, version 0.21, 12:30:28 Jul 12 2002
PCI: Found IRQ 7 for device 00:1f.5
PCI: Sharing IRQ 7 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH2 found at IO 0xdc00 and 0xd800, IRQ 7
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x414c:0x4326 (Unknown)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
i810_audio: setting clocking to 16053
i810_audio: ftsodell is now a deprecated option.

root@darkstar:~# lsmod
Module                  Size  Used by    Not tainted
i810_audio             20424   0  (unused)
ac97_codec              9480   0  [i810_audio]
soundcore               3268   2  [i810_audio]

  root@darkstar:~# mpg123 test.MP3
  High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
  Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
  Uses code from various people. See 'README' for more!
  THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

  Playing MPEG stream from Aretha_Franklin_-_A_Deeper_Love.MP3 ...
  MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo
  libao - OSS cannot set rate to 44100
  <here is no sound and I press ctrl+C>
  [0:02] Decoding of test.MP3 finished.
  Segmentation fault

root@darkstar:~# esd
unsupported playback rate: 44100
Audio device open for 44.1Khz, stereo, 16bit failed
Trying 44.1Khz, 8bit stereo.
unsupported sound format: 32
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.
unsupported playback rate: 48000
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 22.05Khz, 8bit stereo.
unsupported sound format: 32
Audio device open for 22.05Khz, stereo, 8bit failed
Trying 44.1Khz, 16bit mono.
unsupported playback rate: 44100
Audio device open for 44.1Khz, mono, 8bit failed
Trying 22.05Khz, 8bit mono.
unsupported sound format: 0
Audio device open for 22.05Khz, mono, 8bit failed
Trying 11.025Khz, 8bit stereo.
unsupported sound format: 32
Audio device open for 11.025Khz, stereo, 8bit failed
Trying 11.025Khz, 8bit mono.
unsupported sound format: 0
Audio device open for 11.025Khz, mono, 8bit failed
Trying 8.192Khz, 8bit mono.
unsupported sound format: 0
Audio device open for 8.192Khz, mono, 8bit failed
Trying 8Khz, 8bit mono.
unsupported sound format: 0
Sound device inadequate for Esound. Fatal.

But it works with this:

root@darkstar:~# esd -r xxxxx   (where xxxxx in [15289..16897])
and the esd starting sound is VERY thin and short (maybe triple than the 
normal)

  The next foul: KDE ArtsD
  root@darkstar:~# artsd
  Error while initializing the sound driver:
  can't set requested samplingrate (requested rate 44100, got rate 16053)

  which works with artsd -r xxxxx (where xxxxx in [13685..18947])
  And then output is:
  root@darkstar:~# artsd -l 0 -r 16053
  gsl: using Unix98 pthreads directly for mutexes and conditions
  autodetecting driver:
   - toss: 4
   - null: -1
   - oss: 10
  ... which means we'll default to oss
  device capabilities: revision0 realtime trigger mmap
  buffering: 8 fragments with 1024 bytes (audio latency is 127.6 ms)
  device capabilities: revision0 realtime trigger mmap
  buffering: 8 fragments with 1024 bytes (audio latency is 127.6 ms)
  audio format is 16053 Hz, 16 bits, 2 channels
  addDirectory(/opt/kde/lib/mcop,)
  addDirectory(/opt/kde/lib/mcop/Arts,Arts)
  addDirectory(/opt/kde/lib/mcop/Arts/Environment,Arts::Environment)
  addDirectory(/opt/kde/lib/mcop/Noatun,Noatun)
  addDirectory(/root/.mcop/trader-cache,)
  Arts::MidiManager registered successfully.
  
after this, all I play sounds like a scream
where the problem could be?

