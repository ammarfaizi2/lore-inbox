Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbTJZRdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTJZRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:33:39 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:28066 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263352AbTJZRdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:33:33 -0500
From: Richard van der Veen <rysh@home.nl>
To: linux-kernel@vger.kernel.org
Subject: [bug - linux-2.6.0test8]: network drops dead after putting interface in promiscuous mode
Date: Sun, 26 Oct 2003 18:33:27 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310261833.27934.rysh@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I have a problem with the test8 version of the 2.6.0 kernel. After i changed 
the network to use DHCP instead of an static network adress. I have internet 
access until i use tcpdump, ethereal or snort ... because when i do this then 
something seems to crash i have no connection at all anymore. Sometimes even 
my computer completely freezes. When that happens i only can use the reset 
button for an forced reboot.  

I use: Debian (sid)

network module: de2104x

CPU: cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 908.113
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1808.79


the output of lspci -v is:

borg:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, medium devsel, latency 8
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: df000000-dfdfffff
        Prefetchable memory behind bridge: dff00000-e3ffffff
        Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/
A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b800 [size=16]
        Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at b000 [size=32]
        Capabilities: [80] Power Management version 2

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Subsystem: Asustek Computer, Inc. A7V133/A7V133-C Mainboard
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 32, IRQ 9
        I/O ports at 9400 [size=64]
        Capabilities: [dc] Power Management version 1

00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 21)
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9000 [size=128]
        Memory at de800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 
02)
        Subsystem: Promise Technology, Inc. Ultra100
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at 8800 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8000 [size=8]
        I/O ports at 7800 [size=4]
        I/O ports at 7400 [size=64]
        Memory at de000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x 
TMDS (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        I/O ports at d800 [size=256]
        Memory at df000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at dffe0000 [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2
---

i once tried to remove the module from the kernel and wanted to insert it 
again, hoping this maybe would help ;-). But this also resulted in a complete 
freeze of the system and i had to do a forced reset again.  The error-message 
from that crash was:

Oct 25 03:34:29 borg kernel: eth0: disabling interface
Oct 25 03:34:29 borg kernel: ------------[ cut here ]------------
Oct 25 03:34:29 borg kernel: kernel BUG at net/core/dev.c:2851!
Oct 25 03:34:29 borg kernel: invalid operand: 0000 [#1]
Oct 25 03:34:29 borg kernel: CPU:    0
Oct 25 03:34:30 borg dhclient: receive_packet failed on eth0: Network is down
Oct 25 03:34:30 borg kernel: EIP:    0060:[free_netdev+43/64]    Not tainted
Oct 25 03:34:30 borg kernel: EFLAGS: 00210297
Oct 25 03:34:30 borg kernel: EIP is at free_netdev+0x2b/0x40
Oct 25 03:34:30 borg kernel: eax: df96d000   ebx: dff4d000   ecx: 80005004   
edx:
 00000003
Oct 25 03:34:30 borg kernel: esi: e08485a4   edi: 00000000   ebp: c7e7a000   
esp:
 c7e7bf04
Oct 25 03:34:30 borg kernel: ds: 007b   es: 007b   ss: 0068
Oct 25 03:34:30 borg kernel: Process rmmod (pid: 4342, threadinfo=c7e7a000 
task=d
8e4d940)
Oct 25 03:34:30 borg kernel: Stack: c01f757b df96d000 dff4d054 c023afd4 
dff4d054
dff4d080 e08485f0 e08485f0
Oct 25 03:34:30 borg kernel:        c023b000 dff4d054 e08485a4 c036d658 
c023b22d
e08485a4 e08485a4 c036d658
Oct 25 03:34:30 borg kernel:        c023b643 e08485a4 e0848580 c01f7756 
e08485a4
e0848640 e08469df e0848580
Oct 25 03:34:30 borg kernel: Call Trace:
Oct 25 03:34:30 borg kernel:  [pci_device_remove+59/64] pci_device_remove
+0x3b/0x
40
Oct 25 03:34:30 borg kernel:  [device_release_driver+100/112] 
device_release_driv
er+0x64/0x70
Oct 25 03:34:30 borg kernel:  [driver_detach+32/48] driver_detach+0x20/0x30
Oct 25 03:34:30 borg kernel:  [bus_remove_driver+61/128] bus_remove_driver
+0x3d/0
x80
Oct 25 03:34:30 borg kernel:  [driver_unregister+19/40] driver_unregister
+0x13/0x
28
Oct 25 03:34:30 borg kernel:  [pci_unregister_driver+22/48] 
pci_unregister_driver
+0x16/0x30
Oct 25 03:34:30 borg kernel:  [_end+541184727/1069369592] de_exit+0xf/0x13 
[de210
4x]
Oct 25 03:34:30 borg kernel:  [sys_delete_module+283/320] sys_delete_module
+0x11b
/0x140
Oct 25 03:34:30 borg kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
Oct 25 03:34:30 borg kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 25 03:34:30 borg kernel:
Oct 25 03:34:30 borg kernel: Code: 0f 0b 23 0b 01 2f 35 c0 eb de e9 f6 d4 e7 
ff 8
d b6 00 00 00
---



... 
 
Richard.

