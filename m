Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSEQTlT>; Fri, 17 May 2002 15:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSEQTlS>; Fri, 17 May 2002 15:41:18 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:24071 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S316663AbSEQTlQ>; Fri, 17 May 2002 15:41:16 -0400
Date: Fri, 17 May 2002 14:59:08 -0400 (EDT)
From: Peter Rival <frival@zk3.dec.com>
To: <linux-kernel@vger.kernel.org>
Subject: Oops on 2.5.15 with ext3 & AIM 7 shared workload
Message-ID: <Pine.LNX.4.32.0205171451440.19851-100000@harley.zk3.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently built a 2x300MHz P2 system with 512MB of memory for a simple
x86 testbed.  To start with, I ran the AIM VII shared workload on the
system, using the 18 SCSI disks that I have available with ext2
filesystems.  I got the following oops when I rebooted and started the run
with ext3.  This was only at the simulated '100 users' load point; the
system is capable of ~1100 simulated users (i.e. the system was hardly
heavily loaded).  Does this look familiar to anyone, or is there
somehting anyone needs me to do?  Thanks!

 - Pete

Assertion failure in journal_commit_transaction() at commit.c:523:
"buffer_jdirty(bh)"
kernel BUG at commit.c:523!
invalid operand: 0000
CPU:    0
EIP:    0010:[journal_commit_transaction+3278/4226]    Not tainted
EIP:    0010:[<c016ebde>]    Not tainted
EFLAGS: 00010286
eax: 0000005a   ebx: c4fce820   ecx: c033e4a0   edx: dd943040
esi: c9acca30   edi: 00000009   ebp: c3ffb2a0   esp: c504fe28
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 1013, threadinfo=c504e000 task=df56afc0)
Stack: c029f7e0 c029f7b3 c029f7aa 0000020b c029fc05 00000000 00000fb4
cd9e604c 00000000 c36a
Call Trace: [__switch_to+68/304] [schedule+527/1056] [kjournald+581/640]
[commit_timeout+0/1
Call Trace: [<c0105a04>] [<c011215f>] [<c0170f45>] [<c0170ce0>]
[<c0105736>] [kjournald+0/64
Code: 0f 0b 0b 02 aa f7 29 c0 83 c4 14 e9 82 f9 ff ff 89 f6 68 20

[root@linux linux-2.5]# ksymoops < oops
ksymoops 2.4.0 on i686 2.5.15.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.15/ (default)
     -m ./System.map (specified)

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in
System.map.  Ignorin
Warning (compare_maps): ksyms_base symbol GPLONLY_set_cpus_allowed not
found in System.map.
kernel BUG at commit.c:523!
invalid operand: 0000
CPU:    0
EIP:    0010:[journal_commit_transaction+3278/4226]    Not tainted
EIP:    0010:[<c016ebde>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000005a   ebx: c4fce820   ecx: c033e4a0   edx: dd943040
esi: c9acca30   edi: 00000009   ebp: c3ffb2a0   esp: c504fe28
ds: 0018   es: 0018   ss: 0018
ack: c029f7e0 c029f7b3 c029f7aa 0000020b c029fc05 00000000 00000fb4
cd9e604c 00000000 c36a
Call Trace: [__switch_to+68/304] [schedule+527/1056] [kjournald+581/640]
[commit_timeout+0/1
Call Trace: [<c0105a04>] [<c011215f>] [<c0170f45>] [<c0170ce0>]
[<c0105736>] [kjournald+0/64
Code: 0f 0b 0b 02 aa f7 29 c0 83 c4 14 e9 82 f9 ff ff 89 f6 68 20

>>EIP; c016ebde <journal_commit_transaction+cce/1082>   <=====
Trace; c0105a04 <__switch_to+44/130>
Trace; c011215f <schedule+20f/420>
Trace; c0170f45 <kjournald+245/280>
Trace; c0170ce0 <commit_timeout+0/10>
Trace; c0105736 <kernel_thread+26/30>
Code;  c016ebde <journal_commit_transaction+cce/1082>
00000000 <_EIP>:
Code;  c016ebde <journal_commit_transaction+cce/1082>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016ebe0 <journal_commit_transaction+cd0/1082>
   2:   0b 02                     or     (%edx),%eax
Code;  c016ebe2 <journal_commit_transaction+cd2/1082>
   4:   aa                        stos   %al,%es:(%edi)
Code;  c016ebe3 <journal_commit_transaction+cd3/1082>
   5:   f7 29                     imul   (%ecx),%eax
Code;  c016ebe5 <journal_commit_transaction+cd5/1082>
   7:   c0 83 c4 14 e9 82 f9      rolb   $0xf9,0x82e914c4(%ebx)
Code;  c016ebec <journal_commit_transaction+cdc/1082>
   e:   ff                        (bad)
Code;  c016ebed <journal_commit_transaction+cdd/1082>
   f:   ff 89 f6 68 20 00         decl   0x2068f6(%ecx)


2 warnings issued.  Results may not be reliable.


