Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312798AbSDBQUt>; Tue, 2 Apr 2002 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312841AbSDBQUj>; Tue, 2 Apr 2002 11:20:39 -0500
Received: from dialup099.albatross.co.nz ([203.97.5.99]:260 "EHLO
	loki.albatross.co.nz") by vger.kernel.org with ESMTP
	id <S312798AbSDBQUd>; Tue, 2 Apr 2002 11:20:33 -0500
Date: Wed, 3 Apr 2002 04:28:32 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: linux-kernel@vger.kernel.org
Subject: spurious "No medium found" messages with ide-scsi on 2.4.19-pre[45]
Message-ID: <Pine.LNX.4.44.0203301818190.10745-100000@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason with my cd-rw, I'm getting spurious "CDROMPLAYMSF: No
medium found" messages when trying to play cds while using ide-scsi
emulation. With the ide-cd module used instead, it works fine. I haven't
tested this with any kernel versions other than 2.4.19-pre[45] (I only
recently got the cd-rw).


I got the following output when playing around with workbone:
play(150,127199)        stopped #1
msf = 0:2:0 28:15:74
CDROMPLAYMSF: No medium found
play(150,127199)        stopped #1
msf = 0:2:0 28:15:74
CDROMPLAYMSF: No medium found
play(150,127199)        stopped #1
msf = 0:2:0 28:15:74
CDROMPLAYMSF: No medium found
                        playing #1   00:03  00:05


The cd-rw is reported on module loading as follows:

hdd: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
  Vendor: SAMSUNG   Model: CD-R/RW SW-224B   Rev: R203
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray



I'm using the following patches:
2.4.18-rc1-low-latency.patch.gz
preempt-kernel-rml-2.4.19-pre4-1.patch
various bttv from http://bytesex.org/patches/

And the following 3rd party modules:
alsa 0.9.0beta12
i2c 2.6.3
lm_sensors 2.6.3

My devel tools are:
binutils 2.11.92.0.12.3
gcc V2.95.3
make 3.79.1

The following modules are loaded:
sr_mod                 12460   2  (autoclean)
cdrom                  27200   0  (autoclean) [sr_mod]
ide-scsi                7748   1  (autoclean)
scsi_mod               91148   2  (autoclean) [sr_mod ide-scsi]
eeprom                  4644   0  (unused)
w83781d                20780   0  (unused)
i2c-proc                6444   0  [eeprom w83781d]
i2c-isa                 1408   0  (unused)
i2c-piix4               4432   0  (unused)
i2c-core               14184   0  [eeprom w83781d i2c-proc i2c-isa
i2c-piix4]
snd-opl3-synth          9664   0  (unused)
snd-seq-instr           5188   0  [snd-opl3-synth]
snd-seq-midi-emul       4808   0  [snd-opl3-synth]
snd-seq                38768   0  [snd-opl3-synth snd-seq-instr
snd-seq-midi-emul]
snd-ainstr-fm           1720   0  [snd-opl3-synth]
snd-cs4236              8760   1
snd-cs4236-lib         11172   0  [snd-cs4236]
snd-cs4231-lib         14884   0  [snd-cs4236 snd-cs4236-lib]
snd-pcm                50904   0  [snd-cs4236-lib snd-cs4231-lib]
snd-opl3-lib            5872   0  [snd-opl3-synth snd-cs4236]
snd-timer              10284   0  [snd-seq snd-cs4231-lib snd-pcm
snd-opl3-lib]
snd-hwdep               3852   0  [snd-opl3-lib]
snd-mpu401-uart         3228   0  [snd-cs4236]
snd-rawmidi            13048   0  [snd-mpu401-uart]
snd-seq-device          4296   0  [snd-opl3-synth snd-seq snd-opl3-lib
snd-rawmidi]
snd                    27956   4  [snd-opl3-synth snd-seq-instr snd-seq
snd-cs4236 snd-cs4236-lib snd-cs4231-lib snd-pcm snd-opl3-lib snd-timer
snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               4132   3  [snd]
slip                    9768   0  (unused)
parport                24608   0  (unused)


Just in case it's important, my motherboard is an abit bx6r2, which uses
the intel 440BX chipset. The ide chipset is listed in lspci as the
82371AB PIIX4 IDE.

-- 
Madness takes its toll.  Please have exact change ready.
http://users.albatross.co.nz/~psycho/     O-      -><-





