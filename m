Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUH0X1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUH0X1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUH0X1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:27:32 -0400
Received: from pop.gmx.de ([213.165.64.20]:52128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267164AbUH0XUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:20:37 -0400
X-Authenticated: #20559227
Subject: AGP_UNINORTH missing in 2.4.27 for PPC?
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093648829.1643.54.camel@debby>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 01:20:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I sent the message below to the debian ppc list, and didn't get an
answer so far.

Problem: I can't compile a 2.4.27 kernel anymore on a Powerbook G4. The
whole issue is described in the forwarded message at the end of this
message.

First some information about the the system/machine I wanted to build
the kernel on.

The compiler in all builds were either gcc-2.95 or gcc-3.3, if I recall
correctly ...

--------------------
$ cat /proc/version 
Linux version 2.4.25-ben1 (root@debby) (gcc version 2.95.4 20011002 
(Debian prerelease)) #1 Sun Apr 25 15:55:09 CEST 2004
------------------------


--------------------------
$ cat /proc/cpuinfo  
processor       : 0
cpu             : 7455, altivec supported
clock           : 867MHz
revision        : 3.2 (pvr 8001 0302)
bogomips        : 864.64
machine         : PowerBook3,5
motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
board revision  : 00000000
detected as     : 80 (PowerBook Titanium IV)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 768MB
pmac-generation : NewWorld
---------------------------------

---------------------------------------
$ cat /proc/modules
radeon                129536   1
agpgart                18832   3
rfcomm                 25440   0 (autoclean)
l2cap                  18944   2 (autoclean) [rfcomm]
bluez                  37960   1 (autoclean) [rfcomm l2cap]
sd_mod                 13084   0 (autoclean) (unused)
ds                      8656   1
snd-powermac           42996   2 (autoclean)
snd-pcm-oss            58408   0 (autoclean)
snd-mixer-oss          17456   1 (autoclean) [snd-pcm-oss]
snd-pcm                85344   0 (autoclean) [snd-powermac snd-pcm-oss]
snd-timer              20368   0 (autoclean) [snd-pcm]
snd-page-alloc          7832   0 (autoclean) [snd-pcm]
snd                    49088   1 (autoclean) [snd-powermac snd-pcm-oss
snd-m
-oss snd-pcm snd-timer]
soundcore               4584   3 (autoclean) [snd]
yenta_socket           12688   1
pcmcia_core            44976   0 [ds yenta_socket]
sg                     30804   0 (unused)
ide-scsi               11232   0
scsi_mod               91392   3 [sd_mod sg ide-scsi]
airport                 3556   0 (unused)
orinoco                36896   0 [airport]
hermes                  9712   0 [airport orinoco]
hid                    23300   0 (unused
----------------------------

---------------------------
# lspci -vvv
0000:00:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 AGP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x08 (32 bytes)
	Capabilities: [80] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

0000:00:10.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at b8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 802400 [size=256]
	Region 2: Memory at b0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at b0020000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=8 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x08 (32 bytes)

0000:10:17.0 ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

0000:10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at a0002000 (32-bit, non-prefetchable) [size=4K]

0000:10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at a0001000 (32-bit, non-prefetchable) [size=4K]

0000:10:1a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at a0000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=10, secondary=11, subordinate=14, sec-latency=176
	Memory window 0: 90000000-9ffff000 (prefetchable)
	Memory window 1: f3000000-f31ff000
	I/O window 0: 00001000-00008fff
	I/O window 1: 00009000-000090ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:24:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 Internal PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size: 0x08 (32 bytes)

0000:24:0e.0 ffff: Lucent Microelectronics FW323 (rev ff) (prog-if ff)
	!!! Unknown header type 7f

0000:24:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 6 (16000ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
	Expansion ROM at f5100000 [disabled] [size=1M]



---------------------------

-----Forwarded Message-----
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Debian PPC <debian-powerpc@lists.debian.org>
Subject: "make oldconfig" changing silently old kernel config options?
Date: Fri, 20 Aug 2004 21:15:22 +0200

Hi All

What's this:

For a new 2.4.27 kernel I copied my old 2.4.25-ben1 config to
<kernel-source-dir>/.config, did a 'make oldconfig' which resulted in a
new config file where options I chose in the old 2.4.25-ben1 are missing
in the new 2.4.27 .config file. For example in  2.4.25-ben1 I have
 
CONFIG_AGP_UNINORTH=y

which is missing in the new 2.4.27 .config

And I got a compile error for agpgart_be.c, which I don't very
surprising after this messed up .config:

---------------------------------------------------------------
agpgart_be.c:96:2: #error "Please define flush_cache."
agpgart_be.c:402: warning: `agp_generic_agp_enable' defined but not used
agpgart_be.c:495: warning: `agp_generic_create_gatt_table' defined but not used
agpgart_be.c:619: warning: `agp_generic_suspend' defined but not used
agpgart_be.c:624: warning: `agp_generic_resume' defined but not used
agpgart_be.c:629: warning: `agp_generic_free_gatt_table' defined but not used
agpgart_be.c:681: warning: `agp_generic_insert_memory' defined but not used
agpgart_be.c:743: warning: `agp_generic_remove_memory' defined but not used
agpgart_be.c:760: warning: `agp_generic_alloc_by_type' defined but not used
agpgart_be.c:765: warning: `agp_generic_free_by_type' defined but not used
agpgart_be.c:783: warning: `agp_generic_alloc_page' defined but not used
agpgart_be.c:803: warning: `agp_generic_destroy_page' defined but not used
make[4]: *** [agpgart_be.o] Error 1
make[4]: Leaving directory `/home/shorty/sources/2.4.27/linux-2.4.27/drivers/char/agp'
make[3]: *** [_modsubdir_agp] Error 2
make[3]: Leaving directory `/home/shorty/sources/2.4.27/linux-2.4.27/drivers/char'
make[2]: *** [_modsubdir_char] Error 2
make[2]: Leaving directory `/home/shorty/sources/2.4.27/linux-2.4.27/drivers'
make[1]: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/home/shorty/sources/2.4.27/linux-2.4.27'
make: *** [stamp-build] Error 2
----------------------------------------------------------------


A diff between the 2 kernel config versions (sorry the following
grepping might not be very elegant):

-----------------------------------
$ cat kernel.config.diff |grep -v ^' #' | grep -v ^'-#' | grep -v ^'+#' |  grep -v ^' ' | grep -v ^@
--- /boot/config-2.4.25-ben1    2004-04-25 15:53:20.000000000 +0200
+++ /home/shorty/sources/2.4.27/linux-2.4.27/.config    2004-08-20 18:46:44.000000000 +0200
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_26_API=y
-CONFIG_CPU_FREQ_PMAC=y
-CONFIG_IPV6_SCTP__=y
-CONFIG_PMU_HD_BLINK=y
-CONFIG_AGP_UNINORTH=y
+CONFIG_I2C=m
+CONFIG_I2C_KEYWEST=m
+CONFIG_CRYPTO_TEA=m
+CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_MICHAEL_MIC=m
-----------------------------------------

Another example: in 2.4.25 I have
CONFIG_I2C=y
CONFIG_I2C_KEYWEST=y

now in 2.4.27 these previously built-in drivers have suddenly become
modules ....

What's going on with 'make oldconfig', i.e. why did it mess up the old
options from 2.4.25-ben1? My mistake?

TIA

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer                           gpg ID: 0AA7E825 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


