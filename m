Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSDPMn1>; Tue, 16 Apr 2002 08:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313609AbSDPMn0>; Tue, 16 Apr 2002 08:43:26 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:32216 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S313419AbSDPMn0>; Tue, 16 Apr 2002 08:43:26 -0400
Date: Tue, 16 Apr 2002 13:43:25 +0100 (BST)
From: Matt Bernstein <mb/oops@dcs.qmul.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.18-pre7-ac3 ext3
Message-ID: <Pine.LNX.4.44.0204161340180.28762-100000@nick.dcs.qmul.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the following spat out by syslog on my (2.4.18-pre7-ac3) mailer /
web server:

Assertion failure in do_get_write_access() at transaction.c:611: "!(((jh2bh(jh))->b_state & (1UL << BH_Lock)) != 0)"

One of its partitions froze hard--I've rebooted it, and I have an oops
which the BUG() triggered. Here's the trace. I hope it can shed some
light.. (the machine is a UP Athlon, everything and its daughter a module,
the most notable possibly being nfsd, gdth, e100 (1.6.29), jbd, ext3)

Is this a hardware or software problem? [the warnings are most likely
caused either by initrd, or my installing e100]

ksymoops 2.4.5 on i686 2.4.18-pre7-ac3.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -O (specified)
     -m System.map (specified)
     -S

Warning (expand_objects): object /lib/modules/2.4.18-pre7-ac3/kernel/fs/ext3/ext3.o for module ext3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-pre7-ac3/kernel/fs/jbd/jbd.o for module jbd has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-pre7-ac3/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.18-pre7-ac3/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Reading Oops report from the terminal
kernel BUG at transaction.c:611!
invalid operand: 0000
CPU:    0
EIP:    0010:[<e081ddb0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000021   ebx: c38d4efc   ecx: 00000001   edx: 0001a3cb
esi: deba4400   edi: d5da01c4   ebp: deba4400   esp: c54ebda8
ds: 0018   es: 0018   ss: 0018
Process apache (pid: 14588, stackpage=c54eb000)
Stack: e08273b0 00000263 00000000 00000000 00000000 d489ba54 d5da01c4 c36cd7f4
       e08247e7 dfdde0c0 deba4494 deba4400 d5da01c4 c52faae4 e081e1e5 d5da01c4
       c52faae4 00000000 00000000 d5da01c4 c54ebe6c c36cd7f4 e082fd80 d5da01c4
Call Trace: [<e08273b0>] [<e08247e7>] [<e081e1e5>] [<e082fd80>] [<e0827414>]
   [<e082466a>] [<e082fe18>] [<e082fef7>] [<c0121f18>] [<c01440ee>] [<c01455c1>]
   [<c0124e1a>] [<c0121d39>] [<c011e42e>] [<c013b098>] [<c013c31b>] [<c010b37a>]
   [<c0129335>] [<c0106efb>]
Code: 0f 0b 5b 5e 8b 5c 24 34 c7 44 24 08 e2 ff ff ff b8 01 00 00


>>EIP; e081ddb0 <[jbd]do_get_write_access+230/630>   <=====

>>ebx; c38d4efc <_end+3686768/205b186c>
>>edx; 0001a3cb Before first symbol
>>esi; deba4400 <_end+1e955c6c/205b186c>
>>edi; d5da01c4 <_end+15b51a30/205b186c>
>>ebp; deba4400 <_end+1e955c6c/205b186c>
>>esp; c54ebda8 <_end+529d614/205b186c>

Trace; e08273b0 <[jbd].LC87+b0/11c0>
Trace; e08247e7 <[jbd]journal_alloc_journal_head+17/b0>
Trace; e081e1e5 <[jbd]journal_get_write_access+35/60>
Trace; e082fd80 <[ext3]ext3_reserve_inode_write+30/b0>
Trace; e0827414 <[jbd].LC87+114/11c0>
Trace; e082466a <[jbd]__jbd_kmalloc+2a/b0>
Trace; e082fe18 <[ext3]ext3_mark_inode_dirty+18/40>
Trace; e082fef7 <[ext3]ext3_dirty_inode+b7/100>
Trace; c0121f18 <get_unmapped_area+d8/120>
Trace; c01440ee <__mark_inode_dirty+2e/80>
Trace; c01455c1 <update_atime+51/60>
Trace; c0124e1a <generic_file_mmap+4a/60>
Trace; c0121d39 <do_mmap_pgoff+3a9/4b0>
Trace; c011e42e <in_group_p+1e/30>
Trace; c013b098 <vfs_permission+78/120>
Trace; c013c31b <open_namei+2fb/5a0>
Trace; c010b37a <old_mmap+ea/120>
Trace; c0129335 <kmem_cache_free+205/290>
Trace; c0106efb <system_call+33/38>

Code;  e081ddb0 <[jbd]do_get_write_access+230/630> 00000000 <_EIP>:
Code;  e081ddb0 <[jbd]do_get_write_access+230/630>    0:   0f 0b                     ud2a      <=====
Code;  e081ddb2 <[jbd]do_get_write_access+232/630>    2:   5b                        pop    %ebx
Code;  e081ddb3 <[jbd]do_get_write_access+233/630>    3:   5e                        pop    %esi
Code;  e081ddb4 <[jbd]do_get_write_access+234/630>    4:   8b 5c 24 34               mov    0x34(%esp,1),%ebx
Code;  e081ddb8 <[jbd]do_get_write_access+238/630>    8:   c7 44 24 08 e2 ff ff      movl   $0xffffffe2,0x8(%esp,1)
Code;  e081ddbf <[jbd]do_get_write_access+23f/630>    f:   ff
Code;  e081ddc0 <[jbd]do_get_write_access+240/630>   10:   b8 01 00 00 00            mov    $0x1,%eax


4 warnings issued.  Results may not be reliable.

