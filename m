Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbRHULms>; Tue, 21 Aug 2001 07:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHULma>; Tue, 21 Aug 2001 07:42:30 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:43975 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S268899AbRHULmT>; Tue, 21 Aug 2001 07:42:19 -0400
Date: Tue, 21 Aug 2001 13:42:28 +0200
From: Philip Van Hoof <freax@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: Problems with SMP on most kernels (apic and "stuck on TLB IPI wait"-error)
Message-ID: <20010821134228.G872@pluisje.pandora.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I am pretty new with SMP (just bought the computer a few weeks
ago) but I already ran into some serious problems while using
Linux. The cpu's have been tested by the person who sold the
computer to me in W1n2k (I've seen the tests so the hardware 
works I belive). However .. Under Linux I get some failing 
results :( -I removed the installation of win2k so I can't
repeat any tests on win2k-

I am running all my kernels with "noapic" because
there is noway that I can get a kernel to boot with apic.
the 2.4.x series just hang after the APIC tests and the
2.2.19 hangs while detecting my hdc device (DVD player).

Besides that I also get these errors :
(At the moment of these errors I was using 2.2.19)

Aug 21 11:44:01 pluisje kernel: stuck on TLB IPI wait (CPU#3) 
Aug 21 11:47:00 pluisje last message repeated 2 times
Aug 21 11:48:03 pluisje last message repeated 14 times
Aug 21 11:52:52 pluisje kernel: stuck on TLB IPI wait (CPU#3) 
Aug 21 11:55:32 pluisje last message repeated 3 times
Aug 21 11:58:47 pluisje kernel: stuck on TLB IPI wait (CPU#3) 
Aug 21 12:00:45 pluisje kernel: stuck on TLB IPI wait (CPU#3) 

Each time they occur the computer hangs for +- 10 seconds
I've also noticed that it happens more frequently (but not only)
while playing mp3s (xmms). 

(note. I only have 2 cpu's named 0 and 1 on 2.4.x and
named 0 and 3 on 2.2.19. I don't know why 2.2.x gives
the 2e cpu a different name then 2.4.x does)

On 2.4.x kernels I am having problems when trying to switch
from a console to an X screen; Using a kernel with SMP
support : everything hangs (no tcp/ip to). My temporary
display hardware : S3 Virge (4mb) and a voodoo2.

When I boot a kernel with no SMP support and/or replace 
the second CPU with my dummy CPU then I don't have
any problems at all (except of course a slower system)

My hardware :

Asus CUV4X-D Motherboard
 http://www.asus.com.tw/products/Motherboard/Pentiumpro/Cuv4x-d/index.html
2 x Pentium 3 Coppermine 1000Mhz 
512 Mbram

ps. Some other very wierd things happen when switching kernels :)
follow this (and check the processor ID's on both kernels ! -> wierd) :


First info (on 2.2.19) :

[root@pluisje linux]# uname -a
Linux pluisje 2.2.19-15mdksmp #1 SMP Thu May 24 00:43:43 CEST 2001 i686
unknown
[root@pluisje linux]# 

[root@pluisje linux]# cat /proc/cpuinfo 
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
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr xmm
bogomips        : 2005.40

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.542
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr xmm
bogomips        : 2005.40

[root@pluisje linux]# 


[root@pluisje linux]# cat /proc/interrupts 
           CPU0       CPU1       
  0:     234114          0          XT-PIC  timer
  1:       3979          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0          XT-PIC  rtc
 10:      39310          0          XT-PIC  EMU10K1
 11:      11233          0          XT-PIC  eth0
 12:     119783          0          XT-PIC  PS/2 Mouse
 13:          1          0          XT-PIC  fpu
 14:      10577          0          XT-PIC  ide0
 15:          6          0          XT-PIC  ide1
NMI:          0
ERR:          0
[root@pluisje linux]# 


[root@pluisje linux]# cat /proc/ioports    
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
b000-b03f : eth0
b800-b81f : EMU10K1
d800-d807 : ide0
d808-d80f : ide1
[root@pluisje linux]# 

[root@pluisje linux]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  536416256 183689216 352727040        0 20803584 74801152
Swap: 213815296        0 213815296
MemTotal:    523844 kB
MemFree:     344460 kB
MemShared:        0 kB
Buffers:      20316 kB
Cached:       73048 kB
BigTotal:         0 kB
BigFree:          0 kB
SwapTotal:   208804 kB
SwapFree:    208804 kB
[root@pluisje linux]# 



Second info (on 2.4.5) :


[root@pluisje /root]# uname -a
Linux pluisje 2.4.5-8mdksmp #1 SMP Fri Jun 22 16:50:25 CEST 2001 i686
unknown
[root@pluisje /root]# 

[root@pluisje /root]# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.539
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
mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 2005.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1004.539
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
mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 2005.40

[root@pluisje /root]# 

[root@pluisje /root]# cat /proc/interrupts 
           CPU0       CPU1       
  0:      20754          0          XT-PIC  timer
  1:       1292          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0          XT-PIC  rtc
 10:      11393          0          XT-PIC  EMU10K1
 11:        499          0          XT-PIC  eth0
 12:      10037          0          XT-PIC  PS/2 Mouse
 14:       4947          0          XT-PIC  ide0
 15:          4          0          XT-PIC  ide1
NMI:          0          0 
LOC:      20682      20681 
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
Mem:  525496320 90951680 434544640  1146880  6447104 41586688
Swap: 213815296   667648 213147648
MemTotal:       513180 kB
MemFree:        424360 kB
MemShared:        1120 kB
Buffers:          6296 kB
Cached:          40612 kB
Active:          41168 kB
Inact_dirty:      6860 kB
Inact_clean:         0 kB
Inact_target:      320 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513180 kB
LowFree:        424360 kB
SwapTotal:      208804 kB
SwapFree:       208152 kB
[root@pluisje /root]# 


My lilo.conf :


image=/boot/bzImage-2.4.7
# problems when switching console to X
        label=linux-247
        root=/dev/hdb7
        read-only
# with apic : hangs on APIC stuff .. I think here :
# Using local APIC timer interrupts.
# calibrating APIC timer ...
# ..... CPU clock speed is 1004.5642 MHz.
# ..... host bus clock speed is 133.9417 MHz.
# cpu: 0, clocks: 1339417, slice: 446472
        append="noapic"

image=/boot/vmlinuz-2.4.5-8mdksmp
# problems when switching console to X
        label=linux-245mdkSMP
        root=/dev/hdb7
        read-only
# with apic : hangs on APIC stuff .. I think here :
# Using local APIC timer interrupts.
# calibrating APIC timer ...
# ..... CPU clock speed is 1004.5642 MHz.
# ..... host bus clock speed is 133.9417 MHz.
# cpu: 0, clocks: 1339417, slice: 446472
        append="noapic"

image=/boot/vmlinuz-2.2.19-15mdksmp
# Wierd CPU ID's .. 0 and 3
# stuck on TLB IPI wait (CPU#3) 
        label=linux
        root=/dev/hdb7
        read-only
# with apic : hangs on detecting hdc
# hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 011, ATAPI CD/DVD-ROM drive
        append="noapic"

image=/boot/vmlinuz
# No problems at all
        label=linux-singlecpu
        root=/dev/hdb7
        vga=794
        read-only

image=/boot/vmlinuz
# No problems at all
        label=failsafe
        root=/dev/hdb7
        append=" failsafe"
        read-only




-- 
Philip van Hoof aka freax (http://www.freax.eu.org)
irc: irc.openprojects.net mailto:freax @ pandora.be


