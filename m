Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292571AbSBPWHm>; Sat, 16 Feb 2002 17:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292570AbSBPWHd>; Sat, 16 Feb 2002 17:07:33 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:28681 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S292569AbSBPWHT>; Sat, 16 Feb 2002 17:07:19 -0500
Message-ID: <3C6ED744.9010504@megapathdsl.net>
Date: Sat, 16 Feb 2002 14:03:48 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
        Abramo Bagnara <abramo@alsa-project.org>
Subject: How do I get the ALSA code in 2.5.5-pre1 working?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the linux hotplug scripts installed.  When I built
the drivers as modules, they did not autoload, as they should
have.  Are you working to make the drivers register themselves
during the boot process so that they are autoloaded without
having to hack the modules.conf file?

I have applied the patch the gets /proc/asound working.
In my most recent attempt, I have compiled the ALSA drivers
into the kernel.  I would like to use the native ALSA drivers,
but am not sure how to configure my devices to make this
happen.  I use esound on GNOME and play CDs.

One question I have is how to go about getting the ALSA
utilities and tools to build.  They require alsa-lib, which
appears to require alsa-drivers.  This is a problem, because
I don't want to install the out-of-kernel ALSA drivers in
addition to the in-kernel ones.

It seems to me that there is a need for several things to happen,
now that ALSA is in the development kernel:

1)  You need to update your web documentation to guide users
in configuring ALSA who are testing the ALSA support in
the development kernel.

2)  You need to include updated ALSA configuration and usage
information into the linux/Documentation tree in the 2.5 kernel
tree.

3)  You need to update documentation in the utils and tools
packages to include information about how to build and use
there utilies when using the 2.5 kernel drivers.

4)  You may need to overhaul your tools and utilities build
processes so that alsa-drivers is not required.

Here are my options:

CONFIG_SND=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_FULL=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_EMU10K1=y

In my kernel log, I see no sign that my EMU10K1 card is detected.

Here is what an OSS driver in an earlier kernel logged when it
detected my card:

Feb 11 10:48:44 turbulence kernel: Creative EMU10K1 PCI Audio Driver, 
version 0.7, 17:00:23 Sep  6 2001
Feb 11 10:48:44 turbulence kernel: emu10k1: EMU10K1 rev 7 model 0x8031 
found, IO at 0xff80-0xff9f, IRQ 5

-----------------------------

cat /proc/asound/devices:

  1:       : sequencer
  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 33:       : timer

-----------------------------

 cat oss-devices:
  1:       : sequencer
  8:       : sequencer
  2: [0- 2]: raw midi
 12: [0-12]: digital audio
  3: [0- 3]: digital audio
  0: [0- 0]: mixer
 13: [0-13]: raw midi

-----------------------------

cat pcm:    
00-00: emu10k1 : EMU10K1 : playback 32 : capture 1
00-01: emu10k1 mic : EMU10K1 MIC : capture 1
00-02: emu10k1 efx : EMU10K1 EFX : capture 1
00-03: emu10k1 : EMU10K1 FX8010 : playback 8

cat cards:
0 [card0          ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! at 0xff80, irq 5

-----------------------------

cat sndstat:
Sound Driver:3.8.1a-980706 (ALSA v0.9.0beta10 emulation code)
Kernel: Linux turbulence.megapathdsl.net 2.5.5-pre1 #5 Sat Feb 16 
01:22:40 PST 2
002 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Sound Blaster Live! at 0xff80, irq 5

Audio devices:
0: EMU10K1 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices:
0: EMU10K1 MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: mixer00



