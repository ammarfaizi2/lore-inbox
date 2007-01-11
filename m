Return-Path: <linux-kernel-owner+w=401wt.eu-S965004AbXAKDet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbXAKDet (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXAKDet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:34:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:41086 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965004AbXAKDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:34:49 -0500
Date: Thu, 11 Jan 2007 14:34:30 +1100
From: David Chinner <dgc@sgi.com>
To: Janos Haar <djani22@netcenter.hu>
Cc: David Chinner <dgc@sgi.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: xfslogd-spinlock bug?
Message-ID: <20070111033430.GA33919298@melbourne.sgi.com>
References: <026501c72237$0464f7a0$0400a8c0@dcccs> <20061218062444.GH44411608@melbourne.sgi.com> <027b01c7227d$0e26d1f0$0400a8c0@dcccs> <20061218223637.GP44411608@melbourne.sgi.com> <001a01c722fd$df5ca710$0400a8c0@dcccs> <20061219025229.GT33919298@melbourne.sgi.com> <20061219044700.GW33919298@melbourne.sgi.com> <041601c729b6$f81e4af0$0400a8c0@dcccs> <20070107231402.GU44411608@melbourne.sgi.com> <049c01c734db$5089aa70$0400a8c0@dcccs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049c01c734db$5089aa70$0400a8c0@dcccs>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:18:08PM +0100, Janos Haar wrote:
> From: "David Chinner" <dgc@sgi.com>
> > Different corruption in RBX here. Looks like semi-random garbage there.
> > I wonder - what's the mac and ip address(es) of your machine and nbd
> > servers?
> 
> dy-base:

no matches. Oh well, it was a long shot.

> Some new stuff:
> Jan  8 18:11:16 dy-base RAX: ffffffff80810800 RBX: 000004f0e2850659 RCX:

RBX trashed again with more random garbage.

> Jan  8 18:11:16 dy-base  [<ffffffff80223f81>] default_wake_function+0xd/0xf
> Jan  8 18:11:16 dy-base  [<ffffffff8023c81d>]
> autoremove_wake_function+0x11/0x38
> Jan  8 18:11:16 dy-base  [<ffffffff802225b1>] __wake_up_common+0x3e/0x68
> Jan  8 18:11:16 dy-base  [<ffffffff80222ac9>] __wake_up+0x38/0x50
> Jan  8 18:11:16 dy-base  [<ffffffff80569d1c>]
> sk_stream_write_space+0x5d/0x83
> Jan  8 18:11:16 dy-base  [<ffffffff80591afd>] tcp_check_space+0x8f/0xcd
> Jan  8 18:11:16 dy-base  [<ffffffff80596de0>]
> tcp_rcv_established+0x116/0x76e
> Jan  8 18:11:16 dy-base  [<ffffffff8059ce41>] tcp_v4_do_rcv+0x2d/0x322
> Jan  8 18:11:16 dy-base  [<ffffffff8059f59e>] tcp_v4_rcv+0x8bb/0x925
> Jan  8 18:11:16 dy-base  [<ffffffff80583b24>]
> ip_local_deliver_finish+0x0/0x1ce
> Jan  8 18:11:16 dy-base  [<ffffffff805843e6>] ip_local_deliver+0x172/0x238
> Jan  8 18:11:16 dy-base  [<ffffffff8058422c>] ip_rcv+0x44f/0x497
> Jan  8 18:11:16 dy-base  [<ffffffff88004bbc>]
> :e1000:e1000_alloc_rx_buffers+0x1e7/0x2cb
> Jan  8 18:11:16 dy-base  [<ffffffff8056c0a6>] netif_receive_skb+0x1ee/0x255
> Jan  8 18:11:16 dy-base  [<ffffffff8056de0c>] process_backlog+0x8a/0x10f
> Jan  8 18:11:16 dy-base  [<ffffffff8056e060>] net_rx_action+0xa9/0x16e
> Jan  8 18:11:16 dy-base  [<ffffffff8022edf9>] __do_softirq+0x57/0xc7
> Jan  8 18:11:16 dy-base  [<ffffffff8020aa1c>] call_softirq+0x1c/0x28
> Jan  8 18:11:16 dy-base  [<ffffffff8020c68a>] do_softirq+0x34/0x87
> Jan  8 18:11:16 dy-base  [<ffffffff8022ed0f>] irq_exit+0x3f/0x41
> Jan  8 18:11:16 dy-base  [<ffffffff8020c786>] do_IRQ+0xa9/0xc7
> Jan  8 18:11:16 dy-base  [<ffffffff80209e11>] ret_from_intr+0x0/0xa
......
> > (i.e. I suspect this is a nbd problem, not an XFS problem)

There's something seriously wrong in your kernel that has, AFAICT,
nothing to do with XFS. I suggest talking to the NBD folk as that is
the only unusualy thing that I can see that you are using....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
