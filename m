Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292891AbSCMJll>; Wed, 13 Mar 2002 04:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292892AbSCMJlc>; Wed, 13 Mar 2002 04:41:32 -0500
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:56785 "HELO
	pinus") by vger.kernel.org with SMTP id <S292891AbSCMJlQ>;
	Wed, 13 Mar 2002 04:41:16 -0500
Date: Wed, 13 Mar 2002 09:31:30 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: <steve@sorbus.navaho>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops in ReiserFS (2.4.17)
Message-ID: <Pine.LNX.4.33.0203130921070.31433-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I keep getting ResierFS oopses on my test box here.  It's a Cobalt Raq4i 
running the 2.4.17 kernel (with some of my own experimental code in the 
kernel but I don'tthink this is the cause of the problem).  The box has 
been powercycled and paniced more times than I've had hot dinners so I 
suspect that these oopses are being caused by hard drive corruption.  The 
ksymoops output is below:

ksymoops 2.4.1 on i686 2.4.7-10smp.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 
00000006
c0134c9d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0134c9d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00001002   ebx: 00001c85   ecx: 00000002   edx: 00000002
esi: 00001fff   edi: 0000201a   ebp: 0000000d   esp: c5be5d50
ds: 0018   es: 0018   ss: 0018
Process touch (pid: 1411, stackpage=c5be5000)
Stack: 0303201a 00000303 00001000 0000201a c12c4e00 c013536f 00000303 
0000201a
       00001000 c5be5e50 0000201a 00000983 c01355ac 00000303 0000201a 
00001000
       c12c4e00 c01810b4 c778f000 00001000 c7841860 c0181125 00000303 
0000201a
Call Trace: [<c013536f>] [<c01355ac>] [<c01810b4>] [<c0181125>] 
[<c0171e8d>]
   [<c0173aca>] [<c01251b4>] [<c0179e71>] [<c01447de>] [<c0145e6b>] 
[<c0175986>]   [<c0145f2f>] [<c013ccc1>] [<c01327bf>] [<c0132feb>] 
[<c01333e3>] [<c0106cf3>]Code: 39 7a 04 75 f3 66 8b 42 08 25 ff ff 00 00 
3b 44 24 20 75 e4

>>EIP; c0134c9d <get_hash_table+5d/90>   <=====
Trace; c013536f <getblk+1f/50>
Trace; c01355ac <bread+1c/80>
Trace; c01810b4 <is_tree_node+64/70>
Trace; c0181125 <search_by_key+65/d30>
Trace; c0171e8d <make_cpu_key+3d/50>
Trace; c0173aca <reiserfs_update_sd+4a/160>
Trace; c01251b4 <__vma_link+64/c0>
Trace; c0179e71 <reiserfs_dirty_inode+41/60>
Trace; c01447de <__mark_inode_dirty+2e/80>
Trace; c0145e6b <inode_setattr+cb/e0>
Trace; c0175986 <reiserfs_setattr+86/90>
Trace; c0145f2f <notify_change+4f/d0>
Trace; c013ccc1 <__user_walk+41/50>
Trace; c01327bf <sys_utime+af/d0>
Trace; c0132feb <filp_open+4b/60>
Trace; c01333e3 <filp_close+53/60>
Trace; c0106cf3 <system_call+33/40>
Code;  c0134c9d <get_hash_table+5d/90>
00000000 <_EIP>:
Code;  c0134c9d <get_hash_table+5d/90>   <=====
   0:   39 7a 04                  cmp    %edi,0x4(%edx)   <=====
Code;  c0134ca0 <get_hash_table+60/90>
   3:   75 f3                     jne    fffffff8 <_EIP+0xfffffff8> 
c0134c95 <get_hash_table+55/90>
Code;  c0134ca2 <get_hash_table+62/90>
   5:   66 8b 42 08               mov    0x8(%edx),%ax
Code;  c0134ca6 <get_hash_table+66/90>
   9:   25 ff ff 00 00            and    $0xffff,%eax
Code;  c0134cab <get_hash_table+6b/90>
   e:   3b 44 24 20               cmp    0x20(%esp,1),%eax
Code;  c0134caf <get_hash_table+6f/90>
  12:   75 e4                     jne    fffffff8 <_EIP+0xfffffff8> 
c0134c95 <get_hash_table+55/90>


-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...



