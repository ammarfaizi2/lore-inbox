Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264108AbRFSKU7>; Tue, 19 Jun 2001 06:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264117AbRFSKUt>; Tue, 19 Jun 2001 06:20:49 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:56490 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S264108AbRFSKUi>; Tue, 19 Jun 2001 06:20:38 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Oops 2.4.5-pre5 - problem with threads and hdd 
Message-ID: <3B2F2770.38D26AE@i.am>
Date: Tue, 19 Jun 2001 10:20:32 GMT
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5-RTL3.0 i686)
Organization: unknown
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

System: SMP BP6 2x480 Celeron 192MB  IMB30GB  G400

Oops occured while I'm tunning multithreaded application 
while recreating new thread.

Lately I'm having a lot of complete deadlocks also
(this lock has been the lucky one as I could actually report it)

Usual symptoms - doing heavy disk transfers with caching thread
Before my application was not that fast - but as the speed goes up,
hard-locking in kernel seems to be appearing more and more offten.
I'm using around 7 threads and continuously adding new broadcast,
cond_wait
communication. But during last few days I've got up-to 7 deadlocks in a
day -
this is really becoming borring - I've also tested 2.4.5-ac9 &
2.4.5-ac13
both these kernel also lock with similiar conditions.
For more details just ask me (and it's the hardware fault,
nor the problem of RTL3.0 as -ac9 & -ac13 were both used without this
patch and were locking similary)

Here is an Oops


ksymoops 2.3.7 on i686 2.4.5-pre5-RTL3.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-pre5-RTL3.0/ (default)
     -m /usr/src/linux/System.map (default)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
c014c9ae
Oops: 0002
CPU:    1
EIP:    0010:[<c014c9ae>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000002   ebx: c9705400   ecx: c0248afc   edx: c9df4000
esi: c0248c60   edi: 00000002   ebp: ca9283a0   esp: c56fbe84
ds: 0018   es: 0018   ss: 0018
Process top (pid: 27600, stackpage=c56fb000)
Stack: c01473be c9705400 c9df4000 c133e000 c014dbbd c9705400 00007fdd
c9df4000 
       c133c040 c014e1ae c133e000 c9df4000 00000002 c133c040 ca9283a0
c133c040 
       ca9283a0 ffffffff ca928405 c014cd19 c133c040 ca9283a0 fffffff4
c56fa000 
Call Trace: [<c01473be>] [<c014dbbd>] [<c014e1ae>] [<c014cd19>]
[<c013c78a>] [<c013cc29>] [<c013d92e>] 
       [<c0144ab9>] [<c0131513>] [<c0131844>] [<c0106d2f>] [<c010002b>] 
Code: f0 ff 48 10 8b 42 24 80 48 14 08 52 e8 e1 fe ff ff 83 c4 04 

>>EIP; c014c9ae <proc_delete_inode+32/48>   <=====
Trace; c01473be <iput+ba/16c>
Trace; c014dbbd <proc_pid_make_inode+ad/b8>
Trace; c014e1ae <proc_pid_lookup+17a/1e0>
Trace; c014cd19 <proc_root_lookup+39/48>
Trace; c013c78a <real_lookup+7a/120>
Trace; c013cc29 <path_walk+28d/8a4>
Trace; c013d92e <open_namei+86/608>
Trace; c0144ab9 <dput+19/154>
Trace; c0131513 <filp_open+3b/5c>
Trace; c0131844 <sys_open+3c/f0>
Trace; c0106d2f <system_call+37/3c>
Trace; c010002b <startup_32+2b/cb>
Code;  c014c9ae <proc_delete_inode+32/48>
00000000 <_EIP>:
Code;  c014c9ae <proc_delete_inode+32/48>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c014c9b2 <proc_delete_inode+36/48>
   4:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c014c9b5 <proc_delete_inode+39/48>
   7:   80 48 14 08               orb    $0x8,0x14(%eax)
Code;  c014c9b9 <proc_delete_inode+3d/48>
   b:   52                        push   %edx
Code;  c014c9ba <proc_delete_inode+3e/48>
   c:   e8 e1 fe ff ff            call   fffffef2 <_EIP+0xfffffef2>
c014c8a0 <de_put+0/dc>
Code;  c014c9bf <proc_delete_inode+43/48>
  11:   83 c4 04                  add    $0x4,%esp

