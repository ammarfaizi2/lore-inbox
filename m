Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271344AbRHUNCW>; Tue, 21 Aug 2001 09:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRHUNCN>; Tue, 21 Aug 2001 09:02:13 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:24986 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S271344AbRHUNB6>; Tue, 21 Aug 2001 09:01:58 -0400
Date: Tue, 21 Aug 2001 15:02:12 +0200
From: Philip Van Hoof <freax@pandora.be>
To: Philip Van Hoof <freax@pandora.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with SMP on most kernels (apic and "stuck on TLB IPI wait"-error)
Message-ID: <20010821150212.A879@pluisje.pandora.be>
In-Reply-To: <20010821134228.G872@pluisje.pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010821134228.G872@pluisje.pandora.be>; from freax@pandora.be on Tue, Aug 21, 2001 at 13:42:28 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solution for the APIC problems on ASUS CUV4X-D with VIA 694XDP Chipset

* Turn MPS 1.4 support off in your BIOS (and upgrade bios to 1007)

1. URL's

1.1 Information about the motherboard
http://www.asus.com.tw/products/Motherboard/Pentiumpro/Cuv4x-d/index.html

1.2 The BIOS upgrade (1004 to 1007)
http://www.asus.com.tw/products/Motherboard/bios_s370.html#cuv4x-d

1.3 Message in kernel list about MPS 1.4 support in BIOS
http://uwsg.iu.edu/hypermail/linux/kernel/0106.0/0233.html
  * Thanks to Paul Fl. for this url


2. Current hardware config

2.1 MoBo
ASUS CUV4X-D with VIA 694XDP Chipset

2.2 CPU's
[root@pluisje /root]# cat /proc/cpuinfo              
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.542
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
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2005.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.542
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
mca cmov pat pse36 mmx fxsr sse
bogomips        : 2005.40
[root@pluisje /root]# 

2.3 Other
[root@pluisje /root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:      53593      53774    IO-APIC-edge  timer
  1:       2614       2622    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 10:      44433      44659   IO-APIC-level  EMU10K1
 11:        812        800   IO-APIC-level  eth0
 12:      34013      34226    IO-APIC-edge  PS/2 Mouse
 14:       3232       3422    IO-APIC-edge  ide0
 15:          1          4    IO-APIC-edge  ide1
NMI:          0          0 
LOC:     107282     107280 
ERR:          0
MIS:          0
[root@pluisje /root]# 
[root@pluisje /root]# cat /proc/ioports 
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b000-b03f : 3Com Corporation 3c900 10BaseT [Boomerang]
  b000-b03f : eth0
b400-b407 : Creative Labs SB Live!
b800-b81f : Creative Labs SB Live! EMU10000
  b800-b81f : EMU10K1
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
[root@pluisje /root]# 
[root@pluisje /root]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  525496320 148905984 376590336  1441792  7163904 108326912
Swap: 213815296 31535104 182280192
MemTotal:       513180 kB
MemFree:        367764 kB
MemShared:        1408 kB
Buffers:          6996 kB
Cached:         105788 kB
Active:          36872 kB
Inact_dirty:     77320 kB
Inact_clean:         0 kB
Inact_target:       40 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513180 kB
LowFree:        367764 kB
SwapTotal:      208804 kB
SwapFree:       178008 kB
[root@pluisje /root]# 

3. LILO

image=/boot/vmlinuz-2.4.5-8mdksmp
        label=linux-245mdkSMP
        root=/dev/hdb7
        read-only
# 	In BIOS : Set MPS 1.4 Support OFF !! else use noapic
#       append="noapic"



