Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279830AbRJ3C4D>; Mon, 29 Oct 2001 21:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279829AbRJ3Czy>; Mon, 29 Oct 2001 21:55:54 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:57484 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S279815AbRJ3Czk>; Mon, 29 Oct 2001 21:55:40 -0500
Date: Mon, 29 Oct 2001 18:55:45 -0800
To: viro@math.psu.edu
Cc: RossBoylan@stanfordalumni.org, linux-kernel@vger.kernel.org
Subject: 2.4.12 kernel doesn't see extended partition
Message-ID: <20011029185545.C1212@wheat.boylan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Ross Boylan <RossBoylan@stanfordalumni.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to start my Debian woody system using a recently compiled
(with kernel-package) 2.4.12 kernel it fails to start because it can't find
the root partition, /hda6.  The immediately preceding partition check
for hda does NOT show any individual extended partitions, but it it
does show hda1 - 4.  Here's what things look like with 2.4.10:
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdb: hdb1 < hdb5 hdb6 hdb7 > hdb2

Under 2.4.12 it looks like
 hda: hda1 hda2 hda3 hda4 < >
 hdb: hdb1 < hdb5 hdb6 hdb7 > hdb2


I noticed you have been working on the partition code, and that there
have been some reports of similar problems.  However, my search did
not show if those problems had been resolved.

I have been having intermittent hardware problems with the disks.  But
the extended partition does not seem to be damaged, judging from the
fact that I can use it from 2.4.10 kernels.

Because of those problems I did fiddle with some of the options before
compiling the kernel, but have since turned most of them back.  Here's
one diff of config-2.4.10 vs 2.4.12:
62a63
> # CONFIG_X86_UP_APIC is not set
92c93
< # CONFIG_PM is not set
---
> CONFIG_PM=y
362d362
< # CONFIG_SCSI_NCR_D700 is not set
641a642
> # CONFIG_JFFS2_FS is not set
782,810c783
< CONFIG_SOUND_OSS=m
< CONFIG_SOUND_TRACEINIT=y
< CONFIG_SOUND_DMAP=y
< # CONFIG_SOUND_SGALAXY is not set
< # CONFIG_SOUND_ADLIB is not set
< # CONFIG_SOUND_ACI_MIXER is not set
< # CONFIG_SOUND_CS4232 is not set
< # CONFIG_SOUND_SSCAPE is not set
< # CONFIG_SOUND_GUS is not set
< CONFIG_SOUND_VMIDI=m
< # CONFIG_SOUND_TRIX is not set
< # CONFIG_SOUND_MSS is not set
< # CONFIG_SOUND_MPU401 is not set
< # CONFIG_SOUND_NM256 is not set
< # CONFIG_SOUND_MAD16 is not set
< # CONFIG_SOUND_PAS is not set
< # CONFIG_PAS_JOYSTICK is not set
< # CONFIG_SOUND_PSS is not set
< # CONFIG_SOUND_SB is not set
< # CONFIG_SOUND_AWE32_SYNTH is not set
< # CONFIG_SOUND_WAVEFRONT is not set
< # CONFIG_SOUND_MAUI is not set
< # CONFIG_SOUND_YM3812 is not set
< # CONFIG_SOUND_OPL3SA1 is not set
< # CONFIG_SOUND_OPL3SA2 is not set
< # CONFIG_SOUND_YMFPCI is not set
< # CONFIG_SOUND_YMFPCI_LEGACY is not set
< # CONFIG_SOUND_UART6850 is not set
< # CONFIG_SOUND_AEDSP16 is not set
---
> # CONFIG_SOUND_OSS is not set
859a833
> # CONFIG_USB_HPUSBSCSI is not set

As for config_pm, my hardware is ACPI and some of my problems seem
related to power management (can't access the disks after they've been
sleeping).  I've tried it on and off.  In fact, I've tried at least 6
different configurations.

(By the way, on the sound I'm using ALSA.  Does anyone know if I
should turn OSS on if I want OSS emulation?).

Gigabyte GA-71XE4 with Athlon 800 Mhz processor.  The chipset is AMD
(I have Viper support selected as an option).  I also have i2c and
lm-sensors.  The drive in question is Western Digital UDMA-33, 13Mg;
the second one is Western Digitial UDMA 66.

Hmm, here's what happened when I tried to run fdisk
wheat:/usr/local/rootlog# fdisk /dev/hda

Unable to read /dev/hda
