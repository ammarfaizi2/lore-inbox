Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUBEAYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUBEAPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:15:01 -0500
Received: from s6.fpw.ch ([62.12.146.226]:19726 "EHLO server6.fpw.ch")
	by vger.kernel.org with ESMTP id S264954AbUBEAN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:13:27 -0500
Subject: Firewire troubles with  SMP kernel
From: Alexey Goldin <ab_goldin@swissmail.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1075940005.11793.34.camel@hobbit>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 16:13:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to fine people who helped me to sort out problems with my laptop
couple of months ago. This is the timeto ask for help again :-)

Please cc: any reply to me as I am not subscribed to the list. 

Well, I know firewire with SMP is a little bit iffy. 
However we managed to get it working on one computer and we hoped it
will work with other. Here is what we have instead.

The first computer is dual Athlon-MP with Tyan mobo, firewire card is 
fairly basic, we got it from
http://shop.store.yahoo.com/gooddealpc-store/139pci3p.html 
We tried it with Western Digital 120GB firewire drives and with IDE
enclosures:

http://www.baber.com/cases/drive_enclosures/multi_bay.htm


We had crashes, but after we upgraded to Fedora, kernel 
2.4.22-1.2115.nptlsmp it worked like a charm.

However we needed these drives to work at another machine. It is not at
our site, so I still trying to figure out all hardware details. Whatever
available is shown below. We shipped identical Firewire card to the
second computer. It is running SuSe. After upgrading to 2.4.22 it could
see the firewire card and hard drive, but it reports that hard drive has
0 sectors. Which is probably on a low side, as we can read data from
this drive just fine  on other computers.

We tried other (newer) kernel versions up to 2.4.24, tried to apply all
Fedora patches to vanilla 2.4.22 --- no luck. The hard drive is still 0
sectors big.

Could anyone kindly suggest me where to dig?

Thank you very much!


Here is relevant part of /var/log/messages:

Feb  4 12:59:38 kilauea kernel: sbp2: $Rev: 1010 $ Ben Collins
<bcollins@debian\.org>
Feb  4 12:59:38 kilauea kernel: scsi2 : SCSI emulation for IEEE-1394
SBP-2 Devi\ces
Feb  4 12:59:38 kilauea kernel: blk: queue f426ba18, I/O limit 4095Mb
(mask 0xf\fffffff)
Feb  4 12:59:39 kilauea kernel: ieee1394: sbp2: Logged into SBP-2 device
Feb  4 12:59:39 kilauea kernel: ieee1394: sbp2: Node 0-00:1023: Max
speed [S400\] - Max payload [2048]
Feb  4 12:59:39 kilauea insmod: Using
/lib/modules/2.4.22-ac1/kernel/drivers/ie\ee1394/sbp2.o

.........................................................

Feb  4 12:59:39 kilauea kernel: scsi singledevice 2 0 0 0
Feb  4 12:59:39 kilauea kernel: blk: queue f5962218, I/O limit 4095Mb
(mask 0xf\fffffff)
Feb  4 12:59:39 kilauea kernel:   Vendor: WDIGTL    Model:
WDCFireWireHD-Ox  Re\v: 2.70
Feb  4 12:59:39 kilauea kernel:   Type:  
Direct-Access                      AN\SI SCSI revision: 06
Feb  4 12:59:39 kilauea kernel: blk: queue f6647818, I/O limit 4095Mb
(mask 0xf\fffffff)
Feb  4 12:59:39 kilauea kernel: Attached scsi disk sdd at scsi2, channel
0, id \0, lun 0
Feb  4 12:59:39 kilauea kernel: sr0: CDROM (ioctl) reports ILLEGAL
REQUEST.
Feb  4 12:59:54 kilauea last message repeated 15 times
Feb  4 12:59:55 kilauea kernel: SCSI device sdd: 0 512-byte hdwr sectors
(0 MB)
                                                 ^^ This is the problem

Feb  4 12:59:55 kilauea kernel: scsi singledevice 2 0 1 0
Feb  4 12:59:55 kilauea kernel: blk: queue f426b818, I/O limit 4095Mb
(mask 0xf\fffffff)
Feb  4 12:59:55 kilauea kernel: scsi singledevice 2 0 2 0
Feb  4 12:59:55 kilauea kernel: blk: queue f6647818, I/O limit 4095Mb
(mask 0xf\fffffff)











 cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.66GHz
stepping        : 7
cpu MHz         : 2665.927
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5321.52
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.66GHz
stepping        : 7
cpu MHz         : 2665.927
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5321.52
 
processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.66GHz
stepping        : 7
cpu MHz         : 2665.927
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5321.52
 
processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.66GHz
stepping        : 7
cpu MHz         : 2665.927
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
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5321.52

 # lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2550 (rev 03)
00:00.1 Class ff00: Intel Corp.: Unknown device 2551 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2552 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device
5961 (rev 01)
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5941
(rev 01)
02:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 10)
02:06.0 Communication controller: NetMos Technology VScom 021H-EP2 2
port parallel adaptor (rev 01)
02:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 46)
02:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)
02:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 0a)
02:09.0 RAID bus controller: LSI Logic / Symbios Logic PowerEdge
Expandable RAID Controller 4 (rev 01)





-- 
Alexey Goldin <ab_goldin@swissmail.org>

