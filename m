Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTBJK7D>; Mon, 10 Feb 2003 05:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267443AbTBJK7D>; Mon, 10 Feb 2003 05:59:03 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10130 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267441AbTBJK7B>;
	Mon, 10 Feb 2003 05:59:01 -0500
Date: Mon, 10 Feb 2003 16:44:01 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       fastboot@osdl.org
Subject: Re: Kexec on 2.5.59 problems ?
Message-ID: <20030210164401.A11250@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1d6m1z4bk.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Feb 09, 2003 at 11:39:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the OSDL versions of the kexec patches for
2.5.59 (plm 1442 and 1444) for lkcd-kexec based crash dump
work. So far I had only been trying the cases where 
machine_kexec was being invoked directly from (safe)
panics, which worked, i.e. it could successfully kexec and 
save dumps generated via artificially induced panics on
a system that's not doing very much (Not considering harder 
cases or for the moment).

Surprisingly though, when I tried just a simple 
kexec -e today (having loaded the kernel earlier on), 
I ran into the following Oops, consistently:

I'm using kexec-tools-1.8, and this has worked for me
earlier. The test system is a 4way SMP machine.

Has anyone seen this as well ?  (I'd already issued init 1 
and unmounted filesystems by this point)

sh-2.05a# /sbin/kexec -e
Synchronizing SCSI caches:
Shutting down devices
Starting new kernel
Unable to handle kernel paging request at virtual address 361ae000
 printing eip:
c011470a
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0060:[<c011470a>] Not tainted
EFLAGS: 00010003
EIP is at machine_kexec+0x14a/0x190
eax: 00000097 ebx: f7742260 ecx: 00000025 edx: 361ac000
esi: c0114750 edi: 361ae000 ebp: f7365e94 esp: f7365e80
ds: 007b es: 007b ss: 0068

Process kexec (pid: 1685, threadinfo=f7364000 task=f6290060)
Stack: 361ae000 361ac000 f7742260 f7364000 00000000 f7365fbc 
c0126903 f7742260 c02a71af c03a9aa8 00000001 00000000 f7fe1640
f7793ec0 c1b3b120 f7364000 00000001 f7365edc c014dbef f7fe1668
f7fe1668 00000286 f7ff51e0 f7365efc 

Call Trace: 
[<c0126903>] sys_reboot+0x363/0x400 
[<c014dbef>] invalidate_inode_buffers+0xf/0x90 
[<c01633b0>] clear_inode+0x10/0xb0 
[<c0238276>] sock_destroy_inode+0x16/0x20 
[<c016149e>] dput+0x1e/0x170 i
[<c014cb56>] __fput+0x116/0x140 i
[<c014b38f>] filp_close+0xcf/0xe0 i
[<c014b43e>] sys_close+0x9e/0xd0 i
[<c01091c7>] syscall_call+0x7/0xb i

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 e8 84 fe ff ff 6a 00 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

