Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbSJKNv5>; Fri, 11 Oct 2002 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSJKNv5>; Fri, 11 Oct 2002 09:51:57 -0400
Received: from nexus.iu.hio.no ([128.39.89.10]:54510 "EHLO nexus.iu.hio.no")
	by vger.kernel.org with ESMTP id <S262453AbSJKNvx>;
	Fri, 11 Oct 2002 09:51:53 -0400
Message-Id: <200210111357.g9BDvBEF017410@nexus.iu.hio.no>
Date: Fri, 11 Oct 2002 15:57:32 +0200 (MEST)
From: zigkill+lkml@start.no
Reply-To: zigkill+lkml@start.no
Subject: PROBLEM: oops on 2.4.18-686 (kswapd)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] oops on 2.4.18-686 (kswapd)

[2.] This is what was reported to syslog:

Oct 11 06:02:46 danton kernel: Unable to handle kernel paging request at virtual address 7d104757
Oct 11 06:02:46 danton kernel:  printing eip:
Oct 11 06:02:46 danton kernel: c0131905
Oct 11 06:02:46 danton kernel: *pde = 00000000
Oct 11 06:02:46 danton kernel: Oops: 0000
Oct 11 06:02:46 danton kernel: CPU:    0
Oct 11 06:02:46 danton kernel: EIP:    0010:[try_to_release_page+29/72]    Not tainted
Oct 11 06:02:46 danton kernel: EFLAGS: 00010282
Oct 11 06:02:46 danton kernel: eax: 7d10473b   ebx: c1208000   ecx: c120801c   edx: c01f2948
Oct 11 06:02:46 danton kernel: esi: 000001d0   edi: 00000004   ebp: 00000200   esp: c142df40
Oct 11 06:02:46 danton kernel: ds: 0018   es: 0018   ss: 0018
Oct 11 06:02:46 danton kernel: Process kswapd (pid: 4, stackpage=c142d000)
Oct 11 06:02:46 danton kernel: Stack: cd0dada0 c1208000 c0129c72 c1208000 000001d0 00000020 000001d0 00000020
Oct 11 06:02:46 danton kernel:        00000006 00000006 c142c000 000018da 000001d0 c01f2948 c0129ea6 00000006
Oct 11 06:02:46 danton kernel:        00000003 00000006 000001d0 c01f2948 00000000 c01f2948 c0129f0f 00000020
Oct 11 06:02:46 danton kernel: Call Trace: [shrink_cache+458/732] [shrink_caches+86/136] [try_to_free_pages+55/88] [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40]
Oct 11 06:02:46 danton kernel:    [kswapd+153/188] [kernel_thread+40/56]
Oct 11 06:02:46 danton kernel:
Oct 11 06:02:46 danton kernel: Code: 83 78 1c 00 74 15 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 07

Then kswapd zombied.


[3.] kswapd

[4.] [sigmunds]@danton$ cat /proc/version
Linux version 2.4.18-686 (herbert@gondolin) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Sun Apr 14 11:32:47 EST 2002

[5.] See [2.] for oops message

[sigmunds]@danton$ ksymoops < /oops.txt
ksymoops 2.4.5 on i686 2.4.18-686.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-686/ (default)
     -m /boot/System.map-2.4.18-686 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/ext2/ext2.o for module ext2 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-686/kernel/fs/jbd/jbd.o for module jbd has changed since load
Unable to handle kernel paging request at virtual address 7d104757
c0131905
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[try_to_release_page+29/72]    Not tainted
EFLAGS: 00010282
eax: 7d10473b   ebx: c1208000   ecx: c120801c   edx: c01f2948
esi: 000001d0   edi: 00000004   ebp: 00000200   esp: c142df40
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c142d000)
Stack: cd0dada0 c1208000 c0129c72 c1208000 000001d0 00000020 000001d0 00000020
       00000006 00000006 c142c000 000018da 000001d0 c01f2948 c0129ea6 00000006
       00000003 00000006 000001d0 c01f2948 00000000 c01f2948 c0129f0f 00000020
Call Trace: [shrink_cache+458/732] [shrink_caches+86/136] [try_to_free_pages+55/88] [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40]
Code: 83 78 1c 00 74 15 56 53 8b 40 1c ff d0 83 c4 08 85 c0 75 07
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 7d10473b Before first symbol
>>ebx; c1208000 <_end+f925f4/105975f4>
>>ecx; c120801c <_end+f92610/105975f4>
>>edx; c01f2948 <contig_page_data+a8/320>
>>esp; c142df40 <_end+11b8534/105975f4>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   83 78 1c 00               cmpl   $0x0,0x1c(%eax)
Code;  00000004 Before first symbol
   4:   74 15                     je     1b <_EIP+0x1b> 0000001b Before first symbol
Code;  00000006 Before first symbol
   6:   56                        push   %esi
Code;  00000007 Before first symbol
   7:   53                        push   %ebx
Code;  00000008 Before first symbol
   8:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  0000000b Before first symbol
   b:   ff d0                     call   *%eax
Code;  0000000d Before first symbol
   d:   83 c4 08                  add    $0x8,%esp
Code;  00000010 Before first symbol
  10:   85 c0                     test   %eax,%eax
Code;  00000012 Before first symbol
  12:   75 07                     jne    1b <_EIP+0x1b> 0000001b Before first symbol


7 warnings issued.  Results may not be reliable.

[6.] NA

[7.]
	[7.1]
[sigmunds]@danton$ bash ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux danton 2.4.18-686 #1 Sun Apr 14 11:32:47 EST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
modutils               2.4.15
e2fsprogs              tune2fs
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         i810 agpgart nfs lockd sunrpc i810_audio soundcore ac97_codec eepro100 af_packet rtc unix ide-disk ide-probe-mod ide-mod ext2 ext3 jbd

	[7.2]
[sigmunds]@danton$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 934.993
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1867.77

	[7.3]
[sigmunds]@danton$ cat /proc/modules
i810                   63192   1
agpgart                29504   7 (autoclean)
nfs                    69500   7 (autoclean)
lockd                  46656   1 (autoclean) [nfs]
sunrpc                 58196   1 (autoclean) [nfs lockd]
i810_audio             19968   0 (unused)
soundcore               3556   2 [i810_audio]
ac97_codec              9376   0 [i810_audio]
eepro100               17104   1
af_packet              11432   0 (unused)
rtc                     5368   0 (autoclean)
unix                   13316  13 (autoclean)
ide-disk                6592   2 (autoclean)
ide-probe-mod           7968   0 (autoclean)
ide-mod               129420   2 (autoclean) [ide-disk ide-probe-mod]
ext2                   30400   1 (autoclean)
ext3                   56544   0 (autoclean)
jbd                    34968   0 (autoclean) [ext3]

	[7.4] NA
	[7.5] NA

[X.] NA

I have several boxes similar to this one, and I have not seen this (or
any other) oops before on this kernel version.

I am not on the list,
My work address is sigmunds at iu.hio.no.
Sigmund Straumsnes

