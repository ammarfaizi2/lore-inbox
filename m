Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUECP3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUECP3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUECP3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:29:40 -0400
Received: from smtp.wp.pl ([212.77.101.160]:39757 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263741AbUECP3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:29:31 -0400
From: "Karol 'grzywacz' Nowak" <novaki@poczta.wp.pl>
Reply-To: grzywacz@kolos.math.uni.lodz.pl
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG @ slab.c:815 (USB?)
Date: Mon, 3 May 2004 17:29:28 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405031729.28570.novaki@poczta.wp.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A. [wersja 2.0c]
X-WP-AntySpam-Rezultat: NIE-SPAM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've noticed a bug in my friend's logs that you might be interested in. I've 
managed to recreate it simply by running 'modprobe uhci'. Looks like it may be 
quite serious as the machine froze after some time. Kernel (version 2.4.26) 
has been compiled with: 
	gcc - 3.3.3 (Debian 20040429)
	binutils - 2.14.90.0.7 20031029 Debian GNU/Linux
the output of ksymoops is as follows:


ksymoops 2.4.9 on i686 2.4.26.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.26/ (default)
     -m /boot/System.map-2.4.26 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.26 failed
ksymoops: No such file or directory
cpu: 0, clocks: 1989390, slice: 994695
8139too Fast Ethernet driver 0.9.26
ac97_codec: AC97  codec, id: ALG96 (Unknown)
kernel BUG at slab.c:815!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01305fb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c12c6ae0   ecx: c12c670c   edx: c12c6778
esi: c12c6772   edi: d086428f   ebp: c12c6ad8   esp: cc6bdecc
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 672, stackpage=cc6bd000)
Stack: 00000000 0000003c 00000000 cc6bdee4 c12c6b00 fffffffc 00000038 fffffff4 
       00000000 00000000 ffffffea d0863d30 d0864281 0000003c 00000040 00000000 
       00000000 00000000 d085f000 c011a9ca d085f060 08085318 0000629c 00000000 
Call Trace:    [<d0863d30>] [<d0864281>] [<c011a9ca>] [<d085f060>] 
[<d085f060>]
  [<c010720b>]
Code: 0f 0b 2f 03 71 64 29 c0 8b 01 89 ca 89 c1 0f 0d 00 81 fa e4


>>EIP; c01305fb <kmem_cache_create+2cb/440>   <=====

>>ebx; c12c6ae0 <_end+f563e0/104d2980>
>>ecx; c12c670c <_end+f5600c/104d2980>
>>edx; c12c6778 <_end+f56078/104d2980>
>>esi; c12c6772 <_end+f56072/104d2980>
>>edi; d086428f <[uhci].text.end+3f0/11a1>
>>ebp; c12c6ad8 <_end+f563d8/104d2980>
>>esp; cc6bdecc <_end+c34d7cc/104d2980>

Trace; d0863d30 <[uhci]uhci_hcd_init+a0/140>
Trace; d0864281 <[uhci].text.end+3e2/11a1>
Trace; c011a9ca <inter_module_put+75a/8e0>
Trace; d085f060 <[hpusbscsi]hpusbscsi_devices+1524/1544>
Trace; d085f060 <[hpusbscsi]hpusbscsi_devices+1524/1544>
Trace; c010720b <__up_wakeup+122b/15f0>

Code;  c01305fb <kmem_cache_create+2cb/440>
00000000 <_EIP>:
Code;  c01305fb <kmem_cache_create+2cb/440>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01305fd <kmem_cache_create+2cd/440>
   2:   2f                        das    
Code;  c01305fe <kmem_cache_create+2ce/440>
   3:   03 71 64                  add    0x64(%ecx),%esi
Code;  c0130601 <kmem_cache_create+2d1/440>
   6:   29 c0                     sub    %eax,%eax
Code;  c0130603 <kmem_cache_create+2d3/440>
   8:   8b 01                     mov    (%ecx),%eax
Code;  c0130605 <kmem_cache_create+2d5/440>
   a:   89 ca                     mov    %ecx,%edx
Code;  c0130607 <kmem_cache_create+2d7/440>
   c:   89 c1                     mov    %eax,%ecx
Code;  c0130609 <kmem_cache_create+2d9/440>
   e:   0f 0d 00                  prefetch (%eax)
Code;  c013060c <kmem_cache_create+2dc/440>
  11:   81 fa e4 00 00 00         cmp    $0xe4,%edx


It was run a few minutes after bug's occurence so it should be accurate. At 
the moment running lsmod returns:

Module                  Size  Used by    Not tainted
uhci                   25340   1  (initializing)
hpusbscsi               6980   0  (unused)
sd_mod                 10988   0  (unused)
st                     28824   0  (unused)
usb-ohci               19016   0  (unused)


The only device attached at that time was a digital camera. The rest of the 
hardware is:

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm) processor
stepping        : 0
cpu MHz         : 994.690
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 1985.74

# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(
rev c1)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] AGP version 2.0
        Capabilities: [60] #08 [2001]

0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev 
c1
)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Flags: 66MHz, fast devsel

0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev 
c1
)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Flags: 66MHz, fast devsel

0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev 
c1
)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Flags: 66MHz, fast devsel

0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev 
c1
)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Flags: 66MHz, fast devsel

0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev 
c1
)
        Subsystem: nVidia Corporation: Unknown device 0c17
        Flags: 66MHz, fast devsel

0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
        Subsystem: Giga-byte Technology: Unknown device 0c11
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [48] #08 [01e1]

0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: Giga-byte Technology: Unknown device 0c11
        Flags: 66MHz, fast devsel, IRQ 10
        I/O ports at e400 [size=32]
        Capabilities: [44] Power Management version 2

0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
 (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at ef003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
 (prog-if 10 [OHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 9
        Memory at ef004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4)
 (prog-if 20 [EHCI])
        Subsystem: Giga-byte Technology: Unknown device 5004
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at ef005000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio
 Controler (MCP) (rev a1)
        Subsystem: Giga-byte Technology: Unknown device a002
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 12
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at ef001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev 
a3
) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ee000000-eeffffff

0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 
8a
 [Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 5002
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2

0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 
[N
ormal decode])
        Flags: bus master, 66MHz, medium devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        Memory behind bridge: ec000000-edffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139
C/8139C+ (rev 10)
        Subsystem: Giga-byte Technology GA-7VM400M Motherboard
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at c000 [size=256]
        Memory at ee000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:02:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX
 400] (rev b2) (prog-if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 19
        Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


That's all I've managed to come up with. Should any additional information be 
required, I'll be glad to provide it. :)

-- 
pozdrawiam
Karol 'grzywacz' Nowak
->    Jabber: grzyw@jabber.org
->    http://kolos.math.uni.lodz.pl/~grzywacz/

