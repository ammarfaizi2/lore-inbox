Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWIOUk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWIOUk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWIOUk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:40:58 -0400
Received: from smtp-out-45.synserver.de ([217.119.50.45]:4789 "HELO
	blue-ld-125.synserver.de") by vger.kernel.org with SMTP
	id S932233AbWIOUk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:40:57 -0400
X-SynServer-RemoteDnsName: port-212-202-34-169.dynamic.qsc.de
X-SynServer-AuthUser: markus@trippelsdorf.de
Date: Fri, 15 Sep 2006 22:40:55 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc7 Unable to handle kernel paging request
Message-ID: <20060915204055.GA30389@gentoox2.trippelsdorf.de>
References: <20060913210307.GA6915@gentoox2.trippelsdorf.de> <1158343173.31501.26.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158343173.31501.26.camel@dyn9047017100.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 10:59:33AM -0700, Badari Pulavarty wrote:
> On Wed, 2006-09-13 at 23:03 +0200, Markus Trippelsdorf wrote:
> > Don't know what to make of these kernel error messages.
> > This happened an hour ago and the system kept running until I rebooted.
> > 
> > Unable to handle kernel paging request at ffffffff004c82c8 RIP:
> >  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
> > PGD 203027 PUD 0
> > CPU 0
> > Modules linked in: tuner bttv video_buf ir_common compat_ioctl32 btcx_risc tveeprom videodev v4l1_compat v4l2_common
> > Pid: 24497, comm: emake Not tainted 2.6.18-rc7 #1
> > RIP: 0010:[<ffffffff80222a24>]  [<ffffffff80222a24>] generic_file_mmap+0x14/0x50
> > RSP: 0018:ffff81005db69e98  EFLAGS: 00010206
> > RAX: ffffffff004c82c0 RBX: ffff810010252528 RCX: 0000000000000000
> > RDX: 00000000fffffff8 RSI: ffff810010252528 RDI: ffff810023234bc0
> > RBP: ffff810023234bc0 R08: 0000000000000000 R09: ffff810010252528
> > R10: ffff810023c1fde0 R11: ffff810023c1fde0 R12: 00000000ffffffea
> > R13: ffff81007eb04840 R14: 0000000000000000 R15: 00000000000d7000
> > FS:  00002acdf4b126d0(0000) GS:ffffffff80610000(0000) knlGS:00000000f73456b0
> > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > CR2: ffffffff004c82c8 CR3: 0000000063292000 CR4: 00000000000006e0
> > Process emake (pid: 24497, threadinfo ffff81005db68000, task ffff81001b7f6040)
> > Stack:  ffff810010252528 ffffffff8020de0b 0000000000000000 0000000044fc8613
> >  0000000000000000 0000000000000071 0000000000000002 ffff8100167b2a70
> >  0000000000000071 0000000000000000 00000000000000d7 ffffffff8022ca5e
> > Call Trace:
> >  [<ffffffff8020de0b>] do_mmap_pgoff+0x4bb/0x790
> >  [<ffffffff8022ca5e>] sys_newfstat+0x2e/0x50
> >  [<ffffffff80224965>] sys_mmap+0xa5/0x100
> >  [<ffffffff8026255e>] system_call+0x7e/0x83
> > Code: 48 83 78 08 00 74 22 f6 47 2e 04 75 0f 48 8b 77 10 48 8b 7f
> 
> Are you able to reproduce this problem again ?

Unfortunately not. But I guess it must have been a hardware problem.
I switched off CPU frequency scaling and the system is running stable
since then.
If the problem occurs again I will let you know.
Thanks.

> It looks like the problem is due to bogus a_ops ..
> 
>         if (!mapping->a_ops->readpage)
>                          ^^^^^^
> failing instruction is:
> 
>      37c:       48 83 78 08 00          cmpq   $0x0,0x8(%rax)
> 
> (a_ops->readpage) derefence.
-- 
Markus
