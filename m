Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTGKONP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTGKONC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:13:02 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:50852 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262409AbTGKOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:11:53 -0400
Message-Id: <200307111426.h6BEQZi1001897@faui31x.informatik.uni-erlangen.de>
From: Peter Asemann <sipeasem@immd3.informatik.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: struct siginfo member si_fd not properly filled in handler after SIGIO (2.4.x) - offending POSIX specs?
Date: Fri, 11 Jul 2003 16:26:35 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BS6VS6NKTK4XBP52XZ69"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BS6VS6NKTK4XBP52XZ69
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Be greeted!

Problem: After a SIGIO/SIOPOLL signal was delivered to a process, the siginfo 
structure provided by the kernel (if you use the three-parameter sa_sigaction 
(not sa_handler) and set the SA_SIGINFO flag in sa_flags) is not 
properly set. It's si_fd member is always zero. It should be the fd number of 
the fd responsible for the SIGIO/SIGPOLL (say sigaction(2) and the POSIX 
specs, I suppose).

Keywords: kernel, signal, SIGIO, SIGPOLL, siginfo, sigaction

Reproducible: Always

Kernel versions: 2.4.x (several, including 2.4.10 (SuSE) 2.4.18 (Debian 3.0))

Severity:
So so. I wanted to use the feature.

Plattform/Version/Hardware/Software:
 I've tested this with the program mentioned below on a SuSE 7.3 system on HP 
Vectra VL 2 Series 100 Pentium 100 and on a Debian Woody system with 
home-grown kernel on a P4 1.6GHz processor, both having completely different 
hard- and software.

Test/Demonstration program:

I've written a C program (attached) to demonstrate what I mean.
In order to provoke some SIGIO event it opens a tcp socket at port 9753 and 
sets O_ASYNC and O_NONBLOCKING flags and enables SIGIO signal delivery with 
fcntl.
If you connect to the port with "telnet localhost 9753" each time you send 
something a SIGIO is raised. The signal handler set up catches the signal and 
prints signal number, errno and si_fd from the siginfo structure.

The number given is (on my systems) always 0 and not the number of the file 
descriptor that actually is responsible for the SIGIO.

ver_linux output (Woody/P4 system):

Linux faui31x 2.4.18-686 #1 Sun Apr 14 11:32:47 EST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         lp parport_pc ppdev parport isofs loop ide-cd cdrom 
nfs nfsd lockd sunrpc autofs i810_audio soundcore ac97_codec eepro100 
af_packet rtc ext2 ide-disk ide-probe-mod ide-mod ext3 jbd unix

/proc/cpu:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 1.60GHz
stepping        : 4
cpu MHz         : 1595.208
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
ht tm
bogomips        : 3185.04

/proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #02
  df00-df3f : Intel Corp. 82557 [Ethernet Pro 100]
    df00-df3f : eepro100
e800-e8ff : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
  e800-e8ff : Intel ICH2
ef00-ef3f : Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Audio Controller
  ef00-ef3f : Intel ICH2
ef80-ef9f : Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
efa0-efaf : Intel Corp. 82820 820 (Camino 2) Chipset SMBus
ffa0-ffaf : Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

/proc/iomem:

00000000-00097bff : System RAM
00097c00-00097fff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8800-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffbffff : System RAM
  00100000-001cade2 : Kernel code
  001cade3-00204b2b : Kernel data
1ffc0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
f1600000-f56fffff : PCI Bus #01
  f2000000-f3ffffff : Matrox Graphics, Inc. MGA G400 AGP
f5700000-f57fffff : PCI Bus #02
f8000000-fbffffff : Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH)
fd900000-fe9fffff : PCI Bus #01
  fe000000-fe7fffff : Matrox Graphics, Inc. MGA G400 AGP
  fe9fc000-fe9fffff : Matrox Graphics, Inc. MGA G400 AGP
fea00000-feafffff : PCI Bus #02
  feac0000-feadffff : Intel Corp. 82557 [Ethernet Pro 100]
  feafb000-feafbfff : Intel Corp. 82557 [Ethernet Pro 100]
    feafb000-feafbfff : eepro100
  feafd000-feafdfff : NEC Corporation USB
  feafe000-feafefff : NEC Corporation USB (#2)
  feaffc00-feaffcff : PCI device 1033:00e0 (NEC Corporation)
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

The system has no SCSI, unfortunately I'm no actually root, so there's no PCI 
info except this:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH) 
(rev 4).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 4).
      Master Capable.  Latency=32.  Min Gnt=10.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 4).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) 
(rev 4).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 4).
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 
4).
      IRQ 10.
      I/O at 0xef80 [0xef9f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 4).
      IRQ 9.
      I/O at 0xefa0 [0xefaf].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) Chipset 
AC'97 Audio Controller (rev 4).
      IRQ 9.
      I/O at 0xe800 [0xe8ff].
      I/O at 0xef00 [0xef3f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 133).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xf2000000 [0xf3ffffff].
      Non-prefetchable 32 bit memory at 0xfe9fc000 [0xfe9fffff].
      Non-prefetchable 32 bit memory at 0xfe000000 [0xfe7fffff].
  Bus  2, device   1, function  1:
    USB Controller: NEC Corporation USB (#2) (rev 65).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xfeafe000 [0xfeafefff].
  Bus  2, device   1, function  0:
    USB Controller: NEC Corporation USB (rev 65).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xfeafd000 [0xfeafdfff].
  Bus  2, device   1, function  2:
    USB Controller: PCI device 1033:00e0 (NEC Corporation) (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=34.
      Non-prefetchable 32 bit memory at 0xfeaffc00 [0xfeaffcff].
  Bus  2, device  10, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 12).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeafb000 [0xfeafbfff].
      I/O at 0xdf00 [0xdf3f].
      Non-prefetchable 32 bit memory at 0xfeac0000 [0xfeadffff].

In case I'm wrong and/or have made several newbie mistakes and spammed this 
mailinglist I'm awfully sorry in advance. In case you're ever going to react 
on this eMail I'd like being cc'ed as I'm not subscribed to the mailinglist.

A friend of mine claims to have encountered this possible bug before. He says 
he tried to debug the kernel and found that the in_fd member is filled in 
correctly in the first place, but overwritten again later. He lost the 
interest then and didn't pin-point the exact location where things go wrong. 
Anyway - have a nice day.

Peter Asemann
--------------Boundary-00=_BS6VS6NKTK4XBP52XZ69
Content-Type: text/x-c;
  charset="iso-8859-1";
  name="testsigpoll.c"
Content-Transfer-Encoding: base64
Content-Description: test program to point out what's buggy
Content-Disposition: attachment; filename="testsigpoll.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4KI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgoj
aW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4K
CiNpbmNsdWRlIDxzaWduYWwuaD4KCnZvaWQgaGFuZGxlcihpbnQgc2lnLCBzaWdpbmZvX3QgKmV4
dHJhLCB2b2lkICpjcnVmdCkgewoJaWYgKHNpZyA9PSBTSUdJTykgewoJCWZwcmludGYoc3RkZXJy
LCJzaWduYWw6ICVkIGVycm5vOiAlZCBmZDogJWRcbiIsZXh0cmEtPnNpX3NpZ25vLGV4dHJhLT5z
aV9lcnJubyxleHRyYS0+c2lfZmQpOwoJfSAKfQoKaW50IG1haW4odm9pZCkKewppbnQgZmQ7Cmlu
dCBpbnNvY2s7CmludCBvbiA9IDE7CnNvY2tsZW5fdCBhZGRybGVuOwpzdHJ1Y3Qgc2lnYWN0aW9u
IHNhOwpzdHJ1Y3Qgc29ja2FkZHJfaW4gYWRkcl9pbjsKc3RydWN0IHNvY2thZGRyX2luIGFkZHJf
b3RoZXI7CgpzaWdlbXB0eXNldCgmc2Euc2FfbWFzayk7CnNpZ2FkZHNldCgmc2Euc2FfbWFzaywg
U0lHSU8pOwpzYS5zYV9zaWdhY3Rpb24gPSBoYW5kbGVyOyAKc2Euc2FfZmxhZ3MgPSBTQV9TSUdJ
TkZPOwpzaWdhY3Rpb24oU0lHSU8sICZzYSwgTlVMTCk7CgphZGRyX2luLnNpbl9mYW1pbHkgPSBB
Rl9JTkVUOwphZGRyX2luLnNpbl9wb3J0ID0gaHRvbnMoOTc1Myk7CmFkZHJfaW4uc2luX2FkZHIu
c19hZGRyID0gaHRvbmwoSU5BRERSX0FOWSk7CgppbnNvY2sgPSBzb2NrZXQoUEZfSU5FVCxTT0NL
X1NUUkVBTSwwKTsKc2V0c29ja29wdChpbnNvY2ssIFNPTF9TT0NLRVQsIFNPX1JFVVNFQUREUiwg
Jm9uLCBzaXplb2Yob24pKTsKYmluZChpbnNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikgJmFkZHJf
aW4sIHNpemVvZihhZGRyX2luKSk7Cmxpc3RlbihpbnNvY2ssIDEpOwppZiAoKGZkID0gYWNjZXB0
KGluc29jaywoc3RydWN0IHNvY2thZGRyICopICZhZGRyX290aGVyLCAmYWRkcmxlbikpID09IC0x
KSB7cGVycm9yKCJmYXVsdCIpO30gCmZwcmludGYoc3RkZXJyLCJmZCBpcyAlZFxuIixmZCk7Cmlm
IChmY250bChmZCwgRl9TRVRGTCwgZmNudGwgKGZkLEZfR0VURkwpIHwgT19OT05CTE9DSyB8IE9f
QVNZTkMpID09IDEpIHtwZXJyb3IoImZhdWx0Iik7fQppZiAoZmNudGwoZmQsRl9TRVRPV04sZ2V0
cGlkKCkpID09IC0xKSB7cGVycm9yKCJmYXVsdCIpO30KZnByaW50ZihzdGRlcnIsImFjY2VwdGVk
IGNvbm5lY3Rpb25cbiIpOwoKZG8gewp9IHdoaWxlKDEpOwoKfQo=

--------------Boundary-00=_BS6VS6NKTK4XBP52XZ69--
