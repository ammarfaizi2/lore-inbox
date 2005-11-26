Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbVKZPoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbVKZPoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 10:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbVKZPoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 10:44:11 -0500
Received: from bernhard.xss.co.at ([193.80.108.69]:60393 "EHLO
	bernhard.xss.co.at") by vger.kernel.org with ESMTP id S1422649AbVKZPoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 10:44:09 -0500
Message-ID: <438882C6.20402@xss.co.at>
Date: Sat, 26 Nov 2005 16:44:06 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT
 = 0
References: <43838ECC.5060204@xss.co.at> <20051124053952.GI11266@alpha.home.local> <4385BA96.1080804@xss.co.at> <20051124232210.GB23855@alpha.home.local>
In-Reply-To: <20051124232210.GB23855@alpha.home.local>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Yesterday the new LSI Logic hostadapters arrived. I replaced the
Adaptec 29320 controllers with the new LSI boards and did various
tests.

Executive summary: with the LSI controllers everything works fine!

Willy Tarreau schrieb:
> Hi Andreas,
> 
> On Thu, Nov 24, 2005 at 02:05:26PM +0100, Andreas Haumer wrote:
> 
> 
>>>>I've never tried an adaptec U320 yet, only a few 29160 in various servers.
>>>
>>I have tried the external RAID with the following controllers now:
>>
>>Adaptec 29160 - works fine (with the aic7xxx driver)
>>Adaptec 29320ALP - does not work (tried with two different cards)
>>Adaptec 29320A - does not work
> 
> 
> OK so the problem is only related to 29320 + aic79xx driver.
> 
It indeed looks that way.

I just replaced the Adaptec 29320ALP controller with a LSI-22320
board and all my problems are gone. No SCSI errors, no timeouts.

Here's some information about my current setup:

[lspci]
00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
01:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
01:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
02:06.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
02:06.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
03:05.0 Mass storage controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
03:08.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 10)

[lsmod]
Module                  Size  Used by    Not tainted
nfsd                   67824  16  (autoclean)
nfs                    74072   1  (autoclean)
lockd                  45616   1  (autoclean) [nfsd nfs]
sunrpc                 71072   1  (autoclean) [nfsd nfs lockd]
tg3                    59308   1  (autoclean)
w83627hf               13144   0  (unused)
eeprom                  3500   0  (unused)
lm85                   17064   0  (unused)
i2c-isa                  808   0  (unused)
i2c-amd756              3082   0  (unused)
i2c-proc                6052   0  [w83627hf eeprom lm85]
i2c-core               15364   0  [w83627hf eeprom lm85 i2c-isa i2c-amd756 i2c-proc]
processor               8528   0  (unused)
button                  2572   0  (unused)
keybdev                 1796   0  (unused)
mousedev                3960   0  (unused)
hid                    20356   0  (unused)
input                   3584   0  [keybdev mousedev hid]
usb-ohci               19048   0  (unused)
usbcore                60940   0  [hid usb-ohci]
xfs                   481764   6  (autoclean)
ext2                   35424   1  (autoclean)
unix                   16080  14  (autoclean)
reiserfs              175312   6  (autoclean)
lvm-mod                59544  34  (autoclean)
raid1                  14360   2  (autoclean)
md                     57856   4  (autoclean) [raid1]
sd_mod                 11144  12  (autoclean)
mptscsih               34640   2  (autoclean)
mptbase                31968   3  (autoclean) [mptscsih]
aic79xx               164220   4  (autoclean)
scsi_mod               94932   3  (autoclean) [sd_mod mptscsih aic79xx]

The aic79xx now drives the internal Maxtor SCSI disks, the
mptscsih driver is used for the external RAID subsystem.


[cat /proc/scsi/scsi]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K5_73SCA  Rev: JNZH
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: MAXTOR   Model: ATLAS10K5_73SCA  Rev: JNZH
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: IFT      Model: A16U-G2421       Rev: 342A
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 01
  Vendor: IFT      Model: A16U-G2421       Rev: 342A
  Type:   Direct-Access                    ANSI SCSI revision: 03


[dmesg]
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

blk: queue f7ae9a18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
(scsi1:A:5): 320.000MB/s transfers (160.000MHz DT|IU|RTI|QAS, 16bit)
  Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ae9818, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
  Vendor: MAXTOR    Model: ATLAS10K5_73SCA   Rev: JNZH
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ae9618, I/O limit 4095Mb (mask 0xffffffff)
scsi1:A:5:0: Tagged Queuing enabled.  Depth 32
Fusion MPT base driver 2.05.16
Copyright (c) 1999-2004 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.05.16
scsi2 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=28
scsi3 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=29
  Vendor: IFT       Model: A16U-G2421        Rev: 342A
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ae9018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
  Vendor: IFT       Model: A16U-G2421        Rev: 342A
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f723de18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 5, lun 0
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 0, lun 1
SCSI device sda: 143666192 512-byte hdwr sectors (73557 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
SCSI device sdb: 143666192 512-byte hdwr sectors (73557 MB)
 /dev/scsi/host1/bus0/target5/lun0: p1 p2
SCSI device sdc: 4096000000 512-byte hdwr sectors (2097152 MB)
 /dev/scsi/host2/bus0/target0/lun0: p1
SCSI device sdd: 2734071808 512-byte hdwr sectors (1399845 MB)
 /dev/scsi/host2/bus0/target0/lun1: p1


[performance test]
root@setup:~ {504} $ time dd if=/dev/zero of=/platten/gisdat/bigfile bs=1M count=20000
20000+0 records in
20000+0 records out

real    1m27.764s
user    0m0.080s
sys     0m32.500s
root@setup:~ {505} $ umount /platten/gisdat/
root@setup:~ {506} $ mount /platten/gisdat/
root@setup:~ {507} $ time dd if=/platten/gisdat/bigfile of=/dev/null bs=1M
20000+0 records in
20000+0 records out

real    2m29.681s
user    0m0.030s
sys     0m31.510s

This simple performance test gives a rough estimation of
write throughput at 229MB/s and read throughput at 134MB/s

This is not bad IMHO

(Note: I did the umount/mount in order to clear the OS cache
before executing the read throughput test)

[...]
>>
>>A patch was posted by James Bottomley on October 3rd, 2004
>>(See http://marc.theaimsgroup.com/?l=linux-scsi&m=112837144508743&w=2)
> 
> 
> Interesting, I've archived it. James presented it as a workaround,
> waiting for something cleaner, but I've not seen any followup (may
> be I've not searched well).
> 
I haven't found anything, either.

[...]
>>I also have good experience with LSI Logic cards (Fusion MPT driver).
>>Yesterday I ordered several of them, I hope I'll get them soon so I
>>can do further tests.
> 
> 
> OK, it will definitely rule out bad cables and RAID array.
> 
Yes, and indeed it does as everything works fine now with just the
Adaptec controller replaced with the LSI controller. So the problem
is with almost absolute certainty the Adaptec driver (I don't believe
that three out of three new Adaptec controller boards show the same
hardware defect)

[...]
> 
> 
> Often (in my experience), when different versions of a driver find different
> error conditions, it is caused by timing problems. Perhaps the driver has to
> respect some pauses on the bus that are not quite correctly respected. Have
> you tried to lower the speed to 160 MB/s ?
> 
No, I haven't.

But I tried to reduce the TCQ queue depth from 32 (default) to 8
but this did not solve the problem (this was a suggestion by
ari@www.goron.de. Thanks for your mail, Ari, but your mail address
bounces so I couldn't send you a reply!)


I will have this particular hardware setup available for
testing for about two or three days (until end of next Tuesday).
If anyone wants me to try any patches for the aic79xx driver in
this timeframe I'm willing to do so if time permits.
But the system will go into production by the end of next
week and after that there is no way for me to do any further
tests with this hardware.

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDiILCxJmyeGcXPhERAnJ6AJ9368FfWJanLvzU9Wv3Ts8L5BG2NACghI9O
XYkHANb/iSHAM6Bx6+Oz5Jw=
=B0RM
-----END PGP SIGNATURE-----
