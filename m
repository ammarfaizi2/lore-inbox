Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281439AbRKHE0E>; Wed, 7 Nov 2001 23:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281445AbRKHE0A>; Wed, 7 Nov 2001 23:26:00 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:9344 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S281439AbRKHEZq>; Wed, 7 Nov 2001 23:25:46 -0500
Message-Id: <200111080425.fA84Pdb04541@mysql.sashanet.com>
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org
Subject: Suspected bug - System slowdown under unexplained excessive disk I/O - 2.4.13
Date: Wed, 7 Nov 2001 21:25:38 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have experienced a condition I believe to be a bug. Below is a bug report 
in the format suggested by REPORTING-BUGS:

Summary: 

System slowdown under unexplained excessive disk I/O 

Full description: 

While running X, KDE, having a few windows open, I ran make -j4 on MySQL 
source tree. I do this all the time and it usually works just fine - the 
system is a little bit unresponsive. However, occasionally the system becomes 
completely unresponsive - the disk goes crazy, the machine pings but neither 
ssh or telnet work - connection to the port is established, but nothing 
further than that. It does respond to magic SysRQ. I was able to get a memory 
info dump + stack traces into syslog, included below. The filesystem is 
ReiserFS.

Keywords: 

vm, ReiserFS, heavy disk I/O,

Version:

Linux version 2.4.13 (sasha@mysql) (gcc version 2.95.3 20010315 (SuSE)) #3 
SMP Tue Oct 30 15:07:27 MST 2001

CPU:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.149
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
cmov
pat pse36 mmx fxsr sse
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.149
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
cmov
pat pse36 mmx fxsr sse
bogomips        : 999.42

Memory:

        total:    used:    free:  shared: buffers:  cached:
Mem:  261107712 257200128  3907584        0 37466112 80744448
Swap:        0        0        0
MemTotal:       254988 kB
MemFree:          3816 kB
MemShared:           0 kB
Buffers:         36588 kB
Cached:          78852 kB
SwapCached:          0 kB
Active:          54824 kB
Inactive:        60616 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       254988 kB
LowFree:          3816 kB
SwapTotal:           0 kB
SwapFree:            0 kB


ver_linux output:

Linux mysql 2.4.13 #3 SMP Tue Oct 30 15:07:27 MST 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.18
pcmcia-cs              3.1.17
PPP                    2.3.11
isdn4k-utils           3.1pre1a
Linux C Library        x   1 root     root      1341862 Jun 17 17:24 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.6
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         ide-scsi scanner opl3 sb uart401 midi soundbase 
sndshield

Debug info from syslog:

Nov  7 17:14:15 mysql kernel: SysRq : Show Memory
Nov  7 17:14:21 mysql kernel: Mem-info:
Nov  7 17:14:21 mysql kernel: Free pages:        4092kB (     0kB HighMem)
Nov  7 17:14:21 mysql kernel: Zone:DMA freepages:  1080kB min:   512KB low:  
1024kB high:  1536kB
Nov  7 17:14:21 mysql kernel: Zone:Normal freepages:  3012kB min:  1020KB 
low:  2040kB high:  3060kB
Nov  7 17:14:21 mysql kernel: Zone:HighMem freepages:     0kB min:     0KB 
low:     0kB high:     0kB
Nov  7 17:14:21 mysql kernel: Free pages:        4092kB (     0kB HighMem)
Nov  7 17:14:21 mysql kernel: ( Active: 1476, inactive: 377, free: 1023 )
Nov  7 17:14:21 mysql kernel: 62*4kB 16*8kB 4*16kB 2*32kB 1*64kB 0*128kB 
0*256kB 1*512kB 0*1024kB 0*2048kB = 1080kB)
Nov  7 17:14:21 mysql kernel: 297*4kB 92*8kB 4*16kB 0*32kB 0*64kB 0*128kB 
0*256kB 0*512kB 1*1024kB 0*2048kB = 3012kB)
Nov  7 17:14:21 mysql kernel: = 0kB)
Nov  7 17:14:21 mysql kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Nov  7 17:14:21 mysql kernel: Free swap:            0kB
Nov  7 17:14:22 mysql kernel: 65533 pages of RAM
Nov  7 17:14:23 mysql kernel: 0 pages of HIGHMEM
Nov  7 17:14:23 mysql kernel: 1818 reserved pages
Nov  7 17:14:24 mysql kernel: 5031 pages shared
Nov  7 17:14:24 mysql kernel: 0 pages swap cached
Nov  7 17:14:24 mysql kernel: 21 pages in page table cache
Nov  7 17:14:24 mysql kernel: Buffer memory:     1316kB
Nov  7 17:14:24 mysql kernel:     CLEAN: 4 buffers, 13 kbyte, 4 used 
(last=4), 0 locked, 0 dirty
Nov  7 17:14:24 mysql kernel: 400 22960  22959         22963       (NOTLB)
Nov  7 17:14:26 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:27 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c011c689>] [<c011c977>] 
Nov  7 17:14:27 mysql kernel:    [<c018687d>] [<c01bee66>] [<c01bee9b>] 
[<c01beeb6>] [<c01296d7>] [<c0134798>] 
Nov  7 17:14:27 mysql kernel:    [<c012c132>] [<c0124390>] [<c0189363>] 
[<c0186740>] [<c0124445>] [<c012448e>] 
Nov  7 17:14:27 mysql kernel:    [<c012556b>] [<c0122012>] [<c01220ed>] 
[<c0110604>] [<c011048c>] [<c0106397>] 
Nov  7 17:14:27 mysql kernel:    [<c010648a>] [<c01070bc>] 
Nov  7 17:14:27 mysql kernel: kde           S 00000000     0 22963  22959 
23114         22960 (NOTLB)
Nov  7 17:14:27 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:27 mysql kernel: kdeinit       S 7FFFFFFF  4268 23070      1     
    23073 10009 (NOTLB)
Nov  7 17:14:27 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:27 mysql kernel: kdeinit       S 7FFFFFFF     0 23073      1     
    23076 23070 (NOTLB)
Nov  7 17:14:27 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:27 mysql kernel: kdeinit       D 00000002     0 23076      1     
    23082 23073 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c018687d>] [<c0132cc5>] 
Nov  7 17:14:28 mysql kernel:    [<c0193ca3>] [<c019448f>] [<c01bee66>] 
[<c01bf07f>] [<c0134798>] [<c012c132>] 
Nov  7 17:14:28 mysql kernel:    [<c0124390>] [<c0189363>] [<c0186740>] 
[<c0124445>] [<c012448e>] [<c012556b>] 
Nov  7 17:14:28 mysql kernel:    [<c0122012>] [<c01220ed>] [<c0110604>] 
[<c011048c>] [<c01432a9>] [<c013aefd>] 
Nov  7 17:14:28 mysql kernel:    [<c0138ac8>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23082      1     
    23102 23076 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: artsd         D 00000002    12 23101      1     
    23113 23102 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c018687d>] [<c0132cc5>] 
Nov  7 17:14:28 mysql kernel:    [<c0193ca3>] [<c019448f>] [<c01bee66>] 
[<c0134798>] [<c012c132>] [<c0124390>] 
Nov  7 17:14:28 mysql kernel:    [<c0189363>] [<c0186740>] [<c0124445>] 
[<c012448e>] [<c012556b>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c01432a9>] [<c013aefd>] [<c0138b38>] 
Nov  7 17:14:28 mysql kernel:    [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23102      1  
8954   23101 23082 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: knotify       S 7FFFFFFF  2400 23113      1     
    23122 23101 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: ksmserver     S 7FFFFFFF     0 23114  22963     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       D 00000002     0 23115  23102 
23120   23136       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c01f5ac1>] [<c018687d>] 
Nov  7 17:14:28 mysql kernel:    [<c01bec1c>] [<c01bec2e>] [<c01bee66>] 
[<c01bee9b>] [<c01beeb6>] [<c01296d7>] 
Nov  7 17:14:28 mysql kernel:    [<c0134798>] [<c012c132>] [<c0124390>] 
[<c0189363>] [<c0186740>] [<c0124445>] 
Nov  7 17:14:28 mysql kernel:    [<c012448e>] [<c012556b>] [<c0122012>] 
[<c01220ed>] [<c0110604>] [<c011048c>] 
Nov  7 17:14:28 mysql kernel:    [<c022fb6e>] [<c0117c99>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: xemacs        S C6637F2C  2400 23116  23115     
    23118       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: xemacs        S CFE05F2C     0 23118  23115     
    23119 23116 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: xemacs        S C9695F2C     0 23119  23115     
    23120 23118 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: xemacs        S CE7B1F2C     0 23120  23115     
          23119 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF  2400 23122      1 
23125   23124 23113 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c01ab604>] 
[<c01aa03f>] [<c0110f67>] [<c013fc1e>] 
Nov  7 17:14:28 mysql kernel:    [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23124      1 
23131   23127 23122 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: cat           S 7FFFFFFF     0 23125  23122     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       D 00000002    24 23127      1     
    23134 23124 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c01f1ae5>] [<c01f1300>] 
Nov  7 17:14:28 mysql kernel:    [<c01f1948>] [<c018687d>] [<c01edcdd>] 
[<c01ee1f2>] [<c01f1300>] [<c01bee66>] 
Nov  7 17:14:28 mysql kernel:    [<c0134798>] [<c012c132>] [<c0124390>] 
[<c0189363>] [<c0186740>] [<c0124445>] 
Nov  7 17:14:28 mysql kernel:    [<c012448e>] [<c012556b>] [<c0122012>] 
[<c01220ed>] [<c0110604>] [<c011048c>] 
Nov  7 17:14:28 mysql kernel:    [<c01ee1f2>] [<c011b794>] [<c010ef9d>] 
[<c01070bc>] 
Nov  7 17:14:28 mysql kernel: wishx         S 7FFFFFFF     0 23131  23124     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23134      1     
    23140 23127 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       D 00000002     0 23136  23102 
23210   23138 23115 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c01f1ae5>] [<c01f1300>] 
Nov  7 17:14:28 mysql kernel:    [<c01f1948>] [<c018687d>] [<c01ee1f2>] 
[<c01bec1c>] [<c01bec2e>] [<c01bee66>] 
Nov  7 17:14:28 mysql kernel:    [<c01bf07f>] [<c01296d7>] [<c0134798>] 
[<c012c132>] [<c0124390>] [<c0189363>] 
Nov  7 17:14:28 mysql kernel:    [<c0186740>] [<c0124445>] [<c012448e>] 
[<c012556b>] [<c0122012>] [<c01220ed>] 
Nov  7 17:14:28 mysql kernel:    [<c0110604>] [<c011048c>] [<c022fb6e>] 
[<c0131de4>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF  2404 23138  23102 
23149    8332 23136 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c01ab604>] 
[<c0110f67>] [<c013fc1e>] [<c013ffc0>] 
Nov  7 17:14:28 mysql kernel:    [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: alarmd        S 7FFFFFFF     0 23140      1     
    23231 23134 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF  2404 23141  23138     
    23145       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 00000000     0 23142  23136  
6206   23148       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01a6d57>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF  5104 23145  23138     
    23149 23141 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF     0 23148  23136     
    23150 23142 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF     0 23149  23138     
          23145 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 00000000     0 23150  23136 
23359   23156 23148 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01a6d57>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF     0 23156  23136 
31898   23162 23150 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 00000000     0 23162  23136   
652   23184 23156 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01a6d57>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF     0 23184  23136     
    23210 23162 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF  2404 23210  23136     
          23184 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kmail         R 00000000  1312 23231      1     
    23248 23140 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0124390>] [<c01245b5>] 
[<c01245f3>] [<c012559c>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c022fb6e>] [<c0131de4>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23248      1     
    23259 23231 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     0 23259      1     
    23277 23248 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdesud        D 00000000     0 23277      1     
      702 23259 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0124390>] [<c01245b5>] 
[<c01245f3>] [<c012559c>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c012c312>] [<c013fc7a>] [<c01400ef>] 
Nov  7 17:14:28 mysql kernel:    [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: xemacs        S C47B9F2C     0 23559  23162     
      652       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: xemacs        S C6DF9F2C     0 31898  23156     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: ssh           S 7FFFFFFF     0  6206  23142     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01ab604>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysql-test-ru S 00000000     0   652  23162   
739         23559 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c011d7e7>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqlmanager  S 7FFFFFFF     0   702      1   
704    8409 23277 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c025386a>] [<c0110f67>] 
[<c024c4d2>] [<c024c659>] [<c0263d24>] 
Nov  7 17:14:28 mysql kernel:    [<c0230626>] [<c0106397>] [<c023107c>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqlmanager  S CF78A000     0   703    702   
726     704       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013a07d>] [<c013a154>] 
[<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqlmanager  D 00000000     0   704    702   
740           703 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0124390>] [<c01245b5>] 
[<c01245f3>] [<c012559c>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c012c2f4>] [<c012c312>] [<c013f91a>] 
Nov  7 17:14:28 mysql kernel:    [<c0140534>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: mysqlmanager  S CD79FFB0    28   705    704     
      740       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013a275>] [<c0106143>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C78ABFB0  1624   711    703   
712     726       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S CE209F28     0   712    711   
720               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110fca>] 
[<c0110ef4>] [<c014023f>] [<c014043d>] 
Nov  7 17:14:28 mysql kernel:    [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C9FF9FB0     0   713    712     
      714       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C3E69FB0     0   714    712     
      715   713 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C5B8FFB0     0   715    712     
      716   714 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S CE94BFB0     0   716    712     
      717   715 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S CEB1DFB0  6128   717    712     
      718   716 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01400ef>] [<c0106143>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S CA615F2C  5016   718    712     
      719   717 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C723DFB0  5544   719    712     
      720   718 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C6579FB0  4532   720    712     
            719 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S 7FFFFFFF  4888   726    703   
727           711 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S C902FF28  4728   727    726   
729               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110fca>] 
[<c0110ef4>] [<c014023f>] [<c014043d>] 
Nov  7 17:14:28 mysql kernel:    [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S CD601FB0  4532   728    727     
      729       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0106143>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqld        S 7FFFFFFF  4332   729    727     
            728 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c019bcd7>] 
[<c0277167>] [<c0277358>] [<c022fa61>] 
Nov  7 17:14:28 mysql kernel:    [<c022fb6e>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqlmanagerc S 7FFFFFFF  4532   739    652     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0232cbc>] [<c0110f67>] 
[<c024abe2>] [<c024b22f>] [<c0263f65>] 
Nov  7 17:14:28 mysql kernel:    [<c022fa61>] [<c022fb6e>] [<c0131db7>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: mysqlmanager  S 7FFFFFFF  5056   740    704     
            705 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c0277167>] 
[<c0277358>] [<c022fa61>] [<c022fb6e>] 
Nov  7 17:14:28 mysql kernel:    [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: compile-penti S 00000000     0 23359  23150  
1149               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gmake         S 00000000     4  1149  23359  
1789               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gmake         S 00000000     0  1789   1149  
1790               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000   324  1790   1789 
10738               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c011d7e7>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S C68C9F2C     4  8332  23102     
     8944 23138 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S 7FFFFFFF     4  8409      1  
8644           702 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013f9ac>] [<c0110f67>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: bash          S 7FFFFFFF     4  8644   8409     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110f67>] [<c01a996e>] 
[<c01a56ca>] [<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S C8F01F2C     0  8944  23102     
     8952  8332 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S CB2EBF2C     0  8952  23102     
     8954  8944 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: kdeinit       S CF7BFF2C     0  8954  23102     
           8952 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0110fca>] [<c0110ef4>] 
[<c013fc1e>] [<c013ffc0>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000     0 10738   1790 
10739               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c011d7e7>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gmake         S 00000000  2400 10739  10738 
10742               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000     0 10742  10739 
10748               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c011d7e7>] [<c01175a5>] 
[<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gmake         S C55F6000     0 10748  10742 
11201               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c013a07d>] [<c013a154>] 
[<c0131db7>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gcc           S 00000000     0 11163  10748 
11175   11190       (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: cc1plus       D 00000000  2064 11175  11163     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0124390>] [<c01245b5>] 
[<c01245f3>] [<c012559c>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c011b677>] [<c011b886>] [<c011147d>] 
Nov  7 17:14:28 mysql kernel:    [<c011048c>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000     8 11190  10748 
11191   11192 11163 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gcc           S 00000000     0 11191  11190 
11206               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000     0 11192  10748 
11193   11201 11190 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gcc           S 00000000     4 11193  11192 
11204               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: sh            S 00000000  2400 11201  10748 
11202         11192 (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: gcc           S 00000000  2064 11202  11201 
11205               (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01175a5>] [<c0106fcb>] 
Nov  7 17:14:28 mysql kernel: cc1plus       D 00000000  2400 11204  11193     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01245b5>] [<c01245f3>] 
[<c012559c>] [<c0122012>] [<c01220ed>] 
Nov  7 17:14:28 mysql kernel:    [<c0110604>] [<c011048c>] [<c01ee1f2>] 
[<c011b794>] [<c010ef9d>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: cc1plus       D 00000000     0 11205  11202     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c0124390>] [<c01245b5>] 
[<c01245f3>] [<c012559c>] [<c0122012>] 
Nov  7 17:14:28 mysql kernel:    [<c01220ed>] [<c0110604>] [<c011048c>] 
[<c01bbf48>] [<c011147d>] [<c011048c>] 
Nov  7 17:14:28 mysql kernel:    [<c0108866>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: cc1plus       D 00000000     0 11206  11191     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01245b5>] [<c01245f3>] 
[<c012559c>] [<c0122012>] [<c01220ed>] 
Nov  7 17:14:28 mysql kernel:    [<c0110604>] [<c011048c>] [<c01177f0>] 
[<c011bab5>] [<c01233f4>] [<c011b794>] 
Nov  7 17:14:28 mysql kernel:    [<c010ef9d>] [<c01070bc>] 
Nov  7 17:14:28 mysql kernel: sendmail      D 00000002     0 11207    307     
                (NOTLB)
Nov  7 17:14:28 mysql kernel: Call Trace: [<c01bf512>] [<c0132caf>] 
[<c0133e41>] [<c0197a25>] [<c0193d29>] 
Nov  7 17:14:28 mysql kernel:    [<c0194972>] [<c0185e65>] [<c0186049>] 
[<c0186063>] [<c018687d>] [<c01bee66>] 
Nov  7 17:14:28 mysql kernel:    [<c01296d7>] [<c0134798>] [<c012c132>] 
[<c0124390>] [<c0189363>] [<c0186740>] 
Nov  7 17:14:28 mysql kernel:    [<c0124445>] [<c012448e>] [<c012556b>] 
[<c0122012>] [<c01220ed>] [<c0110604>] 
Nov  7 17:14:28 mysql kernel:    [<c011048c>] [<c011b677>] [<c011b886>] 
[<c011b38e>] [<c01187e0>] [<c01186b9>] 
Nov  7 17:14:28 mysql kernel:    [<c011843f>] [<c010887b>] [<c01070bc>] 

Resolved with ksymoops:

>>EIP; 00002960 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c011c688 <send_sig_info+58/98>
Trace; c011c976 <send_sig+1a/20>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c01bee66 <__make_request+156/66c>
Trace; c01bee9a <__make_request+18a/66c>
Trace; c01beeb6 <__make_request+1a6/66c>
Trace; c01296d6 <kmem_cache_alloc+8a/12c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c0106396 <restore_sigcontext+116/13c>
Trace; c010648a <sys_sigreturn+ce/f8>
Trace; c01070bc <error_code+34/3c>
Proc;  kde
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c0132cc4 <__wait_on_buffer+84/94>
Trace; c0193ca2 <is_tree_node+36/4c>
Trace; c019448e <search_by_key+7d6/c10>
Trace; c01bee66 <__make_request+156/66c>
Trace; c01bf07e <__make_request+36e/66c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01432a8 <dput+18/154>
Trace; c013aefc <path_release+c/30>
Trace; c0138ac8 <sys_stat64+64/70>
Trace; c01070bc <error_code+34/3c>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  artsd
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c0132cc4 <__wait_on_buffer+84/94>
Trace; c0193ca2 <is_tree_node+36/4c>
Trace; c019448e <search_by_key+7d6/c10>
Trace; c01bee66 <__make_request+156/66c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01432a8 <dput+18/154>
Trace; c013aefc <path_release+c/30>
Trace; c0138b38 <sys_lstat64+64/70>
Trace; c01070bc <error_code+34/3c>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  knotify
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  ksmserver
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c01f5ac0 <do_rw_disk+124/328>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c01bec1c <attempt_merge+60/154>
Trace; c01bec2e <attempt_merge+72/154>
Trace; c01bee66 <__make_request+156/66c>
Trace; c01bee9a <__make_request+18a/66c>
Trace; c01beeb6 <__make_request+1a6/66c>
Trace; c01296d6 <kmem_cache_alloc+8a/12c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0117c98 <sys_gettimeofday+20/134>
Trace; c01070bc <error_code+34/3c>
Proc;  xemacs
>>EIP; c6637f2c <_end+626d4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  xemacs
>>EIP; cfe05f2c <_end+fa3b4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  xemacs
>>EIP; c9695f2c <_end+92cb4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  xemacs
>>EIP; ce7b1f2c <_end+e3e74b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c01ab604 <pty_chars_in_buffer+20/38>
Trace; c01aa03e <normal_poll+102/124>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  cat
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c01f1ae4 <ide_dmaproc+13c/210>
Trace; c01f1300 <ide_dma_intr+0/a8>
Trace; c01f1948 <dma_timer_expiry+0/60>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c01edcdc <ide_do_request+28c/2e4>
Trace; c01ee1f2 <ide_intr+166/18c>
Trace; c01f1300 <ide_dma_intr+0/a8>
Trace; c01bee66 <__make_request+156/66c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01ee1f2 <ide_intr+166/18c>
Trace; c011b794 <update_process_times+20/94>
Trace; c010ef9c <smp_apic_timer_interrupt+ec/110>
Trace; c01070bc <error_code+34/3c>
Proc;  wishx
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c01f1ae4 <ide_dmaproc+13c/210>
Trace; c01f1300 <ide_dma_intr+0/a8>
Trace; c01f1948 <dma_timer_expiry+0/60>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c01ee1f2 <ide_intr+166/18c>
Trace; c01bec1c <attempt_merge+60/154>
Trace; c01bec2e <attempt_merge+72/154>
Trace; c01bee66 <__make_request+156/66c>
Trace; c01bf07e <__make_request+36e/66c>
Trace; c01296d6 <kmem_cache_alloc+8a/12c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0131de4 <sys_read+bc/c4>
Trace; c01070bc <error_code+34/3c>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c01ab604 <pty_chars_in_buffer+20/38>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  alarmd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c01a6d56 <tiocspgrp+6e/94>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c01a6d56 <tiocspgrp+6e/94>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 00000000 Before first symbol
Trace; c01a6d56 <tiocspgrp+6e/94>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  kmail
>>EIP; 00000000 Before first symbol
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0131de4 <sys_read+bc/c4>
Trace; c01070bc <error_code+34/3c>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdesud
>>EIP; 00000000 Before first symbol
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c012c312 <free_pages+1a/1c>
Trace; c013fc7a <select_bits_free+a/10>
Trace; c01400ee <sys_select+46e/47c>
Trace; c01070bc <error_code+34/3c>
Proc;  xemacs
>>EIP; c47b9f2c <_end+43ef4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  xemacs
>>EIP; c6df9f2c <_end+6a2f4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  ssh
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c01ab604 <pty_chars_in_buffer+20/38>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  mysql-test-ru
>>EIP; 00000000 Before first symbol
Trace; c011d7e6 <sys_rt_sigaction+9e/144>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  mysqlmanager
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c025386a <tcp_transmit_skb+3c6/51c>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c024c4d2 <wait_for_connect+112/1d8>
Trace; c024c658 <tcp_accept+c0/23c>
Trace; c0263d24 <inet_accept+2c/1b8>
Trace; c0230626 <sys_accept+66/fc>
Trace; c0106396 <restore_sigcontext+116/13c>
Trace; c023107c <sys_socketcall+b4/200>
Trace; c0106fca <system_call+32/38>
Proc;  mysqlmanager
>>EIP; cf78a000 <_end+f3bf584/105bd584>   <=====
Trace; c013a07c <pipe_wait+7c/a4>
Trace; c013a154 <pipe_read+b0/1f8>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  mysqlmanager
>>EIP; 00000000 Before first symbol
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c012c2f4 <__free_pages+1c/20>
Trace; c012c312 <free_pages+1a/1c>
Trace; c013f91a <poll_freewait+3a/44>
Trace; c0140534 <sys_poll+2d4/2f0>
Trace; c01070bc <error_code+34/3c>
Proc;  mysqlmanager
>>EIP; cd79ffb0 <_end+d3d5534/105bd584>   <=====
Trace; c013a274 <pipe_read+1d0/1f8>
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c78abfb0 <_end+74e1534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; ce209f28 <_end+de3f4ac/105bd584>   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c014023e <do_poll+ba/dc>
Trace; c014043c <sys_poll+1dc/2f0>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c9ff9fb0 <_end+9c2f534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c3e69fb0 <_end+3a9f534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c5b8ffb0 <_end+57c5534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; ce94bfb0 <_end+e581534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; ceb1dfb0 <_end+e753534/105bd584>   <=====
Trace; c01400ee <sys_select+46e/47c>
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; ca615f2c <_end+a24b4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c723dfb0 <_end+6e73534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c6579fb0 <_end+61af534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; c902ff28 <_end+8c654ac/105bd584>   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c014023e <do_poll+ba/dc>
Trace; c014043c <sys_poll+1dc/2f0>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; cd601fb0 <_end+d237534/105bd584>   <=====
Trace; c0106142 <sys_rt_sigsuspend+fa/118>
Trace; c0106fca <system_call+32/38>
Proc;  mysqld
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c019bcd6 <do_journal_end+b6/a7c>
Trace; c0277166 <unix_stream_data_wait+c6/114>
Trace; c0277358 <unix_stream_recvmsg+1a4/3ac>
Trace; c022fa60 <sock_recvmsg+3c/ac>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  mysqlmanagerc
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0232cbc <__kfree_skb+144/14c>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c024abe2 <tcp_data_wait+106/190>
Trace; c024b22e <tcp_recvmsg+502/91c>
Trace; c0263f64 <inet_recvmsg+3c/54>
Trace; c022fa60 <sock_recvmsg+3c/ac>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  mysqlmanager
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c0277166 <unix_stream_data_wait+c6/114>
Trace; c0277358 <unix_stream_recvmsg+1a4/3ac>
Trace; c022fa60 <sock_recvmsg+3c/ac>
Trace; c022fb6e <sock_read+92/a0>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  compile-penti
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gmake
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gmake
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c011d7e6 <sys_rt_sigaction+9e/144>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; c68c9f2c <_end+64ff4b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c013f9ac <__pollwait+88/90>
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  bash
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c0110f66 <schedule_timeout+16/9c>
Trace; c01a996e <read_chan+3ae/754>
Trace; c01a56ca <tty_read+d6/128>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; c8f01f2c <_end+8b374b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; cb2ebf2c <_end+af214b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  kdeinit
>>EIP; cf7bff2c <_end+f3f54b0/105bd584>   <=====
Trace; c0110fca <schedule_timeout+7a/9c>
Trace; c0110ef4 <process_timeout+0/5c>
Trace; c013fc1e <do_select+1ca/204>
Trace; c013ffc0 <sys_select+340/47c>
Trace; c0106fca <system_call+32/38>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c011d7e6 <sys_rt_sigaction+9e/144>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gmake
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c011d7e6 <sys_rt_sigaction+9e/144>
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gmake
>>EIP; c55f6000 <_end+522b584/105bd584>   <=====
Trace; c013a07c <pipe_wait+7c/a4>
Trace; c013a154 <pipe_read+b0/1f8>
Trace; c0131db6 <sys_read+8e/c4>
Trace; c0106fca <system_call+32/38>
Proc;  gcc
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  cc1plus
>>EIP; 00000000 Before first symbol
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c011b676 <update_wall_time+a/34>
Trace; c011b886 <timer_bh+36/2bc>
Trace; c011147c <schedule+404/614>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01070bc <error_code+34/3c>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gcc
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gcc
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  gcc
>>EIP; 00000000 Before first symbol
Trace; c01175a4 <sys_wait4+398/3d0>
Trace; c0106fca <system_call+32/38>
Proc;  cc1plus
>>EIP; 00000000 Before first symbol
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01ee1f2 <ide_intr+166/18c>
Trace; c011b794 <update_process_times+20/94>
Trace; c010ef9c <smp_apic_timer_interrupt+ec/110>
Trace; c01070bc <error_code+34/3c>
Proc;  cc1plus
>>EIP; 00000000 Before first symbol
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01bbf48 <handle_kbd_event+104/180>
Trace; c011147c <schedule+404/614>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c0108866 <do_IRQ+c6/ec>
Trace; c01070bc <error_code+34/3c>
Proc;  cc1plus
>>EIP; 00000000 Before first symbol
Trace; c01245b4 <__lock_page+78/a0>
Trace; c01245f2 <lock_page+16/1c>
Trace; c012559c <filemap_nopage+188/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c01177f0 <it_real_fn+40/48>
Trace; c011bab4 <timer_bh+264/2bc>
Trace; c01233f4 <do_brk+114/20c>
Trace; c011b794 <update_process_times+20/94>
Trace; c010ef9c <smp_apic_timer_interrupt+ec/110>
Trace; c01070bc <error_code+34/3c>
Proc;  sendmail
>>EIP; 00000002 Before first symbol   <=====
Trace; c01bf512 <submit_bh+56/70>
Trace; c0132cae <__wait_on_buffer+6e/94>
Trace; c0133e40 <bread+44/64>
Trace; c0197a24 <reiserfs_bread+14/1c>
Trace; c0193d28 <search_by_key+70/c10>
Trace; c0194972 <search_for_position_by_key+aa/3a4>
Trace; c0185e64 <make_cpu_key+38/40>
Trace; c0186048 <_get_block_create_0+9c/5a0>
Trace; c0186062 <_get_block_create_0+b6/5a0>
Trace; c018687c <reiserfs_get_block+13c/d88>
Trace; c01bee66 <__make_request+156/66c>
Trace; c01296d6 <kmem_cache_alloc+8a/12c>
Trace; c0134798 <block_read_full_page+e4/21c>
Trace; c012c132 <__alloc_pages+46/1ac>
Trace; c0124390 <add_to_page_cache_unique+74/84>
Trace; c0189362 <reiserfs_readpage+e/14>
Trace; c0186740 <reiserfs_get_block+0/d88>
Trace; c0124444 <page_cache_read+a4/c8>
Trace; c012448e <read_cluster_nonblocking+26/40>
Trace; c012556a <filemap_nopage+156/344>
Trace; c0122012 <do_no_page+5a/d4>
Trace; c01220ec <handle_mm_fault+60/c0>
Trace; c0110604 <do_page_fault+178/4b4>
Trace; c011048c <do_page_fault+0/4b4>
Trace; c011b676 <update_wall_time+a/34>
Trace; c011b886 <timer_bh+36/2bc>
Trace; c011b38e <tqueue_bh+16/1c>
Trace; c01187e0 <bh_action+4c/88>
Trace; c01186b8 <tasklet_hi_action+6c/a0>
Trace; c011843e <do_softirq+6e/cc>
Trace; c010887a <do_IRQ+da/ec>
Trace; c01070bc <error_code+34/3c>

Some possibly helpful details:

The compile was happening on the ReiserFS partition that was 93% full. As you 
can see from /proc/meminfo, I have 0 swap - this is intentional.



-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
