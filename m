Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271505AbRHXOY5>; Fri, 24 Aug 2001 10:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRHXOYq>; Fri, 24 Aug 2001 10:24:46 -0400
Received: from www.heureka.co.at ([195.64.11.111]:37637 "EHLO
	www.heureka.co.at") by vger.kernel.org with ESMTP
	id <S271505AbRHXOYc>; Fri, 24 Aug 2001 10:24:32 -0400
Date: Fri, 24 Aug 2001 16:24:25 +0200
From: David Schmitt <david@heureka.co.at>
To: linux-kernel@vger.kernel.org
Subject: ISSUE: DFE530-TX REV-A3-1 times out on transmit
Message-ID: <20010824162425.D27794@www.heureka.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Heureka - Der EDV-Dienstleister
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:
	DFE530-TX REV-A3-1 times out on transmit

[2.] Full description of the problem/report:
	After receiving ~50 MB of network traffic the DFE530-TX
	(REV-A3-1) starts emitting 

Aug 24 11:13:57 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 24 11:13:57 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
Aug 24 11:13:57 cheesy kernel: eth0: reset finished after 5 microseconds.

	After some more traffic the resets stop working and the card
	cannot transmit or receive anymore.

Aug 24 11:15:07 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 24 11:15:07 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
Aug 24 11:15:07 cheesy kernel: eth0: reset did not complete in 10 ms.
Aug 24 11:15:07 cheesy kernel: eth0: reset finished after 10005 microseconds.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #1 queued in slot 0.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #2 queued in slot 1.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #3 queued in slot 2.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #4 queued in slot 3.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #5 queued in slot 4.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #6 queued in slot 5.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #7 queued in slot 6.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #8 queued in slot 7.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #9 queued in slot 8.
Aug 24 11:15:07 cheesy kernel: eth0: Transmit frame #10 queued in slot 9.
Aug 24 11:15:09 cheesy kernel: eth0: VIA Rhine monitor tick, status 0000.
Aug 24 11:15:11 cheesy kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 24 11:15:11 cheesy kernel: eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
Aug 24 11:15:11 cheesy kernel: eth0: reset did not complete in 10 ms.
Aug 24 11:15:11 cheesy kernel: eth0: reset finished after 10005 microseconds.

	Reloading the module doesn't help either. Only a reboot
	reenables network connectivity.

[3.] Keywords (i.e., modules, networking, kernel):
	d-link, dfe530-tx rev-a3-1, networking, transmit
	NETDEV WATCHDOG: transmit timed out
	nic network card pci

[4.] Kernel version (from /proc/version):

Linux version 2.4.9-cheesy-1 (david@cheesy) (gcc version 2.95.4 20010319 (Debian prerelease)) #1 Wed Aug 22 17:21:16 CEST 2001

[6.] A small shell script or example program which triggers the
	problem (if possible)

	Downloading amounts of data (>50MB) will eventually trigger
	the problem. Transmitting data at less than full speed will
	not trigger it (or at least I haven't waited long enough?)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux cheesy 2.4.9-cheesy-1 #1 Wed Aug 22 17:21:16 CEST 2001 i686 unknown
Kernel modules         2.4.6
Gnu C                  2.95.4
Binutils               2.11.90.0.27
Linux C Library        2.2.3
Dynamic Linker (ld.so) 2.2.3
Procps                 2.0.7
Mount                  2.11h
Net-tools              1.60
Kbd                    0.2.3
Sh-utils               2.0.11

[7.2.] Processor information (from /proc/cpuinfo):

cheesy:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1199.699
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

cheesy:~#


[7.3.] Module information (from /proc/modules):

cheesy:~# cat /proc/modules
serial                 42816   0 (autoclean)
via-rhine              10704   1
unix                   15008   4 (autoclean)
ide-disk                6912   4 (autoclean)
ide-probe-mod           8592   0 (autoclean)
ide-mod                68432   4 (autoclean) [ide-disk ide-probe-mod]
ext2                   33424   2 (autoclean)
cheesy:~#

[7.4.] SCSI information (from /proc/scsi/scsi):

No SCSI.

[7.5.] Other information that might be relevant to the problem
	(please look in /proc and include all information that you
	think to be relevant):

cheesy:/proc# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-001b6e77 : Kernel code
  001b6e78-001f3a7f : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
dd000000-dd0000ff : VIA Technologies, Inc. Ethernet Controller
  dd000000-dd0000ff : via-rhine
dd800000-dfdfffff : PCI Bus #01
  dd800000-dd800fff : ATI Technologies Inc Rage XL AGP
  de000000-deffffff : ATI Technologies Inc Rage XL AGP
dff00000-dfffffff : PCI Bus #01
e0000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved
cheesy:/proc# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
9400-94ff : VIA Technologies, Inc. Ethernet Controller
  9400-94ff : via-rhine
a000-a003 : VIA Technologies, Inc. AC97 Audio Controller
a400-a403 : VIA Technologies, Inc. AC97 Audio Controller
a800-a8ff : VIA Technologies, Inc. AC97 Audio Controller
b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
b400-b41f : VIA Technologies, Inc. UHCI USB
b800-b80f : VIA Technologies, Inc. Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Rage XL AGP
e200-e27f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

[X.] Other notes, patches, fixes, workarounds

Further information from lspci, via-diag and ifconfig output as well
as well as complete kernel syslog from boot to network-lock can be
found on http://www.heureka.co.at/~david/dfe530tx/


Short lspci output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:04.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
00:0b.0 Ethernet controller: VIA Technologies, Inc. Ethernet Controller (rev 43)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27)


Thank you for your time and work!

Regards, David Schmitt
-- 
Report, Hardware and Bandwidth provided by Heureka GesmbH, Austria.
