Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265878AbUGNVnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUGNVnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbUGNVnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:43:14 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:42143 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S265878AbUGNVmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:42:19 -0400
Date: Wed, 14 Jul 2004 23:36:15 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: [2.6.8-rc1-mm1][CD-Burning]kernel BUG at mm/page_alloc.c:796
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Message-id: <200407142336.15998@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-15
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot burn cd's with 2.6.8-rc1-mm1.
System is Fujustu Siemens Celsius, detailed info below.
I hope it is not NVidias fault, but I don't think so.
I gonna check older kernels now.

root@ipt-cax-ws1: /root >cdrecord dev=/dev/hdc --checkdrive
results in:
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:796!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: nvidia thermal processor fan button battery ac
CPU:    0
EIP:    0060:[<c01421ef>]    Tainted: P   VLI
EFLAGS: 00010246   (2.6.8-rc1-mm1)
EIP is at __free_pages+0x3e/0x48
eax: ffffffff   ebx: c2197400   ecx: c16c94a0   edx: 00000000
esi: c2191600   edi: 00000001   ebp: c2191680   esp: f52ddd34
ds: 007b   es: 007b   ss: 0068
Process cdrecord (pid: 1968, threadinfo=f52dc000 task=f5f562b0)
Stack: c2197400 c2191600 c0164b78 c2191600 f64a5000 00000100 fffffff2 00000000
       00079963 c2191680 00000000 c0392dcb c2191680 f5223eac c0396b2c f5223eac
       c2191680 00000100 00000100 21000046 01000000 00000000 f64d7930 00000000
Call Trace:
 [<c0164b78>] bio_uncopy_user+0x84/0xa9
 [<c0392dcb>] blk_rq_unmap_user+0x37/0x4c
 [<c0396b2c>] sg_io+0x296/0x310
 [<c03971dc>] scsi_cmd_ioctl+0x363/0x487
 [<c0364e02>] pty_write+0x123/0x162
 [<c032c640>] copy_from_user+0x4a/0x76
 [<c0364e02>] pty_write+0x123/0x162
 [<c047c530>] cdrom_ioctl+0x45/0xe04
 [<c011d6d9>] default_wake_function+0x0/0x12
 [<c011d6d9>] default_wake_function+0x0/0x12
 [<c035dc23>] tty_write+0x29d/0x316
 [<c03f0f24>] idecd_ioctl+0x70/0x84
 [<c03f0eb4>] idecd_ioctl+0x0/0x84
 [<c0395158>] blkdev_ioctl+0xa5/0x478
 [<c01736e1>] sys_ioctl+0x22e/0x2c1
 [<c01061d7>] syscall_call+0x7/0xb
Code: 2a f0 83 41 04 ff 0f 98 c0 84 c0 74 1a 85 d2 75 0a 89 c8 83 c4 08 e9 6a 
f9 ff ff 89 54 24 04 89 0c 24 e8 6c f3 ff ff 83 c4 08 c3 <0f> 0b 1c 03 83 a9 
5f c0 eb cc 85 c0 74 1e 05 00 00 00 40 c1 e8

System info:
root@ipt-cax-ws1: /root >cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.053
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6062.08

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.053
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6127.61

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.053
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6127.61

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 3.06GHz
stepping        : 9
cpu MHz         : 3066.053
cache size      : 512 KB
physical id     : 3
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6127.61

root@ipt-cax-ws1: /root >lspci
00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
00:00.1 Class ff00: Intel Corp. E7000 Series RAS Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. E7000 Series Processor to AGP Controller (rev 
03)
00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI Bridge 
(rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller (rev 
02)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV35GL [Quadro FX 3000] 
(rev a1)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
03:05.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
03:05.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
05:03.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller 
(rev 02)


root@ipt-cax-ws1: /root >cdrecord -version
Cdrecord-Clone 2.01a18-dvd (i686-suse-linux) Copyright (C) 1995-2003 Jörg 
Schilling

root@ipt-cax-ws1: /root >dmesg | grep hdc
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:DMA, hdd:pio
hdc: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
hdc: ATAPI 32X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
hdc: CHECK for good STATUS


root@ipt-cax-ws1: /root >hdparm /dev/hdc
/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument


regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

