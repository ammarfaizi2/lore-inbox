Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTBJQ7p>; Mon, 10 Feb 2003 11:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBJQ7p>; Mon, 10 Feb 2003 11:59:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:54715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265063AbTBJQ7m>;
	Mon, 10 Feb 2003 11:59:42 -0500
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
From: Andy Pfiffer <andyp@osdl.org>
To: suparna@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
In-Reply-To: <20030210164401.A11250@in.ibm.com>
References: <3E448745.9040707@mvista.com>
	 <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com>
	 <m1d6m1z4bk.fsf@frodo.biederman.org>  <20030210164401.A11250@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1044896964.1705.9.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 10 Feb 2003 09:09:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 03:14, Suparna Bhattacharya wrote:
> I am using the OSDL versions of the kexec patches for
> 2.5.59 (plm 1442 and 1444) for lkcd-kexec based crash dump
> work.

<snip>

> 
> Surprisingly though, when I tried just a simple 
> kexec -e today (having loaded the kernel earlier on), 
> I ran into the following Oops, consistently:
> 
> I'm using kexec-tools-1.8, and this has worked for me
> earlier. The test system is a 4way SMP machine.
> 
> Has anyone seen this as well ?  (I'd already issued init 1 
> and unmounted filesystems by this point)
> 
> sh-2.05a# /sbin/kexec -e
> Synchronizing SCSI caches:
> Shutting down devices
> Starting new kernel
> Unable to handle kernel paging request at virtual address 361ae000
>  printing eip:
> c011470a
> *pde = 00000000
> Oops: 0002
> CPU: 0
> EIP: 0060:[<c011470a>] Not tainted
> EFLAGS: 00010003
> EIP is at machine_kexec+0x14a/0x190
> eax: 00000097 ebx: f7742260 ecx: 00000025 edx: 361ac000
> esi: c0114750 edi: 361ae000 ebp: f7365e94 esp: f7365e80
> ds: 007b es: 007b ss: 0068
> 
> Process kexec (pid: 1685, threadinfo=f7364000 task=f6290060)
> Stack: 361ae000 361ac000 f7742260 f7364000 00000000 f7365fbc 
> c0126903 f7742260 c02a71af c03a9aa8 00000001 00000000 f7fe1640
> f7793ec0 c1b3b120 f7364000 00000001 f7365edc c014dbef f7fe1668
> f7fe1668 00000286 f7ff51e0 f7365efc 
> 
> Call Trace: 
> [<c0126903>] sys_reboot+0x363/0x400 
> [<c014dbef>] invalidate_inode_buffers+0xf/0x90 
> [<c01633b0>] clear_inode+0x10/0xb0 
> [<c0238276>] sock_destroy_inode+0x16/0x20 
> [<c016149e>] dput+0x1e/0x170 i
> [<c014cb56>] __fput+0x116/0x140 i
> [<c014b38f>] filp_close+0xcf/0xe0 i
> [<c014b43e>] sys_close+0x9e/0xd0 i
> [<c01091c7>] syscall_call+0x7/0xb i
> 
> Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 e8 84 fe ff ff 6a 00 
> 
> Regards
> Suparna

Yes, I have seen that exact or similar oops when trying kexec for 2.5.59
on a 2-way Xeon system.  The exact same software configuration does
*not* generate that oops on a 1-way P3-800 system.

I've had some difficulty with the serial console on that system, so I
don't yet have an exact traceback and cannot confirm 100% that yours and
mine are identical.

It sure *looks* the same.

Andy


