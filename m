Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWHOO1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWHOO1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWHOO1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:27:31 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:48779 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1030301AbWHOO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:27:30 -0400
Message-ID: <44E1D9CA.30805@uni-hd.de>
Date: Tue, 15 Aug 2006 16:27:22 +0200
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at <bad filename>:50307!
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I got this bug (see below) in my logs, the system showed with "top" an
increasing load average of 11 and more but with an cpu-idle of 99% and
no processes used mentionable resources, there were 6 zombies. A
shutdown was not possible most of the samba processes  didn't respond to
a kill.
Before the exception the server was -as usual- under heavy load of samba
processes 4-5 clients, with many automated activity (batch-processes
with image processing).

What does this bug mean?

Hardware-Details:
* Device sdc (on an easy-raid system) has an XFS Filesystem.
* uname -a
Linux pers109 2.6.17.8 #1 SMP Mon Aug 7 11:04:08 CEST 2006 i686 i686
i386 GNU/Linux
* lspci
0000:00:00.0 Host bridge: Intel Corporation E7501 Memory Controller Hub
(rev 01)
0000:00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B
PCI-to-PCI Bridge (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1)
(rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2)
(rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3)
(rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
0000:00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface
Controller (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage
Controller (rev 02)
0000:01:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 04)
0000:01:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
0000:01:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
(rev 04)
0000:02:05.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:02:05.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
0000:03:03.0 Ethernet controller: Intel Corporation 82544GC Gigabit
Ethernet Controller (LOM) (rev 02)
0000:04:01.0 Ethernet controller: Intel Corporation 82540EM Gigabit
Ethernet Controller (rev 02)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
===

cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 1595.130
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
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
bogomips        : 3193.91
===


/usr/local/samba/sbin/smbd -V
Version 3.0.20

_________________________
/var/log/messages extract
--------------------------


Aug 15 15:01:02 pers109 kernel: Access to block zero: fs: <sdc1> inode:
254474718 start_block : 0 start_off : c0a0b0e8a099
0 blkcnt : 90000 extent-state : 0
Aug 15 15:01:02 pers109 kernel: ------------[ cut here ]------------
Aug 15 15:01:02 pers109 kernel: kernel BUG at <bad filename>:50307!
Aug 15 15:01:02 pers109 kernel: invalid opcode: 0000 [#1]
Aug 15 15:01:02 pers109 kernel: SMP
Aug 15 15:01:02 pers109 kernel: CPU:    0
Aug 15 15:01:02 pers109 kernel: EIP:    0060:[<c0257d64>]    Not tainted VLI
Aug 15 15:01:02 pers109 kernel: EFLAGS: 00010246   (2.6.17.8 #1)
Aug 15 15:01:02 pers109 kernel: eax: c0479f84   ebx: c0436464   ecx:
c046c9bc   edx: 00000282
Aug 15 15:01:02 pers109 kernel: esi: cea51cb0   edi: c0526120   ebp:
00000000   esp: cea51b70
Aug 15 15:01:02 pers109 kernel: ds: 007b   es: 007b   ss: 0068
Aug 15 15:01:02 pers109 kernel: Process smbd (pid: 18095,
threadinfo=cea50000 task=c212e0b0)
Aug 15 15:01:02 pers109 kernel: Stack: c04452ac c042855c c0526120
00000282 f7204db0 cea51cb0 00000000 e31d5b00
Aug 15 15:01:02 pers109 kernel:        c01fe13d 00000000 c0436464
c49083e0 0f2af9de 00000000 00000000 00000000
Aug 15 15:01:02 pers109 kernel:        0e8a0990 000c0a0b 00090000
00000000 00000000 cea51cb0 00000000 00000000
Aug 15 15:01:02 pers109 kernel: Call Trace:
Aug 15 15:01:02 pers109 kernel:  <c01fe13d>   <c01ff637>
Aug 15 15:01:02 pers109 kernel:  <c0115e51>   <c0115e51>
Aug 15 15:01:02 pers109 kernel:  <c015987b>   <c015a791>
Aug 15 15:01:03 pers109 kernel:  <c0140a91>   <c0254ff3>
Aug 15 15:01:03 pers109 kernel:  <c039c7d2>   <c017187e>
Aug 15 15:01:03 pers109 kernel:  <c0255653>   <c0395c89>
Aug 15 15:01:03 pers109 kernel:  <c01696c8>   <c0288a3a>
Aug 15 15:01:03 pers109 kernel:  <c025091f>   <c0157383>
Aug 15 15:01:03 pers109 kernel:  <c012d613>   <c01574a9>
Aug 15 15:01:03 pers109 kernel:  <c015774e>   <c01027df>
Aug 15 15:01:03 pers109 kernel: Code: c0 c7 44 24 08 20 61 52 c0 c7 04
24 ac 52 44 c0 89 44 24 04 e8 5b 34 ec ff b8 84 9f
47 c0 8b 54 24 0c e8 bc fa 1a 00 85 ed 75 02 <0f> 0b 83 c4 10 5b 5e 5f
5d c3 55 b8 07 00 00 00 57 bf 20 61 52
Aug 15 15:01:03 pers109 kernel: EIP: [<c0257d64>]  SS:ESP 0068:cea51b70


thanks in advance,
martin


