Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310446AbSCLVIy>; Tue, 12 Mar 2002 16:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311346AbSCLVIk>; Tue, 12 Mar 2002 16:08:40 -0500
Received: from pc23-22.tromso.avidi.online.no ([148.122.22.23]:58117 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id <S310446AbSCLVIW>;
	Tue, 12 Mar 2002 16:08:22 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: "'lkml'" <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: [OOPS] Reiserfs corruption causing oops in VFS code? (Kernel 2.4.16)
Date: Tue, 12 Mar 2002 22:08:17 +0100
Message-ID: <001301c1ca0a$08e1bd20$0300000a@samurai>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug may have been fixed already, but I thought the kernel version
was sufficiently recent to report the oops anyway.

The kernel version is kernel-2.4.16.1mdk-1-1mdk.i586.rpm, I don't know
if that RPM includes any reiserfs patches, I can check on request. dmesg
reports "ReiserFS version 3.6.25".

I have two partitions, / and /home, both reiserfs on IDE hardware. The
machine had been running this kernel for about two months under light
load, prior to this oops. I recently started running a Squid cache on
the machine, I suppose that has placed the filesystem under additional
strain. The machine was idle except for IMAPD access when the oops
occured.

These messages came immediatedly before the oops:

Mar 12 10:46:01 shogun kernel: is_leaf: item location seems wrong
(second one): *OLD*[93946 93947 1436783232(0) DIR], item_len 3904,
item_location 64, free_space(entry_count) 63
Mar 12 10:46:01 shogun kernel: vs-5150: search_by_key: invalid format
found in block 41204. Fsck?
Mar 12 10:46:01 shogun kernel: is_leaf: item location seems wrong
(second one): *OLD*[93946 93947 1436783232(0) DIR], item_len 3904,
item_location 64, free_space(entry_count) 63
Mar 12 10:46:01 shogun kernel: vs-5150: search_by_key: invalid format
found in block 41204. Fsck?

Here is the oops, as decoded by ksymoops:

ksymoops 2.4.3 on i586 2.4.16.1mdk-1-1mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16.1mdk-1-1mdk/ (default)
     -m /boot/System.map-2.4.16.1mdk-1-1mdk (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module reiserfs is in lsmod but not in
ksyms, probably no symbols exported
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01bfcc0, System.map says c0152d30.  Ignoring ksyms_base entry
Mar 12 10:46:02 shogun kernel: Unable to handle kernel paging request at
virtual address 43b279f0
Mar 12 10:46:02 shogun kernel: c0142ca4
Mar 12 10:46:02 shogun kernel: *pde = 00000000
Mar 12 10:46:02 shogun kernel: Oops: 0000
Mar 12 10:46:02 shogun kernel: CPU:    0
Mar 12 10:46:02 shogun kernel: EIP:    0010:[d_lookup+100/288]    Not
tainted
Mar 12 10:46:02 shogun kernel: EIP:    0010:[<c0142ca4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 12 10:46:02 shogun kernel: EFLAGS: 00010213
Mar 12 10:46:02 shogun kernel: eax: c5fc0000   ebx: 43b279e0   ecx:
00003fff   edx: b004ba47
Mar 12 10:46:02 shogun kernel: esi: c5cab034   edi: c5cb8420   ebp:
43b279f0   esp: c5901ea4
Mar 12 10:46:02 shogun kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 10:46:02 shogun kernel: Process imapd (pid: 7636,
stackpage=c5901000)
Mar 12 10:46:02 shogun kernel: Stack: c5fc98b8 c5cab006 b004ba47
0000002e c5901f10 c5cab034 c5cb8420 c5901f48 
Mar 12 10:46:02 shogun kernel:        c013a6b0 c45a2840 c5901f10
c5901f10 c013ade9 c45a2840 c5901f10 00000000 
Mar 12 10:46:02 shogun kernel:        00000009 c5cab034 00000000
00000073 c2cb0520 c2cb0520 00001000 fffffff4 
Mar 12 10:46:02 shogun kernel: Call Trace: [cached_lookup+16/80]
[link_path_walk+1337/1936] [getname+95/160] [__user_walk+51/80]
[vfs_stat+25/144] 
Mar 12 10:46:02 shogun kernel: Call Trace: [<c013a6b0>] [<c013ade9>]
[<c013a48f>] [<c013b403>] [<c0137ef9>] 
Mar 12 10:46:02 shogun kernel:    [<c01384e1>] [<c01319f3>] [<c01244f2>]
[<c0106f13>] 
Mar 12 10:46:02 shogun kernel: Code: 8b 6d 00 39 53 44 0f 85 90 00 00 00
8b 44 24 24 39 43 0c 0f 

>>EIP; c0142ca4 <d_lookup+64/120>   <=====
Trace; c013a6b0 <cached_lookup+10/50>
Trace; c013ade8 <link_path_walk+538/790>
Trace; c013a48e <getname+5e/a0>
Trace; c013b402 <__user_walk+32/50>
Trace; c0137ef8 <vfs_stat+18/90>
Trace; c01384e0 <sys_stat64+10/30>
Trace; c01319f2 <filp_close+52/60>
Trace; c01244f2 <sys_munmap+32/50>
Trace; c0106f12 <system_call+32/40>
Code;  c0142ca4 <d_lookup+64/120>
00000000 <_EIP>:
Code;  c0142ca4 <d_lookup+64/120>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c0142ca6 <d_lookup+66/120>
   3:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0142caa <d_lookup+6a/120>
   6:   0f 85 90 00 00 00         jne    9c <_EIP+0x9c> c0142d40
<d_lookup+100/120>
Code;  c0142cb0 <d_lookup+70/120>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0142cb4 <d_lookup+74/120>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0142cb6 <d_lookup+76/120>
  13:   0f 00 00                  sldt   (%eax)


3 warnings issued.  Results may not be reliable.

Reiserfs appeared to recover just fine after a reboot:

Mar 12 17:05:07 shogun kernel: reiserfs: checking transaction log
(device 03:01) ...
Mar 12 17:05:07 shogun kernel: reiserfs: replayed 7 transactions in 3
seconds
Mar 12 17:05:07 shogun kernel: ReiserFS version 3.6.25
Mar 12 17:05:07 shogun kernel: VFS: Mounted root (reiserfs filesystem)
readonly.
Mar 12 17:05:07 shogun kernel: reiserfs: checking transaction log
(device 03:02) ...
Mar 12 17:05:07 shogun kernel: reiserfs: replayed 3 transactions in 3
seconds
Mar 12 17:05:07 shogun kernel: ReiserFS version 3.6.25

Haven't tried fsck yet..

-- 
Troels Walsted Hansen

