Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130272AbQLLOpP>; Tue, 12 Dec 2000 09:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130604AbQLLOpG>; Tue, 12 Dec 2000 09:45:06 -0500
Received: from minster.cs.york.ac.uk ([144.32.40.2]:45005 "EHLO
	minster.cs.york.ac.uk") by vger.kernel.org with ESMTP
	id <S130180AbQLLOoz>; Tue, 12 Dec 2000 09:44:55 -0500
From: "Laramie Leavitt" <lar@cs.york.ac.uk>
To: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: PROBLEM: USB (MS Intellimouse specifically) does not work with SMP Linux 2.2.18.
Date: Tue, 12 Dec 2000 14:07:59 -0000
Message-ID: <NEBBKCNHIKGLMACGICIGAEFMCAAA.lar@cs.york.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
USB (MS Intellimouse specifically) does not work with SMP kernel 2.2.18.

[2.] Full description of the problem/report:
When trying to install a Microsoft Intellimouse Explorer (USB)
to a SMP kernel, I get the following error multiple times:

usb.c: USB device not accepting new address (error=-110)

If USB is compiled in, then it happens several times during the
boot sequence.

Everything works fine on a single-processor kernel.  I have tried
installing all of USB as modules, and I have tried compiling it
into the kernel with no change.

System is a MSI 694D-Pro AR motherboard (Via 694X chipset)
Dual 500 Mhz Celeron processors, 500 Mhz (Not overclocked)
Microsoft Intellimouse explorer.

I suspect that it is an issue where locking is required,
but none currently exists, either in mousedev, usb, or
uhci.  (Great logic--those are the main modules that should
be in use.) I suspect that the problem can be duplicated
on my system under Linux 2.4.0-test11, but, alas, I cannot
get linux 2.4 to boot right now.

I don't see the hid module in the status output like I do on
the uni-processor kernel.  Maybe those structures need locks.

[3.] Keywords (i.e., modules, networking, kernel):
USB, mousedev, hid, input, mouse, intellimouse, linux-2.2.18

[4.] Kernel version (from /proc/version):
Linux 2.2.18

[5.] [6.] N/A
I can reproduce it with the current kernel every time.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Slackware 7.1 + Linux 2.2.18

[7.2.] Processor information (from /proc/cpuinfo):
Below.

[7.3.] Module information (from /proc/modules):
Below

[7.4.] SCSI information (from /proc/scsi/scsi)
Not Applicable.

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

#/proc/version
Linux version 2.2.18 (root@darkstar) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #1 SMP Mon Dec 11 23:32:12 GMT 2000

#/proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 501.148
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 999.42

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 5
cpu MHz		: 501.148
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 999.42

#/proc/modules
mousedev                3916   0 (unused)
input                   2780   0 [mousedev]
uhci                   19100   0 (unused)
usbcore                49256   1 [uhci]

#/proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies Unknown device (rev 196).
      Vendor id=1106. Device id=691.
      Medium devsel.  Master Capable.  No bursts.
      Prefetchable 32 bit memory at 0xd0000000 [0xd0000008].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
      Medium devsel.  Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies Unknown device (rev 34).
      Vendor id=1106. Device id=686.
      Medium devsel.  Master Capable.  No bursts.
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 16).
      Medium devsel.  Fast back-to-back capable.  Master Capable.
Latency=32.
      I/O at 0xc000 [0xc001].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 16).
      Medium devsel.  IRQ 19.  Master Capable.  Latency=32.
      I/O at 0xc400 [0xc401].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies VT 82C586 Apollo USB (rev 16).
      Medium devsel.  IRQ 19.  Master Capable.  Latency=32.
      I/O at 0xc800 [0xc801].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies Unknown device (rev 48).
      Vendor id=1106. Device id=3057.
      Medium devsel.  Fast back-to-back capable.
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies Unknown device (rev 32).
      Vendor id=1106. Device id=3058.
      Medium devsel.  IRQ 18.
      I/O at 0xcc00 [0xcc01].
      I/O at 0xd000 [0xd001].
      I/O at 0xd400 [0xd401].
  Bus  0, device  12, function  0:
    RAID storage controller: Promise Technology Unknown device (rev 2).
      Vendor id=105a. Device id=d30.
      Medium devsel.  IRQ 18.  Master Capable.  Latency=32.
      I/O at 0xd800 [0xd801].
      I/O at 0xdc00 [0xdc01].
      I/O at 0xe000 [0xe001].
      I/O at 0xe400 [0xe401].
      I/O at 0xe800 [0xe801].
      Non-prefetchable 32 bit memory at 0xd9000000 [0xd9000000].
  Bus  0, device  14, function  0:
    Communication controller: Unknown vendor Unknown device (rev 8).
      Vendor id=14f1. Device id=1035.
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master Capable.
Latency=32.
      Non-prefetchable 32 bit memory at 0xd9020000 [0xd9020000].
      I/O at 0xec00 [0xec01].
  Bus  0, device  15, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 3).
      Vendor id=1073. Device id=d.
      Medium devsel.  IRQ 17.  Master Capable.  Latency=32.  Min Gnt=5.Max
Lat=25.
      Non-prefetchable 32 bit memory at 0xd9030000 [0xd9030000].
  Bus  1, device   0, function  0:
    VGA compatible controller: NVidia Unknown device (rev 17).
      Vendor id=10de. Device id=28.
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master Capable.
Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6000000].
      Prefetchable 32 bit memory at 0xd4000000 [0xd4000008].

#/proc/usb/devices
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=c800
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=c400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
