Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTJGNDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJGNDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:03:15 -0400
Received: from mail44-s.fg.online.no ([148.122.161.44]:52909 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP id S262330AbTJGNDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:03:08 -0400
To: linux-kernel@vger.kernel.org
Subject: TerraTec DMX 6Fire LT won't work
From: Harald Arnesen <harald@skogtun.org>
Date: Tue, 07 Oct 2003 15:03:02 +0200
Message-ID: <87isn19p4p.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine with a TerraTec DMX 6fire LT, that I can't get to work.
Sound (alsa) compiled as modules, with debugging.

It's a new card, so I have never had it working. Tried with 2.6.0-test6
before 2.6.0-test6-bk8, same result.

# uname -a
Linux basilikum 2.6.0-test6-bk8 #1 Tue Oct 7 13:37:29 CEST 2003 i686 AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux

# modprobe snd-ice1712

# dmesg
...
ALSA sound/i2c/cs8427.c:98: unable to send register 0x7f byte to CS8427
ALSA sound/i2c/cs8427.c:221: unable to find CS8427 signature (expected 0x71, read 0xfffffffb), initialization is not completed
ALSA sound/pci/ice1712/ice1712.c:390: CS8427 initialization failed
ICE1712: probe of 0000:00:11.0 failed with error -14

# lsmod
Module                  Size  Used by
snd_ice1712            52836  0 
snd_ice17xx_ak4xxx      2944  1 snd_ice1712
snd_pcm                84516  1 snd_ice1712
snd_page_alloc          8900  1 snd_pcm
snd_timer              21444  1 snd_pcm
snd_cs8427              8384  1 snd_ice1712
snd_ac97_codec         45764  1 snd_ice1712
snd_i2c                 4352  2 snd_ice1712,snd_cs8427
snd_ak4xxx_adda         4928  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_mpu401_uart         5952  1 snd_ice1712
snd_rawmidi            20064  1 snd_mpu401_uart
snd_seq_device          6600  1 snd_rawmidi
snd                    49156  11 snd_ice1712,snd_ice17xx_ak4xxx,snd_pcm,snd_timer,snd_cs8427,snd_ac97_codec,snd_i2c,snd_ak4xxx_adda,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               6400  1 snd
sg                     26136  0 
floppy                 49428  0 
radeon                100652  0 
agpgart                23784  0 
sd_mod                  9696  0 
nfs                    80432  2 
nfsd                   81648  8 
exportfs                4736  1 nfsd
lockd                  52400  3 nfs,nfsd
sunrpc                105160  8 nfs,nfsd,lockd
hid                    27008  0 
ohci_hcd               14464  0 
parport_pc             28972  1 
lp                      8000  0 
parport                33064  2 parport_pc,lp
usbcore                84956  4 hid,ohci_hcd
rtc                     9656  0 
i2c_sis96x              4164  0 
i2c_core               18824  1 i2c_sis96x
st                     30872  0 
ide_cd                 32900  0 
sr_mod                 12516  0 
scsi_mod               56620  4 sg,sd_mod,st,sr_mod
cdrom                  29280  2 ide_cd,sr_mod

# amixer
amixer: Mixer attach default error: No such device

# lspci -s 00:11.0 -vxxx
00:11.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24] (rev 02)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1138
	Flags: bus master, medium devsel, latency 64, IRQ 12
	I/O ports at d000 [size=32]
	I/O ports at cc00 [size=16]
	I/O ports at c800 [size=16]
	I/O ports at c400 [size=64]
	Capabilities: [80] Power Management version 1
00: 12 14 12 17 05 01 10 02 02 00 01 04 00 40 00 00
10: 01 d0 00 00 01 cc 00 00 01 c8 00 00 01 c4 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3b 15 38 11
30: 00 00 00 00 80 00 00 00 00 00 00 00 0c 01 00 00
40: 7f 80 06 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 2f 80 f0 03 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

-- 
Hilsen Harald.
