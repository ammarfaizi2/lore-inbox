Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbXAJRT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbXAJRT1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbXAJRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:19:27 -0500
Received: from ns.netcenter.hu ([195.228.254.57]:43740 "EHLO netcenter.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964972AbXAJRT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:19:26 -0500
Message-ID: <049c01c734db$5089aa70$0400a8c0@dcccs>
From: "Janos Haar" <djani22@netcenter.hu>
To: "David Chinner" <dgc@sgi.com>
Cc: <dgc@sgi.com>, <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
References: <000d01c72127$3d7509b0$0400a8c0@dcccs> <20061217224457.GN33919298@melbourne.sgi.com> <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs> <20061219025229.GT33919298@melbourne.sgi.com> <20061219044700.GW33919298@melbourne.sgi.com> <041601c729b6$f81e4af0$0400a8c0@dcccs> <20070107231402.GU44411608@melbourne.sgi.com>
Subject: Re: xfslogd-spinlock bug?
Date: Wed, 10 Jan 2007 18:18:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "David Chinner" <dgc@sgi.com>
To: "Haar János" <djani22@netcenter.hu>
Cc: "David Chinner" <dgc@sgi.com>; <linux-xfs@oss.sgi.com>;
<linux-kernel@vger.kernel.org>
Sent: Monday, January 08, 2007 12:14 AM
Subject: Re: xfslogd-spinlock bug?


> On Wed, Dec 27, 2006 at 01:58:06PM +0100, Haar János wrote:
> > Hello,
> >
> > ----- Original Message ----- 
> > From: "David Chinner" <dgc@sgi.com>
> > To: "David Chinner" <dgc@sgi.com>
> > Cc: "Haar János" <djani22@netcenter.hu>; <linux-xfs@oss.sgi.com>;
> > <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, December 19, 2006 5:47 AM
> > Subject: Re: xfslogd-spinlock bug?
> >
> >
> > > On Tue, Dec 19, 2006 at 01:52:29PM +1100, David Chinner wrote:
> > >
> > > The filesystem was being shutdown so xfs_inode_item_destroy() just
> > > frees the inode log item without removing it from the AIL. I'll fix
that,
> > > and see if i have any luck....
> > >
> > > So I'd still try that patch i sent in the previous email...
> >
> > I still using the patch, but didnt shows any messages at this point.
> >
> > I'v got 3 crash/reboot, but 2 causes nbd disconneted, and this one:
> >
> > Dec 27 13:41:29 dy-base BUG: warning at
> > kernel/mutex.c:220/__mutex_unlock_common_slowpath()
> > Dec 27 13:41:29 dy-base Unable to handle kernel paging request at
> > 0000000066604480 RIP:
> > Dec 27 13:41:29 dy-base  [<ffffffff80222c64>] resched_task+0x12/0x64
> > Dec 27 13:41:29 dy-base PGD 115246067 PUD 0
> > Dec 27 13:41:29 dy-base Oops: 0000 [1] SMP
> > Dec 27 13:41:29 dy-base CPU 1
> > Dec 27 13:41:29 dy-base Modules linked in: nbd rd netconsole e1000 video
> > Dec 27 13:41:29 dy-base Pid: 4069, comm: httpd Not tainted 2.6.19 #3
> > Dec 27 13:41:29 dy-base RIP: 0010:[<ffffffff80222c64>]
[<ffffffff80222c64>]
> > resched_task+0x12/0x64
> > Dec 27 13:41:29 dy-base RSP: 0018:ffff810105c01b78  EFLAGS: 00010083
> > Dec 27 13:41:29 dy-base RAX: ffffffff807d5800 RBX: 00001749fd97c214 RCX:
>
> Different corruption in RBX here. Looks like semi-random garbage there.
> I wonder - what's the mac and ip address(es) of your machine and nbd
> servers?

dy-base:
eth0      Link encap:Ethernet  HWaddr 00:90:27:A2:7B:8B
eth0:1    Link encap:Ethernet  HWaddr 00:90:27:A2:7B:8B
eth0:2    Link encap:Ethernet  HWaddr 00:90:27:A2:7B:8B
eth1      Link encap:Ethernet  HWaddr 00:07:E9:32:E6:D8
eth1:1    Link encap:Ethernet  HWaddr 00:07:E9:32:E6:D8
eth1:2    Link encap:Ethernet  HWaddr 00:07:E9:32:E6:D8
eth2      Link encap:Ethernet  HWaddr 00:07:E9:32:E6:D9

node1-4:

00:0E:0C:A0:E5:7E
00:0E:0C:A0:EF:5E
00:0E:0C:A0:E9:58
00:0E:0C:A0:EF:A3

Some new stuff:
Jan  8 18:11:16 dy-base BUG: warning at
kernel/mutex.c:220/__mutex_unlock_common_slowpath()
Jan  8 18:11:16 dy-base Unable to handle kernel NULL pointer dereference at
0000000000000008 RIP:
Jan  8 18:11:16 dy-base  [<ffffffff80222c74>] resched_task+0x1a/0x64
Jan  8 18:11:16 dy-base PGD 9859d067 PUD 4e347067 PMD 0
Jan  8 18:11:16 dy-base Oops: 0000 [1] SMP
Jan  8 18:11:16 dy-base CPU 3
Jan  8 18:11:16 dy-base Modules linked in: nbd rd netconsole e1000
Jan  8 18:11:16 dy-base Pid: 3471, comm: ls Not tainted 2.6.19 #4
Jan  8 18:11:16 dy-base RIP: 0010:[<ffffffff80222c74>]  [<ffffffff80222c74>]
resched_task+0x1a/0x64
Jan  8 18:11:16 dy-base RSP: 0000:ffff81011fd1fb10  EFLAGS: 00010097
Jan  8 18:11:16 dy-base RAX: ffffffff80810800 RBX: 000004f0e2850659 RCX:
ffff81010c0a2000
Jan  8 18:11:16 dy-base RDX: 0000000000000000 RSI: ffff81000583c368 RDI:
ffff81002b809830
Jan  8 18:11:16 dy-base RBP: ffff81011fd1fb10 R08: 0000000000000000 R09:
0000000000000080
Jan  8 18:11:16 dy-base R10: 0000000000000080 R11: ffff81000584d280 R12:
ffff8100d852a7b0
Jan  8 18:11:16 dy-base R13: 0000000000000003 R14: 0000000000000001 R15:
0000000000000001
Jan  8 18:11:16 dy-base FS:  00002b69786c8a90(0000)
GS:ffff81011fcb98c0(0000) knlGS:0000000000000000
Jan  8 18:11:16 dy-base CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jan  8 18:11:16 dy-base CR2: 0000000000000008 CR3: 0000000056ec5000 CR4:
00000000000006e0
Jan  8 18:11:16 dy-base Process ls (pid: 3471, threadinfo ffff810080d80000,
task ffff8100dcdea770)
Jan  8 18:11:16 dy-base Stack:  ffff81011fd1fb90 ffffffff80223f3f
ffff81011fd1fb50 0000000000000282
Jan  8 18:11:16 dy-base  0000000000000001 0000000000000001 ffff81000583ba00
00000003032ca4b8
Jan  8 18:11:16 dy-base  000000000000000a 0000000000000082 ffff810103539d00
ffff810013867bf8
Jan  8 18:11:16 dy-base Call Trace:
Jan  8 18:11:16 dy-base  <IRQ>  [<ffffffff80223f3f>]
try_to_wake_up+0x3a7/0x3dc
Jan  8 18:11:16 dy-base  [<ffffffff80223f81>] default_wake_function+0xd/0xf
Jan  8 18:11:16 dy-base  [<ffffffff8023c81d>]
autoremove_wake_function+0x11/0x38
Jan  8 18:11:16 dy-base  [<ffffffff802225b1>] __wake_up_common+0x3e/0x68
Jan  8 18:11:16 dy-base  [<ffffffff80222ac9>] __wake_up+0x38/0x50
Jan  8 18:11:16 dy-base  [<ffffffff80569d1c>]
sk_stream_write_space+0x5d/0x83
Jan  8 18:11:16 dy-base  [<ffffffff80591afd>] tcp_check_space+0x8f/0xcd
Jan  8 18:11:16 dy-base  [<ffffffff80596de0>]
tcp_rcv_established+0x116/0x76e
Jan  8 18:11:16 dy-base  [<ffffffff8059ce41>] tcp_v4_do_rcv+0x2d/0x322
Jan  8 18:11:16 dy-base  [<ffffffff8059f59e>] tcp_v4_rcv+0x8bb/0x925
Jan  8 18:11:16 dy-base  [<ffffffff80583b24>]
ip_local_deliver_finish+0x0/0x1ce
Jan  8 18:11:16 dy-base  [<ffffffff805843e6>] ip_local_deliver+0x172/0x238
Jan  8 18:11:16 dy-base  [<ffffffff8058422c>] ip_rcv+0x44f/0x497
Jan  8 18:11:16 dy-base  [<ffffffff88004bbc>]
:e1000:e1000_alloc_rx_buffers+0x1e7/0x2cb
Jan  8 18:11:16 dy-base  [<ffffffff8056c0a6>] netif_receive_skb+0x1ee/0x255
Jan  8 18:11:16 dy-base  [<ffffffff8056de0c>] process_backlog+0x8a/0x10f
Jan  8 18:11:16 dy-base  [<ffffffff8056e060>] net_rx_action+0xa9/0x16e
Jan  8 18:11:16 dy-base  [<ffffffff8022edf9>] __do_softirq+0x57/0xc7
Jan  8 18:11:16 dy-base  [<ffffffff8020aa1c>] call_softirq+0x1c/0x28
Jan  8 18:11:16 dy-base  [<ffffffff8020c68a>] do_softirq+0x34/0x87
Jan  8 18:11:16 dy-base  [<ffffffff8022ed0f>] irq_exit+0x3f/0x41
Jan  8 18:11:16 dy-base  [<ffffffff8020c786>] do_IRQ+0xa9/0xc7
Jan  8 18:11:16 dy-base  [<ffffffff80209e11>] ret_from_intr+0x0/0xa
Jan  8 18:11:16 dy-base  <EOI>
Jan  8 18:11:16 dy-base
Jan  8 18:11:16 dy-base Code: 48 03 42 08 8b 00 85 c0 7e 0a 0f 0b 68 ed 80
64 80 c2 f0 03
Jan  8 18:11:16 dy-base RIP  [<ffffffff80222c74>] resched_task+0x1a/0x64
Jan  8 18:11:16 dy-base  RSP <ffff81011fd1fb10>
Jan  8 18:11:16 dy-base CR2: 0000000000000008
Jan  8 18:11:16 dy-base  <0>Kernel panic - not syncing: Fatal exception
Jan  8 18:11:16 dy-base
Jan  8 18:11:16 dy-base Rebooting in 5 seconds..

(i have disabled the slab debuggint, because i need more perf.)

Thanks,
Janos

>
> (i.e. I suspect this is a nbd problem, not an XFS problem)
>
> Cheers,
>
> Dave.
> -- 
> Dave Chinner
> Principal Engineer
> SGI Australian Software Group
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

