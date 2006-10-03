Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWJCSCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWJCSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWJCSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:02:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030444AbWJCSCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:02:24 -0400
Date: Tue, 3 Oct 2006 11:01:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.6.18-mm3
Message-Id: <20061003110136.3a572578.akpm@osdl.org>
In-Reply-To: <1159897051.9569.0.camel@dyn9047017100.beaverton.ibm.com>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	<1159897051.9569.0.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 10:37:31 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> On Tue, 2006-10-03 at 00:11 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/
> > 
> > - Added Jeff's make-bogus-warnings-go-away tree to the -mm lineup, as
> >   git-gccbug.patch
> > 
> > - Francois Romieu is doing some qlogic driver maintenance - added his
> >   git-qla3xxx.patch to the -mm lineup.
> > 
> > - Some wireless-related crashes are hopefully fixed.  But if there are still
> >   wireless problems, be sure that you have the latest userspace tools.
> > 
> > - The recent spate of IRQ-allocation-related crashes on x86_64 is hopefully
> >   fixed.
> > 
> > - As far as we know, the MSI handling in -mm is now rock-solid.
> 
> 
> Not having any luck with it :(
> 

You never do ;)

We'd make better progress if you could bisect these failures.

> 
> Kernel command line: root=/dev/hda2 vga=0x314  selinux=0   console=tty0
> console=ttyS0,38400 resume=/dev/hda1 resume=/dev/hda1  splash=silent
> showopts
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
> Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
> Checking aperture...
> CPU 0: aperture @ 0 size 32 MB
> No AGP bridge found
> Your BIOS doesn't leave a aperture memory hole
> Please enable the IOMMU option in the BIOS setup
> This costs you 64 MB of RAM
> Mapping aperture over 65536 KB of RAM @ 4000000
> Memory: 7147724k/7864320k available (2924k kernel code, 191856k
> reserved, 1697k data, 360k init)
> ------------[ cut here ]------------
> kernel BUG in init_list at mm/slab.c:1334!
> invalid opcode: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 0, comm: swapper Not tainted 2.6.18-mm3 #1
> RIP: 0010:[<ffffffff8027bd5b>]  [<ffffffff8027bd5b>] init_list
> +0x2b/0x120
> RSP: 0018:ffffffff806d9f18  EFLAGS: 00010212
> RAX: 000000000000003f RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffff8072b0a8 RDI: ffff81017a800040
> RBP: ffffffff806d9f48 R08: 0000000000000001 R09: 0000000000000003
> R10: 0000000000000000 R11: ffffffff8072cac8 R12: 0000000000000001
> R13: ffff81017a800040 R14: ffffffff8072b0a8 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff80684000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006a0
> Process swapper (pid: 0, threadinfo ffffffff806d8000, task
> ffffffff805f7bc0)
> Stack:  ffffffff806d9f48 0000000100000286 0000000000000001
> ffffffff8072b0a8
>  0000000000000040 0000000000000000 ffffffff806d9f98 ffffffff806fdc69
>  0000000000000168 0000000000000240 0000000100000001 0000000000090000
> Call Trace:
>  [<ffffffff806fdc69>] kmem_cache_init+0x3b9/0x490
>  [<ffffffff806e36ef>] start_kernel+0x18f/0x220
>  [<ffffffff806e3176>] _sinittext+0x176/0x180
> 
> 
> Code: 0f 0b 66 66 90 48 8b 3d b1 ae 38 00 be d0 00 00 00 e8 0f ff
> RIP  [<ffffffff8027bd5b>] init_list+0x2b/0x120
>  RSP <ffffffff806d9f18>
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!

http://userweb.kernel.org/~akpm/badari2.bz2 is a rollup against 2.6.18
which omits the various zone changes.  Can you see if that also fails?

Thanks.
