Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263551AbUE1Pef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUE1Pef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbUE1Pef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:34:35 -0400
Received: from pony-express.cs.rit.edu ([129.21.30.24]:59625 "HELO
	pony-express.cs.rit.edu") by vger.kernel.org with SMTP
	id S263551AbUE1PeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:34:14 -0400
Message-ID: <50023.67.50.137.207.1085758454.squirrel@webmail.cs.rit.edu>
Date: Fri, 28 May 2004 11:34:14 -0400 (EDT)
Subject: bug in vmscan.c
From: dem5302@cs.rit.edu
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

I recently encountered this kernel bug.  You were the only one in the
MAINTAINERS file that seemed to have anything to do with memory, and I
assumed vmscan.c had something to do virtual memory.

[1.] One line summary of the problem:
The kernel crashed while I was transferring a 6 gig file over sftp.

[2.] Full description of the problem/report:
sftp terminates with a broken pipe, and after I kickstarted the machine
and looked at the system logs, I saw the kernel message as pasted below.

[3.] Keywords (i.e., modules, networking, kernel):
Memory, kernel bug, virtual memory

[4.] Kernel version (from /proc/version):
Linux version 2.4.25 (root@cviserver4) (gcc version 3.3.2 20031022 (Red
Hat Linux 3.3.2-1)) #2 Fri Mar 5 09:48:03 EST 2004

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

May 28 09:06:55 cviserver4 sshd(pam_unix)[10900]: session closed for user
root
May 28 09:07:13 cviserver4 sshd(pam_unix)[10903]: session opened for user
root by (uid=0)
May 28 09:18:11 cviserver4 kernel: kernel BUG at vmscan.c:388!
May 28 09:18:11 cviserver4 kernel: invalid operand: 0000
May 28 09:18:11 cviserver4 kernel: CPU:    0
May 28 09:18:11 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:18:11 cviserver4 kernel: EFLAGS: 00010202
May 28 09:18:11 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: c1411108
May 28 09:18:11 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
0000368f   esp: dffaff3c
May 28 09:18:11 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:18:11 cviserver4 kernel: Process kswapd (pid: 4,
stackpage=dffaf000)
May 28 09:18:11 cviserver4 kernel: Stack: c1225650 000001d0 00000c80
000001d0 00000006 00000020 000001d0 c029bc18
May 28 09:18:11 cviserver4 kernel:        c029bc18 c013137d dffaff84
000001d0 0000003c 00000020 c0131402 dffaff84
May 28 09:18:11 cviserver4 kernel:        dffae000 00000000 00000000
c029bc18 00000001 dffae000 00000000 c01315c6
May 28 09:18:11 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c01315c6>] [<c0131638>] [<c0131778>]
May 28 09:18:12 cviserver4 kernel:   [<c01316e0>] [<c0105000>]
[<c01073be>] [<c01316e0>]
May 28 09:18:12 cviserver4 kernel:
May 28 09:18:12 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:18:12 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:18:12 cviserver4 kernel: invalid operand: 0000
May 28 09:18:12 cviserver4 kernel: CPU:    0
May 28 09:18:12 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:18:12 cviserver4 kernel: EFLAGS: 00010202
May 28 09:18:12 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:18:12 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e2   esp: d6489e40
May 28 09:18:12 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:18:12 cviserver4 kernel: Process sftp-server (pid: 10905,
stackpage=d6489000)
May 28 09:18:12 cviserver4 kernel: Stack: de446760 c1587204 00000c80
000001d2 00000020 00000020 000001d2 c029bc18
May 28 09:18:12 cviserver4 kernel:        c029bc18 c013137d d6489e88
000001d2 0000003c 00000020 c0131402 d6489e88
May 28 09:18:12 cviserver4 kernel:        dffb40c0 00000000 00000000
d6488000 00000000 c029bc18 00000000 c0132372
May 28 09:18:12 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c012caf0>]
May 28 09:18:12 cviserver4 kernel:   [<c012d0ce>] [<e0834fe9>]
[<c01392e3>] [<c0108f6f>]
May 28 09:18:12 cviserver4 kernel:
May 28 09:18:12 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:18:12 cviserver4 sshd(pam_unix)[10903]: session closed for user
root
May 28 09:23:05 cviserver4 sshd(pam_unix)[10920]: authentication failure;
logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=192.168.0.53  user=root
May 28 09:23:12 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:23:12 cviserver4 kernel: invalid operand: 0000
May 28 09:23:12 cviserver4 kernel: CPU:    0
May 28 09:23:12 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:23:12 cviserver4 kernel: EFLAGS: 00010202
May 28 09:23:12 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:23:12 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e5   esp: dea53dfc
May 28 09:23:12 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:23:12 cviserver4 kernel: Process sshd (pid: 10921,
stackpage=dea53000)
May 28 09:23:12 cviserver4 kernel: Stack: dfe50000 c10eb9ac 00000c80
000001d2 00000020 00000020 000001d2 c029bc18
May 28 09:23:12 cviserver4 kernel:        c029bc18 c013137d dea53e44
000001d2 0000003c 00000020 c0131402 dea53e44
May 28 09:23:12 cviserver4 kernel:        00000009 00000000 00000000
dea52000 00000000 c029bc18 00000000 c0132372
May 28 09:23:12 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c0126e15>]
May 28 09:23:12 cviserver4 sshd(pam_unix)[10920]: 2 more authentication
failures; logname= uid=0 euid=0 tty=NODEVssh ruser= rhost=192.168.0.53
user=root
May 28 09:23:12 cviserver4 kernel:   [<c01276e6>] [<c01143b8>]
[<c0229c2c>] [<c020331f>] [<c02070d3>] [<c010a65b>]
May 28 09:23:12 cviserver4 kernel:   [<c0114240>] [<c0109060>]
May 28 09:23:12 cviserver4 kernel:
May 28 09:23:12 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:23:34 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:23:34 cviserver4 kernel: invalid operand: 0000
May 28 09:23:34 cviserver4 kernel: CPU:    0
May 28 09:23:34 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:23:34 cviserver4 kernel: EFLAGS: 00010202
May 28 09:23:34 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:23:34 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e5   esp: d4463dfc
May 28 09:23:34 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:23:34 cviserver4 kernel: Process sshd (pid: 10922,
stackpage=d4463000)
May 28 09:23:34 cviserver4 kernel: Stack: c010a4a5 c10eb980 00000c80
000001d2 00000020 00000020 000001d2 c029bc18
May 28 09:23:34 cviserver4 kernel:        c029bc18 c013137d d4463e44
000001d2 0000003c 00000020 c0131402 d4463e44
May 28 09:23:34 cviserver4 kernel:        dfe6d560 00000000 00000000
d4462000 00000000 c029bc18 00000000 c0132372
May 28 09:23:34 cviserver4 kernel: Call Trace:    [<c010a4a5>]
[<c013137d>] [<c0131402>] [<c0132372>] [<c0132688>]
May 28 09:23:34 cviserver4 kernel:   [<c0126e15>] [<c01276e6>]
[<c01143b8>] [<c014de16>] [<c014f67c>] [<c012aec7>]
May 28 09:23:34 cviserver4 kernel:   [<c012ad70>] [<c01391f7>]
[<c0114240>] [<c0109060>]
May 28 09:23:34 cviserver4 kernel:
May 28 09:23:34 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:23:53 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:23:53 cviserver4 kernel: invalid operand: 0000
May 28 09:23:53 cviserver4 kernel: CPU:    0
May 28 09:23:53 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:23:53 cviserver4 kernel: EFLAGS: 00010202
May 28 09:23:53 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:23:53 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e5   esp: dffc9dfc
May 28 09:23:53 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:23:53 cviserver4 kernel: Process sshd (pid: 10925,
stackpage=dffc9000)
May 28 09:23:53 cviserver4 kernel: Stack: c36866e0 dffb45d0 000007d0
000001d2 00000014 00000014 000001d2 c029bc18
May 28 09:23:53 cviserver4 kernel:        c029bc18 c013137d dffc9e44
000001d2 0000003c 00000020 c0131402 dffc9e44
May 28 09:23:53 cviserver4 kernel:        c40b8800 00000000 00000000
dffc8000 00000000 c029bc18 00000000 c0132372
May 28 09:23:53 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c0126e15>]
May 28 09:23:53 cviserver4 kernel:   [<c010cbb8>] [<c01276e6>]
[<c0128685>] [<c01143b8>] [<c013879d>] [<c0114240>]
May 28 09:23:53 cviserver4 kernel:   [<c0109060>]
May 28 09:23:53 cviserver4 kernel:
May 28 09:23:53 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:24:09 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:24:09 cviserver4 kernel: invalid operand: 0000
May 28 09:24:09 cviserver4 kernel: CPU:    0
May 28 09:24:09 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:24:09 cviserver4 kernel: EFLAGS: 00010202
May 28 09:24:09 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:24:09 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e7   esp: dea53dfc
May 28 09:24:09 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:24:09 cviserver4 kernel: Process sshd (pid: 10926,
stackpage=dea53000)
May 28 09:24:09 cviserver4 kernel: Stack: de089b90 c10eb928 00000c80
000001d2 00000020 00000020 000001d2 c029bc18
May 28 09:24:09 cviserver4 kernel:        c029bc18 c013137d dea53e44
000001d2 0000003c 00000020 c0131402 dea53e44
May 28 09:24:09 cviserver4 kernel:        dfe26ec0 00000000 00000000
dea52000 00000000 c029bc18 00000000 c0132372
May 28 09:24:09 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c0126e15>]
May 28 09:24:09 cviserver4 kernel:   [<c01276e6>] [<c01143b8>]
[<c0201ab6>] [<c01ff97c>] [<c0200dd0>] [<c020142b>]
May 28 09:24:09 cviserver4 kernel:   [<c0114240>] [<c0109060>]
May 28 09:24:09 cviserver4 kernel:
May 28 09:24:09 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:24:12 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:24:12 cviserver4 kernel: invalid operand: 0000
May 28 09:24:12 cviserver4 kernel: CPU:    0
May 28 09:24:12 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:24:12 cviserver4 kernel: EFLAGS: 00010202
May 28 09:24:12 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:24:12 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e7   esp: dd7f3dfc
May 28 09:24:12 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:24:12 cviserver4 kernel: Process sshd (pid: 975,
stackpage=dd7f3000)
May 28 09:24:12 cviserver4 kernel: Stack: d6c27000 c1587b4c 000006a4
000001d2 00000011 00000011 000001d2 c029bc18
May 28 09:24:12 cviserver4 kernel:        c029bc18 c013137d dd7f3e44
000001d2 0000003c 00000020 c0131402 dd7f3e44
May 28 09:24:12 cviserver4 kernel:        00000005 00000000 00000000
dd7f2000 00000000 c029bc18 00000000 c0132372
May 28 09:24:12 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c0126e15>]
May 28 09:24:12 cviserver4 kernel:   [<c01276e6>] [<c01143b8>]
[<c0117810>] [<c0116104>] [<c0117317>] [<c013879d>]
May 28 09:24:12 cviserver4 kernel:   [<c0114240>] [<c0109060>]
May 28 09:24:12 cviserver4 kernel:
May 28 09:24:12 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:24:12 cviserver4 kernel:  kernel BUG at vmscan.c:388!
May 28 09:24:12 cviserver4 kernel: invalid operand: 0000
May 28 09:24:12 cviserver4 kernel: CPU:    0
May 28 09:24:12 cviserver4 kernel: EIP:    0010:[<c01311bd>]    Not tainted
May 28 09:24:12 cviserver4 kernel: EFLAGS: 00010202
May 28 09:24:12 cviserver4 kernel: eax: 000a0040   ebx: 00000000   ecx:
c144e004   edx: 00000064
May 28 09:24:12 cviserver4 kernel: esi: c144dfe8   edi: c029bc18   ebp:
000036e9   esp: c0da1dfc
May 28 09:24:12 cviserver4 kernel: ds: 0018   es: 0018   ss: 0018
May 28 09:24:12 cviserver4 kernel: Process sshd (pid: 10927,
stackpage=c0da1000)
May 28 09:24:12 cviserver4 kernel: Stack: 00000246 c14e39f4 00000c80
000001d2 00000020 00000020 000001d2 c029bc18
May 28 09:24:12 cviserver4 kernel:        c029bc18 c013137d c0da1e44
000001d2 0000003c 00000020 c0131402 c0da1e44
May 28 09:24:12 cviserver4 kernel:        00000005 00000000 00000000
c0da0000 00000000 c029bc18 00000000 c0132372
May 28 09:24:12 cviserver4 kernel: Call Trace:    [<c013137d>]
[<c0131402>] [<c0132372>] [<c0132688>] [<c0126e15>]
May 28 09:24:12 cviserver4 kernel:   [<c01276e6>] [<c01143b8>]
[<c0117810>] [<c0116104>] [<c0117317>] [<c013879d>]
May 28 09:24:12 cviserver4 kernel:   [<c0114240>] [<c0109060>]
May 28 09:24:12 cviserver4 kernel:
May 28 09:24:12 cviserver4 kernel: Code: 0f 0b 84 01 13 8d 26 c0 e9 09 fd
ff ff c7 00 00 00 00 00 e8
May 28 09:32:03 cviserver4 syslogd 1.4.1: restart.

[6.] A small shell script or example program which triggers the
     problem (if possible)
I cannot reproduce the bug

[7.] Environment
     Fedora Core 1

[7.1.] Software (add the output of the ver_linux script here)

 Linux cviserver4 2.4.25 #2 Fri Mar 5 09:48:03 EST 2004 i686 i686 i386
GNU/Linux

Gnu C                  3.3.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
modutils               2.4.26
e2fsprogs              1.34
reiserfsprogs          3.6.8
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.17
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         wcusb wcfxs wcfxo zaptel usb-uhci usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 996.581
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1985.74

[7.3.] Module information (from /proc/modules):
wcusb, wcfxs, wcfxo, and zaptel are from Digium (www.digium.com)

wcusb                  19712   0 (unused)
wcfxs                  61920   1
wcfxo                   9088   3
zaptel                178752  20 [wcusb wcfxs wcfxo]
usb-uhci               26480   0 (unused)
usbcore                77900   1 [wcusb usb-uhci]
ext3                   70692   2
jbd                    52120   2 [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #01
c400-c41f : VIA Technologies, Inc. USB
  c400-c41f : usb-uhci
c800-c81f : VIA Technologies, Inc. USB (#2)
  c800-c81f : usb-uhci
cc00-ccff : VIA Technologies, Inc. VT6102 [Rhine-II]
  cc00-ccff : via-rhine
d000-d0ff : Tiger Jet Network Inc. Intel 537
  d000-d0fe : wcfxo
d400-d4ff : Tiger Jet Network Inc. Intel 537 (#2)
  d400-d4fe : wcfxs
d800-d8ff : Tiger Jet Network Inc. Intel 537 (#3)
  d800-d8fe : wcfxo
dc00-dcff : Tiger Jet Network Inc. Intel 537 (#4)
  dc00-dcfe : wcfxo
ffa0-ffaf : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C
PIPC Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0025b681 : Kernel code
  0025b682-002b00e3 : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
d9c00000-ddcfffff : PCI Bus #01
  da000000-dbffffff : nVidia Corporation NV6 [Vanta/Vanta LT]
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV6 [Vanta/Vanta LT]
dfffbf00-dfffbfff : VIA Technologies, Inc. VT6102 [Rhine-II]
  dfffbf00-dfffbfff : via-rhine
dfffc000-dfffcfff : Tiger Jet Network Inc. Intel 537
dfffd000-dfffdfff : Tiger Jet Network Inc. Intel 537 (#2)
dfffe000-dfffefff : Tiger Jet Network Inc. Intel 537 (#3)
dffff000-dfffffff : Tiger Jet Network Inc. Intel 537 (#4)
e0000000-e3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: d9c00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller]
(rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
43)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at cc00 [size=256]
        Region 1: Memory at dfffbf00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at dffc0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Communication controller: Individual Computers - Jens Schoenfeld
Intel 537
        Subsystem: Unknown device 8085:0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at dfffc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Communication controller: Individual Computers - Jens Schoenfeld
Intel 537
        Subsystem: Unknown device b100:0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dfffd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Individual Computers - Jens Schoenfeld
Intel 537
        Subsystem: Unknown device 8085:0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at dfffe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Communication controller: Individual Computers - Jens Schoenfeld
Intel 537
        Subsystem: Unknown device 8085:0003
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (250ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta/Vanta LT]
(rev 15) (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology: Unknown device 0620
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at da000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at dfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
No SCSI

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

OpenSSH version 3.6.1p2

