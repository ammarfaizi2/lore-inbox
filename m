Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbSKQV70>; Sun, 17 Nov 2002 16:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSKQV70>; Sun, 17 Nov 2002 16:59:26 -0500
Received: from pq204.wroclaw.sdi.tpnet.pl ([217.98.138.204]:10368 "EHLO
	tavaiah") by vger.kernel.org with ESMTP id <S266961AbSKQV7W>;
	Sun, 17 Nov 2002 16:59:22 -0500
Date: Sun, 17 Nov 2002 23:03:38 +0100
From: Tomasz Wegrzanowski <taw@users.sf.net>
To: linux-kernel@vger.kernel.org
Subject: Lot of kswapd and other oopses
Message-ID: <20021117220337.GA782@tavaiah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem appear with kernels 2.4.18 2.18.19 and 2.4.20-rc1
(I also tried 2.5.2-dj, and it happens with it too)

I'm getting a lot of oopses that look like this:

Unable to handle kernel NULL pointer dereference at virtual address 00000130
 printing eip:
c012674e
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012674e>]    Tainted: P
EFLAGS: 00010206
eax: 00000100   ebx: cca1d8c0   ecx: c1157200   edx: c1465768
esi: c1157200   edi: 00000008   ebp: 000001fd   esp: c1433f4c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1433000)
Stack: c012d00e c1157200 00000020 000001d0 00000020 00000006 00000006 c1432000
       000013ce 000001d0 c026b548 c012d196 00000006 0000000e 00000006 000001d0
       c026b548 00000000 c026b548 c012d20c 00000020 c026b548 00000001 c1432000
Call Trace: [<c012d00e>] [<c012d196>] [<c012d20c>] [<c012d2a3>] [<c012d306>]
   [<c012d41d>] [<c0106f68>]

Code: 89 50 30 89 02 c7 41 30 00 00 00 00 ff 0d 40 b2 26 c0 c3 eb



Or this:

kernel BUG at page_alloc.c:102!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c2f4>]    Not tainted
EFLAGS: 00010206
eax: 01000000   ebx: c1077208   ecx: c1077208   edx: 00000000
esi: 00000000   edi: c2b51008   ebp: ce033f74   esp: ce033ef4
ds: 0018   es: 0018   ss: 0018
Process gpm (pid: 356, stackpage=ce033000)
Stack: c2b51008 00000000 c2b51008 ce033f74 cafa6000 cfe94e00 00000000 00000246 
       ce033f2c c01130a0 ce033f2c c2b51008 c2b51000 c012cb5b c012cb7a c013f65a 
       00000000 ce7e2bc0 00000001 c013f978 ce033f6c 00000004 00000001 c5d7c718 
Call Trace:    [<c01130a0>] [<c012cb5b>] [<c012cb7a>] [<c013f65a>] [<c013f978>]
  [<c013fcea>] [<c0106cef>]

Code: 0f 0b 66 00 d3 14 21 c0 89 d8 2b 05 d0 c4 29 c0 69 c0 a3 8b 
 kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c2e6>]    Not tainted
EFLAGS: 00010206
eax: c10ab6d4   ebx: c10ab1e8   ecx: c10ab204   edx: c10aa6ac
esi: 00000000   edi: c3e46ff8   ebp: c03f6000   esp: c3e51ee8
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 690, stackpage=c3e51000)
Stack: c10ab1e8 00008000 c3e46ff8 c03f6000 0000eff0 c10aad9c c02482f4 c102c01c 
       c024833c 00000213 fffffff0 00002e20 00000171 c012cb5b c012cf53 c10ab1e8 
       c0122470 c10ab1e8 0000a000 c0122893 03e39067 c3e472c0 c51d1240 bfff6000 
Call Trace:    [<c012cb5b>] [<c012cf53>] [<c0122470>] [<c0122893>] [<c0124df5>]
  [<c011463a>] [<c01187c5>] [<c01189ae>] [<c0106cef>]

Code: 0f 0b 64 00 d3 14 21 c0 83 7b 08 00 74 08 0f 0b 66 00 d3 14 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000108
 printing eip:
c0125070
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125070>]    Not tainted
EFLAGS: 00010206
eax: c104b208   ebx: 00000100   ecx: c104b208   edx: c104b208
esi: 00198000   edi: c3f7e9bc   ebp: 084d7000   esp: ce06fc74
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 781, stackpage=ce06f000)
Stack: c104b208 c012246a 001e9000 c0122893 01b51045 c4c2fec0 cfe94e00 080d7000 
       001e9000 c1966084 c1966084 084d7000 00000197 00000000 082c0000 c1966080 
       00000000 082c0000 c0124df5 cfe94e00 080d7000 001e9000 ce06e000 ce990ac0 
Call Trace:    [<c012246a>] [<c0122893>] [<c0124df5>] [<c0139324>] [<c0139485>]
  [<c014beed>] [<c014bab0>] [<c01582a1>] [<c0143ede>] [<c01399a7>] [<c0139c2c>]
  [<c0139c43>] [<c01059ff>] [<c0106cef>]

Code: 8b 43 08 89 48 04 89 01 8d 43 08 89 41 04 89 4b 08 8b 43 20 
 kernel BUG at mmap.c:1159!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0124e25>]    Not tainted
EFLAGS: 00010202
eax: cfe94e00   ebx: 00000000   ecx: cfe94e30   edx: c7e48e30
esi: cfe94e00   edi: ce06e000   ebp: 0000000b   esp: ce06fb40
ds: 0018   es: 0018   ss: 0018
Process bash (pid: 781, stackpage=ce06f000)
Stack: cfe94e00 ce06fc40 ce06e000 0000000b 00000108 c011463a cfe94e00 cfe94e00 
       c01187c5 cfe94e00 00000000 ce06fc40 00000000 00000108 c01072d6 0000000b 
       00000000 cfe94e1c c01126b7 c020f89e ce06fc40 00000000 ce06e000 00000000 
Call Trace:    [<c011463a>] [<c01187c5>] [<c01072d6>] [<c01126b7>] [<c0112360>]
  [<c015e21c>] [<c0157f1f>] [<c0157f86>] [<c01582a1>] [<c015e5be>] [<c012b495>]
  [<c0106de0>] [<c0125070>] [<c012246a>] [<c0122893>] [<c0124df5>] [<c0139324>]
  [<c0139485>] [<c014beed>] [<c014bab0>] [<c01582a1>] [<c0143ede>] [<c01399a7>]
  [<c0139c2c>] [<c0139c43>] [<c01059ff>] [<c0106cef>]

Code: 0f 0b 87 04 c1 0f 21 c0 68 00 03 00 00 6a 00 56 e8 66 d6 ff 
 


Most usually crashing process is kswapd, but it happens to other processes too.
I thought it might be related to swap but turning it off doesn't fix the problem.

Random system info:

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c815 (rev 04)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX DDR] (rev b2)
$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>    <options>                     <dump>  <pass>
/dev/sdb1       /               ext3      defaults,errors=remount-ro    0       1
/dev/sda4       none            swap      sw                            0       0
/dev/sda1       /home           reiserfs  defaults                      0       2
/dev/sda3       /mnt            ext3      defaults                      0       2
proc            /proc           proc      defaults                      0       0
/dev/fd0        /floppy         vfat      defaults,user,noauto          0       0
/dev/cdrom      /cdrom          iso9660   defaults,ro,user,noauto       0       0
/dev/hda1       /home2          ext3      defaults                      0       2
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1001.806
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1998.84
$ cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/sda4                       partition       222256  0       -1
$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  263061504 242339840 20721664        0 20692992 105631744
Swap: 227590144        0 227590144
MemTotal:       256896 kB
MemFree:         20236 kB
MemShared:           0 kB
Buffers:         20208 kB
Cached:         103156 kB
SwapCached:          0 kB
Active:          40280 kB
Inactive:       180384 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256896 kB
LowFree:         20236 kB
SwapTotal:      222256 kB
SwapFree:       222256 kB


Does anybody have any idea what could that be ?
Is anybody else having such problem ?
