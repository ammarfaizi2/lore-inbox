Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFCVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFCVYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVFCVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:24:44 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:11417 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S261404AbVFCVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:23:55 -0400
Date: Sat, 4 Jun 2005 00:23:46 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: openafs-info@openafs.org
cc: linux-kernel@vger.kernel.org
Subject: oopses with openafs 1.3.83 and linux 2.4.31
Message-ID: <Pine.LNX.4.62.0506040005580.9773@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-AntiVirus: checked by AntiVir Milter (version: 1.1.0-4; AVE: 6.30.0.15; VDF: 6.30.0.224; host: tassadar)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



(resending due to size , sorry mods)

         Hi ,

         After moving to linux 2.4.31 and openafs 1.3.83 , I still get
oopses once per day. Usually this causes the system to either freeze
totally (only replies to ping) or all processes segfault. Exacly the same
happened with 2.4.29 and 2.4.30 with openafs 1.3.82. With openafs 1.3.78
the oopses occur usually after 10+ days uptime (dunno with 2.4.31 yet
though,running it now)
         My cell consists of one 1.2.x server with the openafs database and
one 1.3.x server , for large files support. The volumes I access are on
the 1.3.x server. All servers are running gentoo linux , the 1.3.x
2.6.11.6 kernels and the 1.2.x 2.4.27. My system is a dual p3 @ 600 Mhz
with 768 Mb ram. I have just memtested the system , in completed
several passes and no errors were detected. The cpu temperature is ok , I 
also checked thedisks. Without openafs running the system is stable in all
stress tests.Running slackware 10.1.
         The problems always occur after 4 am , sometimes exacly at 4 am
sometimes one hour later. At 4 am my afs servers restart themselves.At the
same moment usually there are tenths of concurrent read/write operations
on my volumes. However I have not succeeded in reproducing the oopses 
while manually performing fileserver restarts with processes writing to 
afs.

First , the ooposes with 2.4.31 SMP and openafs 1.3.83

ksymoops 2.4.11 on i686 2.4.31.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.31/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): libafs-2.4.31.mp symbol sys_chdir not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Warning (compare_maps): libafs-2.4.31.mp symbol sys_exit not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Warning (compare_maps): libafs-2.4.31.mp symbol sys_ioctl not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Warning (compare_maps): libafs-2.4.31.mp symbol sys_open not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Warning (compare_maps): libafs-2.4.31.mp symbol sys_wait4 not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Warning (compare_maps): libafs-2.4.31.mp symbol sys_write not found in /usr/local/lib/openafs/libafs-2.4.31.mp.o.  Ignoring /usr/local/lib/openafs/libafs-2.4.31.mp.o entry
Jun  2 05:03:24 system kernel: Unable to handle kernel paging request at virtual address a7bd037a
Jun  2 05:03:24 system kernel: c015a6fb
Jun  2 05:03:24 system kernel: *pde = 00000000
Jun  2 05:03:24 system kernel: Oops: 0000
Jun  2 05:03:24 system kernel: CPU:    1
Jun  2 05:03:24 system kernel: EIP:    0010:[<c015a6fb>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  2 05:03:24 system kernel: EFLAGS: 00010286
Jun  2 05:03:24 system kernel: eax: 00000000   ebx: c9e41d60   ecx: c9e41d70   edx: c9e41d70
Jun  2 05:03:24 system kernel: esi: a7bd035a   edi: 00000000   ebp: 0001bec2   esp: effddf04
Jun  2 05:03:24 system kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 05:03:24 system kernel: Process kswapd (pid: 5, stackpage=effdd000)
Jun  2 05:03:24 system kernel: Stack: ee2f4140 c01575d1 eb4deee0 d70f5938 d70f5920 c9e41d60 c0157a2e c9e41d60 
Jun  2 05:03:24 system kernel:        d70f59a0 00000006 c17e3558 c03a3b1c 000007d7 c0157e04 00021f7b c0138ee0 
Jun  2 05:03:24 system kernel:        00000006 000001d0 ffffffff 000001d0 00000006 00000013 000001d0 c03a3b1c 
Jun  2 05:03:24 system kernel: Call Trace:    [<c01575d1>] [<c0157a2e>] [<c0157e04>] [<c0138ee0>] [<c013934a>]
Jun  2 05:03:24 system kernel:   [<c01393c2>] [<c0119881>] [<c0139586>] [<c01395f8>] [<c0139738>] [<c0105000>]
Jun  2 05:03:24 system kernel:   [<c010740e>] [<c01396a0>]
Jun  2 05:03:24 system kernel: Code: 8b 46 20 85 c0 74 0e 89 c7 8b 40 18 85 c0 0f 85 c6 02 00 00


>>EIP; c015a6fb <iput+2b/320>   <=====

>>ebx; c9e41d60 <_end+99d9920/304f8c20>
>>ecx; c9e41d70 <_end+99d9930/304f8c20>
>>edx; c9e41d70 <_end+99d9930/304f8c20>
>>esp; effddf04 <_end+2fb75ac4/304f8c20>

Trace; c01575d1 <dput+31/190>
Trace; c0157a2e <prune_dcache+fe/190>
Trace; c0157e04 <shrink_dcache_memory+24/40>
Trace; c0138ee0 <shrink_cache+170/430>
Trace; c013934a <shrink_caches+4a/60>
Trace; c01393c2 <try_to_free_pages_zone+62/100>
Trace; c0119881 <schedule+2c1/550>
Trace; c0139586 <kswapd_balance_pgdat+66/b0>
Trace; c01395f8 <kswapd_balance+28/40>
Trace; c0139738 <kswapd+98/b9>
Trace; c0105000 <_stext+0/0>
Trace; c010740e <arch_kernel_thread+2e/40>
Trace; c01396a0 <kswapd+0/b9>

Code;  c015a6fb <iput+2b/320>
00000000 <_EIP>:
Code;  c015a6fb <iput+2b/320>   <=====
    0:   8b 46 20                  mov    0x20(%esi),%eax   <=====
Code;  c015a6fe <iput+2e/320>
    3:   85 c0                     test   %eax,%eax
Code;  c015a700 <iput+30/320>
    5:   74 0e                     je     15 <_EIP+0x15>
Code;  c015a702 <iput+32/320>
    7:   89 c7                     mov    %eax,%edi
Code;  c015a704 <iput+34/320>
    9:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c015a707 <iput+37/320>
    c:   85 c0                     test   %eax,%eax
Code;  c015a709 <iput+39/320>
    e:   0f 85 c6 02 00 00         jne    2da <_EIP+0x2da>

Jun  2 05:03:24 system kernel:  <1>Unable to handle kernel paging request at virtual address 345fc3e1
Jun  2 05:03:24 system kernel: c015a6fb
Jun  2 05:03:24 system kernel: *pde = 00000000
Jun  2 05:03:24 system kernel: Oops: 0000
Jun  2 05:03:24 system kernel: CPU:    0
Jun  2 05:03:24 system kernel: EIP:    0010:[<c015a6fb>]    Tainted: P 
Jun  2 05:03:24 system kernel: EFLAGS: 00010202
Jun  2 05:03:24 system kernel: eax: 00000000   ebx: c9e41b60   ecx: c9e41b70   edx: c9e41b70
Jun  2 05:03:24 system kernel: esi: 345fc3c1   edi: 00000000   ebp: 00000003   esp: ebe39c44
Jun  2 05:03:24 system kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 05:03:24 system kernel: Process httpd (pid: 239, stackpage=ebe39000)
Jun  2 05:03:24 system kernel: Stack: f09c210f f0add800 00000000 d70f58b8 d70f58a0 c9e41b60 c0157a2e c9e41b60 
Jun  2 05:03:24 system kernel:        00000003 d4f6fb40 d4f6fb50 d4f6fb40 f0b31b34 c0157dd4 00000003 d4f6fb40 
Jun  2 05:03:24 system kernel:        c01577c3 d4f6fb40 f0b31a00 f0b31a10 f09bd41b d4f6fb40 00000000 00000000 
Jun  2 05:03:24 system kernel: Call Trace:    [<f09c210f>] [<c0157a2e>] [<c0157dd4>] [<c01577c3>] [<f09bd41b>]
Jun  2 05:03:24 system kernel:   [<f09c9427>] [<f09ab280>] [<f09a549e>] [<f09a55b0>] [<f09d380f>] [<f09af7b8>]
Jun  2 05:03:24 system kernel:   [<f09f466e>] [<f09af87c>] [<f09af5cd>] [<f09ca472>] [<f09c1d69>] [<c01575d1>]
Jun  2 05:03:24 system kernel:   [<f0a15a60>] [<f09f7206>] [<c0157e41>] [<c014d032>] [<c014d9ec>] [<c014dec9>]
Jun  2 05:03:24 system kernel:   [<c014e229>] [<c014a03f>] [<c01411e9>] [<c0108ebb>]
Jun  2 05:03:24 system kernel: Code: 8b 46 20 85 c0 74 0e 89 c7 8b 40 18 85 c0 0f 85 c6 02 00 00


>>EIP; c015a6fb <iput+2b/320>   <=====

>>ebx; c9e41b60 <_end+99d9720/304f8c20>
>>ecx; c9e41b70 <_end+99d9730/304f8c20>
>>edx; c9e41b70 <_end+99d9730/304f8c20>
>>esp; ebe39c44 <_end+2b9d1804/304f8c20>

Trace; f09c210f <[libafs-2.4.31.mp].text.lock.KBUILD_BASENAME+127/3c8>
Trace; c0157a2e <prune_dcache+fe/190>
Trace; c0157dd4 <shrink_dcache_parent+24/30>
Trace; c01577c3 <d_invalidate+93/b0>
Trace; f09bd41b <[libafs-2.4.31.mp]afs_syscall_call+10cb/1910>
Trace; f09c9427 <[libafs-2.4.31.mp]PCallBackAddr+3d7/405>
Trace; f09ab280 <[libafs-2.4.31.mp]AllocPacketBufs+0/180>
Trace; f09a549e <[libafs-2.4.31.mp]rxi_Start+6ee/790>
Trace; f09a55b0 <[libafs-2.4.31.mp]rxi_Send+70/c0>
Trace; f09d380f <[libafs-2.4.31.mp].rodata.end+9914/e505>
Trace; f09af7b8 <[libafs-2.4.31.mp]_RXAFSCB_WhoAreYou+98/120>
Trace; f09f466e <END_OF_CODE+f592/????>
Trace; f09af87c <[libafs-2.4.31.mp]_RXAFSCB_InitCallBackState3+3c/110>
Trace; f09af5cd <[libafs-2.4.31.mp]_RXAFSCB_GetXStats+27d/2b0>
Trace; f09ca472 <[libafs-2.4.31.mp].rodata.end+577/e505>
Trace; f09c1d69 <[libafs-2.4.31.mp]afs_icl_EnumerateSets+b9/150>
Trace; c01575d1 <dput+31/190>
Trace; f0a15a60 <END_OF_CODE+30984/????>
Trace; f09f7206 <END_OF_CODE+1212a/????>
Trace; c0157e41 <d_alloc+21/190>
Trace; c014d032 <real_lookup+f2/140>
Trace; c014d9ec <link_path_walk+7ec/ac0>
Trace; c014dec9 <path_lookup+39/40>
Trace; c014e229 <__user_walk+49/60>
Trace; c014a03f <sys_stat64+1f/90>
Trace; c01411e9 <sys_open+79/c0>
Trace; c0108ebb <system_call+33/38>

Code;  c015a6fb <iput+2b/320>
00000000 <_EIP>:
Code;  c015a6fb <iput+2b/320>   <=====
    0:   8b 46 20                  mov    0x20(%esi),%eax   <=====
Code;  c015a6fe <iput+2e/320>
    3:   85 c0                     test   %eax,%eax
Code;  c015a700 <iput+30/320>
    5:   74 0e                     je     15 <_EIP+0x15>
Code;  c015a702 <iput+32/320>
    7:   89 c7                     mov    %eax,%edi
Code;  c015a704 <iput+34/320>
    9:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c015a707 <iput+37/320>
    c:   85 c0                     test   %eax,%eax
Code;  c015a709 <iput+39/320>
    e:   0f 85 c6 02 00 00         jne    2da <_EIP+0x2da>



The complete log can be found at http://tassadar.physics.auth.gr/~dzila/oops1


oops with non-smp 2.4.31 and openafs 1.3.82 follows :

ksymoops 2.4.11 on i686 2.4.31.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.31/ (default)
      -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun  3 04:56:55 system kernel: kernel BUG at inode.c:1204!
Jun  3 04:56:55 system kernel: invalid operand: 0000
Jun  3 04:56:55 system kernel: CPU:    0
Jun  3 04:56:55 system kernel: EIP:    0010:[<c014de40>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  3 04:56:55 system kernel: EFLAGS: 00010246
Jun  3 04:56:55 system kernel: eax: 00000000   ebx: e28b7c20   ecx: e28b7c30   edx: e28b7c30
Jun  3 04:56:55 system kernel: esi: ef86fc00   edi: 00000000   ebp: 00019072   esp: effe3f04
Jun  3 04:56:55 system kernel: ds: 0018   es: 0018   ss: 0018
Jun  3 04:56:55 system kernel: Process kswapd (pid: 4, stackpage=effe3000)
Jun  3 04:56:55 system kernel: Stack: e2190a20 00000010 00000282 e88a0378 e88a0360 e28b7c20 c014b5e3 e28b7c20 
Jun  3 04:56:55 system kernel:        d67bc240 00000002 c1762b7c c0374638 000003ea c014b934 0002293f c0130796 
Jun  3 04:56:55 system kernel:        00000006 000001d0 ffffffff 000001d0 00000002 00000020 000001d0 c0374638 
Jun  3 04:56:55 system kernel: Call Trace:    [<c014b5e3>] [<c014b934>] [<c0130796>] [<c0130b5d>] [<c0130be2>]
Jun  3 04:56:55 system kernel:   [<c0130da6>] [<c0130e18>] [<c0130f58>] [<c0105000>] [<c01072be>] [<c0130ec0>]
Jun  3 04:56:55 system kernel: Code: 0f 0b b4 04 66 12 32 c0 e9 93 fd ff ff c7 04 24 31 00 00 00


>>EIP; c014de40 <iput+290/2b0>   <=====

>>ebx; e28b7c20 <_end+224930d4/3046f514>
>>ecx; e28b7c30 <_end+224930e4/3046f514>
>>edx; e28b7c30 <_end+224930e4/3046f514>
>>esi; ef86fc00 <_end+2f44b0b4/3046f514>
>>esp; effe3f04 <_end+2fbbf3b8/3046f514>

Trace; c014b5e3 <prune_dcache+e3/150>
Trace; c014b934 <shrink_dcache_memory+24/40>
Trace; c0130796 <shrink_cache+166/390>
Trace; c0130b5d <shrink_caches+3d/60>
Trace; c0130be2 <try_to_free_pages_zone+62/100>
Trace; c0130da6 <kswapd_balance_pgdat+66/b0>
Trace; c0130e18 <kswapd_balance+28/40>
Trace; c0130f58 <kswapd+98/c0>
Trace; c0105000 <_stext+0/0>
Trace; c01072be <arch_kernel_thread+2e/40>
Trace; c0130ec0 <kswapd+0/c0>

Code;  c014de40 <iput+290/2b0>
00000000 <_EIP>:
Code;  c014de40 <iput+290/2b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c014de42 <iput+292/2b0>
    2:   b4 04                     mov    $0x4,%ah
Code;  c014de44 <iput+294/2b0>
    4:   66                        data16
Code;  c014de45 <iput+295/2b0>
    5:   12 32                     adc    (%edx),%dh
Code;  c014de47 <iput+297/2b0>
    7:   c0 e9 93                  shr    $0x93,%cl
Code;  c014de4a <iput+29a/2b0>
    a:   fd                        std 
Code;  c014de4b <iput+29b/2b0>
    b:   ff                        (bad) 
Code;  c014de4c <iput+29c/2b0>
    c:   ff c7                     inc    %edi
Code;  c014de4e <iput+29e/2b0>
    e:   04 24                     add    $0x24,%al
Code;  c014de50 <iput+2a0/2b0>
   10:   31 00                     xor    %eax,(%eax)

Jun  3 04:57:01 system kernel: kernel BUG at inode.c:1204!
Jun  3 04:57:01 system kernel: invalid operand: 0000
Jun  3 04:57:01 system kernel: CPU:    0
Jun  3 04:57:01 system kernel: EIP:    0010:[<c014de40>]    Tainted: P 
Jun  3 04:57:01 system kernel: EFLAGS: 00010246
Jun  3 04:57:01 system kernel: eax: 00000000   ebx: e28b7e00   ecx: e28b7e10   edx: e28b7e10
Jun  3 04:57:01 system kernel: esi: ef86fc00   edi: 00000000   ebp: 00000005   esp: e9a73cd8
Jun  3 04:57:01 system kernel: ds: 0018   es: 0018   ss: 0018
Jun  3 04:57:01 system kernel: Process lftp (pid: 3126, stackpage=e9a73000)
Jun  3 04:57:01 system kernel: Stack: f095a5b0 e9a73d2c 0015249f e88a03f8 e88a03e0 e28b7e00 c014b5e3 e28b7e00 
Jun  3 04:57:01 system kernel:        00000005 c7e37ca0 c7e37cb0 c7e37ca0 f0a85abc c014b904 00000005 c7e37ca0 
Jun  3 04:57:01 system kernel:        c014b3d9 c7e37ca0 f0a8599c f0a859ac f0972349 c7e37ca0 00000001 c013911f 
Jun  3 04:57:01 system kernel: Call Trace:    [<f095a5b0>] [<c014b5e3>] [<c014b904>] [<c014b3d9>] [<f0972349>]
Jun  3 04:57:01 system kernel:   [<c013911f>] [<f0975dc7>] [<c0137ded>] [<f0974044>] [<f0964788>] [<f096484c>]
Jun  3 04:57:01 system kernel:   [<f096459d>] [<f097f296>] [<f0976c99>] [<c0205c3e>] [<f09c9fe0>] [<f09abaf5>]
Jun  3 04:57:01 system kernel:   [<c014b971>] [<c014230d>] [<c014278b>] [<c0142fa9>] [<c0143259>] [<c013f81f>]
Jun  3 04:57:01 system kernel:   [<c010a56b>] [<c0108bab>]
Jun  3 04:57:01 system kernel: Code: 0f 0b b4 04 66 12 32 c0 e9 93 fd ff ff c7 04 24 31 00 00 00


>>EIP; c014de40 <iput+290/2b0>   <=====

>>ebx; e28b7e00 <_end+224932b4/3046f514>
>>ecx; e28b7e10 <_end+224932c4/3046f514>
>>edx; e28b7e10 <_end+224932c4/3046f514>
>>esi; ef86fc00 <_end+2f44b0b4/3046f514>
>>esp; e9a73cd8 <_end+2964f18c/3046f514>

Trace; f095a5b0 <END_OF_CODE+babd5/????>
Trace; c014b5e3 <prune_dcache+e3/150>
Trace; c014b904 <shrink_dcache_parent+24/30>
Trace; c014b3d9 <d_invalidate+69/70>
Trace; f0972349 <END_OF_CODE+d296e/????>
Trace; c013911f <fput+cf/120>
Trace; f0975dc7 <END_OF_CODE+d63ec/????>
Trace; c0137ded <filp_close+4d/80>
Trace; f0974044 <END_OF_CODE+d4669/????>
Trace; f0964788 <END_OF_CODE+c4dad/????>
Trace; f096484c <END_OF_CODE+c4e71/????>
Trace; f096459d <END_OF_CODE+c4bc2/????>
Trace; f097f296 <END_OF_CODE+df8bb/????>
Trace; f0976c99 <END_OF_CODE+d72be/????>
Trace; c0205c3e <e1000_alloc_rx_buffers+6e/370>
Trace; f09c9fe0 <END_OF_CODE+12a605/????>
Trace; f09abaf5 <END_OF_CODE+10c11a/????>
Trace; c014b971 <d_alloc+21/180>
Trace; c014230d <real_lookup+cd/f0>
Trace; c014278b <link_path_walk+32b/980>
Trace; c0142fa9 <path_lookup+39/40>
Trace; c0143259 <__user_walk+49/60>
Trace; c013f81f <sys_stat64+1f/90>
Trace; c010a56b <do_IRQ+9b/a0>
Trace; c0108bab <system_call+33/38>

Code;  c014de40 <iput+290/2b0>
00000000 <_EIP>:
Code;  c014de40 <iput+290/2b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c014de42 <iput+292/2b0>
    2:   b4 04                     mov    $0x4,%ah
Code;  c014de44 <iput+294/2b0>
    4:   66                        data16
Code;  c014de45 <iput+295/2b0>
    5:   12 32                     adc    (%edx),%dh
Code;  c014de47 <iput+297/2b0>
    7:   c0 e9 93                  shr    $0x93,%cl
Code;  c014de4a <iput+29a/2b0>
    a:   fd                        std 
Code;  c014de4b <iput+29b/2b0>
    b:   ff                        (bad) 
Code;  c014de4c <iput+29c/2b0>
    c:   ff c7                     inc    %edi
Code;  c014de4e <iput+29e/2b0>
    e:   04 24                     add    $0x24,%al
Code;  c014de50 <iput+2a0/2b0>
   10:   31 00                     xor    %eax,(%eax)


The complete log of that can be found at 
http://tassadar.physics.auth.gr/~dzila/oops2

Any hints are greatly appreciated.

         Best regards ,
--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
           http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
=============================================================================

