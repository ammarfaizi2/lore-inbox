Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbRFYPQJ>; Mon, 25 Jun 2001 11:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbRFYPQA>; Mon, 25 Jun 2001 11:16:00 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:29958 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S264618AbRFYPPv>; Mon, 25 Jun 2001 11:15:51 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac12 kernel oops
Reply-To: klink@clouddancer.com
Message-Id: <20010625151549.7ED6F784D9@mail.clouddancer.com>
Date: Mon, 25 Jun 2001 08:15:49 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why the symbol mismatch?  Why ignore /proc over the System.map?

The system had very little running (because of prior lockups) during
the morning SQL activity. About 3/4 of a megabyte was being added to
the SQL databases, and that activity had been going on for 45 minutes
prior to the oops.  No X, and I was reading email as the only other
load.  Daemons: postfix, raid5, xntpd, syslog, cron & kernel.  SMP
kernel, built with gcc 2.95.3 released 20010315.

At the time of the oops, there is an cron task that feeds postfix,
which deposits the email into a 3 meg file.



------------------------------------------------------------------

ksymoops 2.4.1 on i686 2.4.5-ac12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac12/ (default)
     -m /System.map-2.4.5-ac12 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01aad00, System.map says c014cba0.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000015
c0147e62
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0147e62>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000005   ebx: c6ef1800   ecx: c021ed64   edx: c2910000
esi: c021ee80   edi: 0000000b   ebp: c5e2f340   esp: c601fea4
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 10454, stackpage=c601f000)
Stack: c0144eae c6ef1800 c2910000 c7ff6000 c0148ffd c6ef1800 c021f1c0 c5e2f3a4 
       c01f79b8 c0149246 c7ff6000 c2910000 0000000b fffffff4 c1e85220 c601e000 
       c5e2f340 ffffffea c013abae c1e85220 c5e2f340 c601ff34 00000000 c1e85220 
Call Trace: [<c0144eae>] [<c0148ffd>] [<c0149246>] [<c013abae>] [<c013b2eb>] 
   [<c013bb4e>] [<c014392a>] [<c012fe23>] [<c013013e>] [<c0106c63>] 
Code: f0 ff 48 10 8b 42 24 80 48 14 08 52 e8 0d ff ff ff 83 c4 04 

>>EIP; c0147e62 <proc_delete_inode+32/48>   <=====
Trace; c0144eae <iput+ba/178>
Trace; c0148ffd <proc_pid_make_inode+ad/b8>
Trace; c0149246 <proc_base_lookup+86/23c>
Trace; c013abae <real_lookup+7a/108>
Trace; c013b2eb <path_walk+58f/7c4>
Trace; c013bb4e <open_namei+86/598>
Trace; c014392a <destroy_inode+1a/20>
Trace; c012fe23 <filp_open+3b/5c>
Trace; c013013e <sys_open+36/cc>
Trace; c0106c63 <system_call+33/38>
Code;  c0147e62 <proc_delete_inode+32/48>
0000000000000000 <_EIP>:
Code;  c0147e62 <proc_delete_inode+32/48>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c0147e66 <proc_delete_inode+36/48>
   4:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c0147e69 <proc_delete_inode+39/48>
   7:   80 48 14 08               orb    $0x8,0x14(%eax)
Code;  c0147e6d <proc_delete_inode+3d/48>
   b:   52                        push   %edx
Code;  c0147e6e <proc_delete_inode+3e/48>
   c:   e8 0d ff ff ff            call   ffffff1e <_EIP+0xffffff1e> c0147d80 <de_put+0/b0>
Code;  c0147e73 <proc_delete_inode+43/48>
  11:   83 c4 04                  add    $0x4,%esp


1 warning issued.  Results may not be reliable.
