Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUCJBjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 20:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUCJBjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 20:39:45 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:29639 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S262053AbUCJBjl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 20:39:41 -0500
Date: Wed, 10 Mar 2004 01:39:33 +0000
From: Adam Sampson <azz@us-lot.org>
To: urban@teststation.com
Cc: linux-kernel@vger.kernel.org
Subject: smbfs Oops with Linux 2.6.3
Message-ID: <20040310013933.GA19137@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Homepage: http://offog.org/
User-Agent: Mutt/1.5.5i
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya.

I use smbfs on my x86 Linux 2.6.3 machine to mount filesystems from a
(Debian) Samba 3.0.0beta2 server. This has worked fine with both this
kernel and previous ones for the last few months, but I've just had an
Oops message while trying to open a directory with ROX-Filer. The
filesystem in question is automounted (using autofs4), and this would
have been the first operation upon it after being mounted.

My kernel config is at <http://offog.org/stuff/config-2.6.3>. Here's the
ksymoops output:

ksymoops 2.4.9 on i686 2.6.3.  Options used
     -v /src/linux-2.6.3/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.3/ (default)
     -m /src/linux-2.6.3/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
eax: ee433c40   ebx: 00000002   ecx: c5107840   edx: cf84bfa0
esi: c0165560   edi: c1750080   ebp: cf84bf68   esp: cf84bef8
ds: 007b   es: 007b   ss: 0068
Stack: c01dbbfb c5107840 cf84bfa0 c0165560 cf84bf2c 00000000 00000002 00000004 
       d4ea7ee4 00000000 eecd0000 c40520c0 d0a0c980 00000000 5e50af11 00000000 
       00000000 00000000 eecd0000 00000002 00000000 00000000 00000001 00000004 
Call Trace:
 [<c01dbbfb>] smb_readdir+0x4fb/0x6e0
 [<c0165560>] filldir64+0x0/0x130
 [<c016524a>] vfs_readdir+0x8a/0x90
 [<c0165560>] filldir64+0x0/0x130
 [<c01656fd>] sys_getdents64+0x6d/0xa6
 [<c0165560>] filldir64+0x0/0x130
 [<c010adff>] syscall_call+0x7/0xb
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; ee433c40 <_end+2dc7cad8/3f846e98>
>>ecx; c5107840 <_end+49506d8/3f846e98>
>>edx; cf84bfa0 <_end+f094e38/3f846e98>
>>esi; c0165560 <filldir64+0/130>
>>edi; c1750080 <_end+f98f18/3f846e98>
>>ebp; cf84bf68 <_end+f094e00/3f846e98>
>>esp; cf84bef8 <_end+f094d90/3f846e98>

Trace; c01dbbfb <smb_readdir+4fb/6e0>
Trace; c0165560 <filldir64+0/130>
Trace; c016524a <vfs_readdir+8a/90>
Trace; c0165560 <filldir64+0/130>
Trace; c01656fd <sys_getdents64+6d/a6>
Trace; c0165560 <filldir64+0/130>
Trace; c010adff <syscall_call+7/b>


1 error issued.  Results may not be reliable.

And here's the raw Oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00210246
EIP is at 0x0
eax: ee433c40   ebx: 00000002   ecx: c5107840   edx: cf84bfa0
esi: c0165560   edi: c1750080   ebp: cf84bf68   esp: cf84bef8
ds: 007b   es: 007b   ss: 0068
Process ROX-Filer (pid: 19894, threadinfo=cf84a000 task=d0b93320)
Stack: c01dbbfb c5107840 cf84bfa0 c0165560 cf84bf2c 00000000 00000002 00000004 
       d4ea7ee4 00000000 eecd0000 c40520c0 d0a0c980 00000000 5e50af11 00000000 
       00000000 00000000 eecd0000 00000002 00000000 00000000 00000001 00000004 
Call Trace:
 [<c01dbbfb>] smb_readdir+0x4fb/0x6e0
 [<c0165560>] filldir64+0x0/0x130
 [<c016524a>] vfs_readdir+0x8a/0x90
 [<c0165560>] filldir64+0x0/0x130
 [<c01656fd>] sys_getdents64+0x6d/0xa6
 [<c0165560>] filldir64+0x0/0x130
 [<c010adff>] syscall_call+0x7/0xb

Code:  Bad EIP value.

If there's any other information that'd be useful, please let me know.

Thanks,

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
