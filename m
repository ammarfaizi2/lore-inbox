Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310549AbSCSJuC>; Tue, 19 Mar 2002 04:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310553AbSCSJtw>; Tue, 19 Mar 2002 04:49:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50959 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S310549AbSCSJts>;
	Tue, 19 Mar 2002 04:49:48 -0500
Date: Tue, 19 Mar 2002 10:49:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.7, BUG(), sched.c:754
Message-ID: <20020319094942.GA1182@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got this while running a make oldconfig

ksymoops 2.4.5 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /usr/src/bk/linux-2.5/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c024cfd0, System.map says c0164ce0.  Ignoring ksyms_base entry
fd23380  length 800005b1 status 800005b1
kernel BUG at sched.c:754!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c0116147>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: 00000001   ebx: d48b0c80   ecx: d69b6000   edx: 00000000
esi: de81f780   edi: dcb4e400   ebp: d5727e88   esp: d5727e68
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00000001 deb77d40 d48b0c80 d5726000 d48b0c80 de81f780 dcb4e400 
       00000100 c01189d6 d5727ecc 00000400 00000000 72756769 de81f744 00000000 
       dcb4e400 d69b6000 de81f740 00000292 00000001 c02fecb4 c02fee20 00000200 
Call Trace: [<c01189d6>] [<c01366b6>] [<c0117e0a>] [<c0118d7a>] [<c01b0cb7>] 
   [<c01b4ed0>] [<c013e04a>] [<c0105c34>] [<c010754b>] 
Code: 0f 0b f2 02 d6 0f 2b c0 e9 86 fb ff ff 8d b6 00 00 00 00 8d 


>>EIP; c0116147 <schedule+497/4b0>   <=====

>>ebx; d48b0c80 <_end+144cdb2c/20510eac>
>>ecx; d69b6000 <_end+165d2eac/20510eac>
>>esi; de81f780 <_end+1e43c62c/20510eac>
>>edi; dcb4e400 <_end+1c76b2ac/20510eac>
>>ebp; d5727e88 <_end+15344d34/20510eac>
>>esp; d5727e68 <_end+15344d14/20510eac>

Trace; c01189d6 <copy_files+366/3c0>
Trace; c01366b6 <__alloc_pages+46/1a0>
Trace; c0117e0a <dup_task_struct+2a/90>
Trace; c0118d7a <do_fork+34a/990>
Trace; c01b0cb7 <tty_write+277/2f0>
Trace; c01b4ed0 <write_chan+0/1f0>
Trace; c013e04a <filp_close+6a/d0>
Trace; c0105c34 <sys_fork+14/20>
Trace; c010754b <syscall_call+7/b>

Code;  c0116147 <schedule+497/4b0>
00000000 <_EIP>:
Code;  c0116147 <schedule+497/4b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0116149 <schedule+499/4b0>
   2:   f2 02 d6                  repnz add %dh,%dl
Code;  c011614c <schedule+49c/4b0>
   5:   0f 2b c0                  movntps %xmm0,%eax
Code;  c011614f <schedule+49f/4b0>
   8:   e9 86 fb ff ff            jmp    fffffb93 <_EIP+0xfffffb93> c0115cda <schedule+2a/4b0>
Code;  c0116154 <schedule+4a4/4b0>
   d:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c011615a <schedule+4aa/4b0>
  13:   8d 00                     lea    (%eax),%eax


1 warning issued.  Results may not be reliable.

-- 
Jens Axboe

