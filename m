Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312888AbSDBSdH>; Tue, 2 Apr 2002 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312893AbSDBSc6>; Tue, 2 Apr 2002 13:32:58 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:19797 "EHLO
	hotmale.boyland.org") by vger.kernel.org with ESMTP
	id <S312888AbSDBSct>; Tue, 2 Apr 2002 13:32:49 -0500
Message-ID: <3CA9FA1E.3070803@blue-labs.org>
Date: Tue, 02 Apr 2002 13:36:14 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020329
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] unmounting nfs mount causes OOPS, 2.4.19-pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux James.kalifornia.com 2.4.19-pre4 #6 Tue Mar 26 13:00:10 EST 2002 
i686 unknown
mount: mount-2.11n
hotmale:/usr/local/apache/virtuals /usr/local/virtuals nfs 
defaults,rsize=8192,wsize=8192 0 0

Note: this is sporadic, it doesn't happen every time.

kernel BUG at inode.c:513!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0147e88>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001b   ebx: c6e32864   ecx: c0432cbc   edx: 000030ba
esi: c7505f34   edi: c7505f34   ebp: 08052428   esp: c7505f00
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 2004, stackpage=c7505000)
Stack: c0391ca0 00000201 c6e32864 c7505f34 c7505f34 c0147faf c6e32864 
c0147fb8
       c6e32864 00000000 c2169060 c01480e5 c7505f34 c6e32bfc c232818c 
c7505f34
       c7505f34 c2169000 c7d303d0 c0437dc0 c013a0d5 c2169000 c7505f88 
c1165544
Call Trace: [<c0147faf>] [<c0147fb8>] [<c01480e5>] [<c013a0d5>] 
[<c013df98>]
   [<c014a471>] [<c0134acf>] [<c014a4cc>] [<c0106deb>]
Code: 0f 0b 58 5a 8b 83 f8 00 00 00 a9 10 00 00 00 0f 84 bb 00 00

 >>EIP; c0147e88 <clear_inode+28/120>   <=====
Trace; c0147faf <dispose_list+2f/50>
Trace; c0147fb8 <dispose_list+38/50>
Trace; c01480e5 <invalidate_inodes+65/70>
Trace; c013a0d5 <kill_super+85/e0>
Trace; c013df98 <path_release+28/30>
Trace; c014a471 <sys_umount+71/c0>
Trace; c0134acf <filp_close+3f/60>
Trace; c014a4cc <sys_oldumount+c/10>
Trace; c0106deb <system_call+33/38>
Code;  c0147e88 <clear_inode+28/120>
00000000 <_EIP>:
Code;  c0147e88 <clear_inode+28/120>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0147e8a <clear_inode+2a/120>
   2:   58                        pop    %eax
Code;  c0147e8b <clear_inode+2b/120>
   3:   5a                        pop    %edx
Code;  c0147e8c <clear_inode+2c/120>
   4:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  c0147e92 <clear_inode+32/120>
   a:   a9 10 00 00 00            test   $0x10,%eax
Code;  c0147e97 <clear_inode+37/120>
   f:   0f 84 bb 00 00 00         je     d0 <_EIP+0xd0> c0147f58 
<clear_inode+f8/120>


