Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131700AbRCONXP>; Thu, 15 Mar 2001 08:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131704AbRCONXF>; Thu, 15 Mar 2001 08:23:05 -0500
Received: from cip.physik.uni-wuerzburg.de ([132.187.42.13]:43026 "EHLO
	wpax13.physik.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id <S131700AbRCONWx>; Thu, 15 Mar 2001 08:22:53 -0500
Date: Thu, 15 Mar 2001 14:00:11 +0100 (MET)
From: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
Subject: reiserfs-oops; kernel 2.4.3-pre4
Message-ID: <Pine.GHP.4.21.0103151342010.7504-100000@wpax13.physik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I got the following oops:

ksymoops 2.4.0 on i686 2.4.3-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-pre4/ (default)
     -m /boot/System.map-2.4.3-pre4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar 15 00:56:10 wptx99 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000108
Mar 15 00:56:10 wptx99 kernel: c016f090
Mar 15 00:56:10 wptx99 kernel: *pde = 00000000
Mar 15 00:56:10 wptx99 kernel: Oops: 0000
Mar 15 00:56:10 wptx99 kernel: CPU:    1
Mar 15 00:56:10 wptx99 kernel: EIP:    0010:[<c016f090>]
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 15 00:56:10 wptx99 kernel: EFLAGS: 00010286
Mar 15 00:56:10 wptx99 kernel: eax: 00000108   ebx: 00000108   ecx: de785ebc   edx: ce09d488
Mar 15 00:56:10 wptx99 kernel: esi: 00000001   edi: de785e58   ebp: d13c17c0   esp: de785e1c
Mar 15 00:56:10 wptx99 kernel: ds: 0018   es: 0018   ss: 0018
Mar 15 00:56:10 wptx99 kernel: Process nfsd (pid: 712, stackpage=de785000)
Mar 15 00:56:10 wptx99 kernel: Stack: 00000000 de785ebc c0160046 00000108 de785ebc 00000000 00000001 00000002 
Mar 15 00:56:10 wptx99 kernel:        c015c8a8 c18ec400 de785ebc fffffff4 de784000 d13c17c0 df6ee060 00000001 
Mar 15 00:56:10 wptx99 kernel:        00000000 00000000 00000000 00000000 cf73dc60 00000000 cf73d6c0 00000000 
Mar 15 00:56:10 wptx99 kernel: Call Trace: [<c0160046>] [<c015c8a8>] [<c013e39d>] [<e0e039b1>] [<c013e43f>] [<e0df8f8b>] [<e0df6c8c>] 
Mar 15 00:56:10 wptx99 kernel:        [<e0e05c80>] [<e0df6593>] [<e0e05c80>] [<e0ddd52f>] [<e0e05b68>] [<e0df63ad>] [<e0e05b60>] [<c01074c4>] 
Mar 15 00:56:10 wptx99 kernel: Code: 8b 13 8b 01 39 c2 73 08 b8 ff ff ff ff eb 1e 90 39 c2 76 0c 

>>EIP; c016f090 <comp_short_keys+10/40>   <=====
Trace; c0160046 <reiserfs_iget+6a/a4>
Trace; c015c8a8 <reiserfs_lookup+94/c4>
Trace; c013e39d <lookup_hash+9d/f0>
Trace; e0e039b1 <[nfsd].rodata.start+1771/3913>
Trace; c013e43f <lookup_one+4f/60>
Trace; e0df8f8b <[nfsd]nfsd_lookup+3cb/528>
Trace; e0df6c8c <[nfsd]nfsd_proc_lookup+8c/a0>
Trace; e0e05c80 <[nfsd]nfsd_procedures2+80/240>
Trace; e0df6593 <[nfsd]nfsd_dispatch+cb/168>
Trace; e0e05c80 <[nfsd]nfsd_procedures2+80/240>
Trace; e0ddd52f <[sunrpc]svc_process+297/4d8>
Trace; e0e05b68 <[nfsd]nfsd_version2+0/10>
Trace; e0df63ad <[nfsd]nfsd+225/340>
Trace; e0e05b60 <[nfsd]nfsd_list+0/0>
Trace; c01074c4 <kernel_thread+28/38>
Code;  c016f090 <comp_short_keys+10/40>
00000000 <_EIP>:
Code;  c016f090 <comp_short_keys+10/40>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c016f092 <comp_short_keys+12/40>
   2:   8b 01                     mov    (%ecx),%eax
Code;  c016f094 <comp_short_keys+14/40>
   4:   39 c2                     cmp    %eax,%edx
Code;  c016f096 <comp_short_keys+16/40>
   6:   73 08                     jae    10 <_EIP+0x10> c016f0a0 <comp_short_keys+20/40>
Code;  c016f098 <comp_short_keys+18/40>
   8:   b8 ff ff ff ff            mov    $0xffffffff,%eax
Code;  c016f09d <comp_short_keys+1d/40>
   d:   eb 1e                     jmp    2d <_EIP+0x2d> c016f0bd <comp_short_keys+3d/40>
Code;  c016f09f <comp_short_keys+1f/40>
   f:   90                        nop    
Code;  c016f0a0 <comp_short_keys+20/40>
  10:   39 c2                     cmp    %eax,%edx
Code;  c016f0a2 <comp_short_keys+22/40>
  12:   76 0c                     jbe    20 <_EIP+0x20> c016f0b0 <comp_short_keys+30/40>


1 warning issued.  Results may not be reliable.

The machine is running linux-2.4.3-pre4 including the reiserfs-patches
from  Alexander Zarochentcev. 
The filesystem was created with mkreiserfs 3.x.0h

Bye,

-- Andreas Klein
   asklein@cip.physik.uni-wuerzburg.de



