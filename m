Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUDTH0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUDTH0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUDTH0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:26:17 -0400
Received: from ms-smtp-01-qfe0.socal.rr.com ([66.75.162.133]:6869 "EHLO
	ms-smtp-01-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S262274AbUDTHZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:25:50 -0400
Message-ID: <4084D07A.1080402@hawaii.edu>
Date: Mon, 19 Apr 2004 21:25:46 -1000
From: Eric Firing <efiring@hawaii.edu>
Organization: University of Hawaii
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: no USB functionality with 2.6 kernels on Dell Dimension
 4500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] There is no USB functionality with 2.6.3 or 2.6.5 kernels on Dell 
Dimension 4500.

[2.] USB has worked fine with 2.4 kernels from Mandrake through 9.2, but 
stopped completely with the 2.6.3 kernels from Mandrake 10.0 Community 
and Official.  I downloaded and compiled a stock 2.6.5 kernel, and the 
result is the same.  I have USB working with 2.6.3 kernels on an old 
Sony and on a new Dell Precision, so I am confident the problem is 
peculiar to the Dell 4500.  The symptoms are that the usb modules load 
normally, but plugging in a USB peripheral (in this case, a Zip drive) 
produces the following in /var/log/messages:

Apr 17 15:22:24 nene kernel: usb 2-1: new full speed USB device using 
address 2
Apr 17 15:22:29 nene kernel: usb 2-1: control timeout on ep0out
Apr 17 15:22:29 nene kernel: uhci_hcd 0000:00:1d.1: Unlink after no-IRQ? 
  Different ACPI or APIC settings may help.

The drive never spins, and shows no signs of having been connected. 
Disconnecting the usb cable results in no additional messages.  There is 
no response to turning on or connecting a usb printer, either; both of 
these peripherals work normally on this machine with the 2.4 kernels. (I 
have found that one setup difference is needed when switching between 
2.4 and 2.6 kernels on the machines that work normally: the hotplug 
service needs to be enabled [in the init scripts, e.g. with chkconfig] 
for 2.4 kernels, but must not be enabled for 2.6 kernels.)

Subsequent plug/unplug events produce no messages or response 
whatsoever, regardless of the USB port used, until the machine is rebooted.

I have tried kernel options "noapic" and "acpi=off", as well as omitting 
them; they make no difference.  (I have had no problems with acpi and 
apic using the 2.4 kernels on this machine.)

[3.] PCI IRQ USB

[4.] [root@nene efiring]# cat /proc/version
Linux version 2.6.5 (efiring@nene.hawaii.rr.com) (gcc version 3.3.2 
(Mandrake Linux 10.0 3.3.2-6mdk)) #1 Sat Apr 17 14:09:04 HST 2004

[5.] none

[6.] none

[7.]
[7.1.]
  Gnu C                  3.3.2
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.34
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.1.2
Modules Loaded         snd nfsd exportfs usblp lp parport_pc parport 
ipv6 es1371          soundcore gameport ac97_codec af_packet hid ide_cd 
cdrom floppy natsemi ntfs nl         s_iso8859_1 nls_cp850 vfat fat 
intel_agp agpgart ehci_hcd uhci_hcd usbcore genrt         c ext3 jbd

[7.2.]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 2
cpu MHz         : 1794.775
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3538.94

[7.3.]
snd 50884 0 - Live 0xf1a10000
nfsd 182112 8 - Live 0xf1a5e000
exportfs 5856 1 nfsd, Live 0xf1928000
usblp 12096 0 - Live 0xf19e9000
lp 11976 0 - Live 0xf1995000
parport_pc 32032 1 - Live 0xf19f0000
parport 38248 2 lp,parport_pc, Live 0xf19cf000
ipv6 226816 10 - Live 0xf1a25000
es1371 33280 0 - Live 0xf19da000
soundcore 9056 2 snd,es1371, Live 0xf1999000
gameport 4416 1 es1371, Live 0xf1925000
ac97_codec 17612 1 es1371, Live 0xf198f000
af_packet 20264 0 - Live 0xf1989000
hid 42304 0 - Live 0xf19c3000
ide_cd 38532 0 - Live 0xf19b8000
cdrom 37920 1 ide_cd, Live 0xf19ad000
floppy 59060 0 - Live 0xf199d000
natsemi 23072 0 - Live 0xf1949000
ntfs 85484 1 - Live 0xf1952000
nls_iso8859_1 3904 2 - Live 0xf1803000
nls_cp850 4736 1 - Live 0xf1838000
vfat 13984 1 - Live 0xf191d000
fat 45216 1 vfat, Live 0xf192b000
intel_agp 17308 1 - Live 0xf1832000
agpgart 31848 1 intel_agp, Live 0xf1903000
ehci_hcd 24836 0 - Live 0xf182a000
uhci_hcd 28464 0 - Live 0xf180b000
usbcore 96892 6 usblp,hid,ehci_hcd,uhci_hcd, Live 0xf185c000
genrtc 8712 0 - Live 0xf1807000
ext3 105992 6 - Live 0xf1841000
jbd 52824 1 ext3, Live 0xf1814000

[7.4.]
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0218-021f : es1371
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
04d0-04d1 : pnp 00:0b
0778-077a : parport0
0cf8-0cff : PCI conf1
d480-d4bf : 0000:02:02.0
   d480-d4bf : es1371
d800-d8ff : 0000:02:00.0
   d800-d8ff : eth0
dc00-dc07 : 0000:02:01.0
e480-e49f : 0000:00:1f.3
e800-e81f : 0000:00:1d.0
   e800-e81f : uhci_hcd
e880-e89f : 0000:00:1d.1
   e880-e89f : uhci_hcd
ec00-ec1f : 0000:00:1d.2
   ec00-ec1f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2ff3ffff : System RAM
   00100000-002b2ac8 : Kernel code
   002b2ac9-003748ff : Kernel data
2ff40000-2ff4ffff : ACPI Tables
2ff50000-2fffffff : ACPI Non-volatile Storage
30000000-300003ff : 0000:00:1f.1
e4600000-f46fffff : PCI Bus #01
   e8000000-efffffff : 0000:01:00.0
     e8000000-e8ffffff : vesafb
f8000000-fbffffff : 0000:00:00.0
fc900000-fe9fffff : PCI Bus #01
   fd000000-fdffffff : 0000:01:00.0
fead0000-feadffff : 0000:02:01.0
feaff000-feafffff : 0000:02:00.0
   feaff000-feafffff : eth0
febffc00-febfffff : 0000:00:1d.7
   febffc00-febfffff : ehci_hcd

[7.5.]  (I don't have lspci on the MDK 10.0 side of this machine.)
[root@nene efiring]# lspcidrake
intel-agp       : Intel Corporation|82845 845 (Brookdale) Chipset Host 
Bridge [BRIDGE_HOST]
unknown         : Intel Corporation|82845 845 (Brookdale) Chipset AGP 
Bridge [BRIDGE_PCI]
usb-uhci        : Intel Corporation|82801DB USB Controller [SERIAL_USB]
usb-uhci        : Intel Corporation|82801DB USB Controller [SERIAL_USB]
usb-uhci        : Intel Corporation|82801DB USB Controller [SERIAL_USB]
ehci-hcd        : Intel Corporation|82801DB USB Enhanced Controller 
[SERIAL_USB]
i810_rng        : Intel Corporation|82820 815e (Camino 2) Chipset PCI 
[BRIDGE_PCI]
i810-tco        : Intel Corporation|82801DB 845G/GL Chipset ISA Bridge 
(ICH4) [BRIDGE_ISA]
unknown         : Intel Corporation|82801DB 845G/GL Chipset IDE 
Controller [STORAGE_IDE]
unknown         : Intel Corporation|82801DB SMBus Controller [SERIAL_SMBUS]
Card:NVIDIA GeForce2 DDR (generic): nVidia Corporation|NV11 Geforce2 
MX/MX 400 [DISPLAY_VGA]
natsemi         : National Semi|DP83810 10/100 Ethernet [NETWORK_ETHERNET]
unknown         : Conexant|HSP MicroModem 56K [COMMUNICATION_OTHER]
es1371          : Creative Labs|Sound Blaster AudioPCI64V/AudioPCI128 
[MULTIMEDIA_AUDIO]
unknown         : Linux 2.6.5 ehci_hcd|Intel Corp. 82801DB USB2 [Hub]
unknown         : Linux 2.6.5 uhci_hcd|Intel Corp. 82801DB USB (Hub #3) 
[Hub]
unknown         : Linux 2.6.5 uhci_hcd|Intel Corp. 82801DB USB (Hub #2) 
[Hub]
unknown         : Linux 2.6.5 uhci_hcd|Intel Corp. 82801DB USB (Hub #1) 
[Hub]

[7.6.]
no scsi modules loaded

[7.7.]
[root@nene proc]# cat interrupts
            CPU0
   0:    2086694          XT-PIC  timer
   1:       6626          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  uhci_hcd
   7:          1          XT-PIC  parport0
   9:        750          XT-PIC  uhci_hcd, es1371
  10:          0          XT-PIC  ehci_hcd
  11:       1194          XT-PIC  uhci_hcd, eth0
  12:      66721          XT-PIC  i8042
  14:       7894          XT-PIC  ide0
  15:         47          XT-PIC  ide1
NMI:          0
LOC:    2086857
ERR:          0
MIS:          0

---------------------------------------------------
That's all I can think of for now; I will happy to provide any other 
information I can that might be useful.

Eric

