Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVLATSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVLATSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVLATSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:18:17 -0500
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:37780 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932401AbVLATSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:18:16 -0500
Date: Thu, 1 Dec 2005 21:18:33 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20051129092432.0f5742f0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005, Andrew Morton wrote:

> 
> 
> Begin forwarded message:
> 
> Date: Tue, 29 Nov 2005 10:44:09 -0500
> From: Ryan Richter <ryan@tau.solarneutrino.net>
> To: linux-kernel@vger.kernel.org
> Cc: ryan@tau.solarneutrino.net
> Subject: crash on x86_64 - mm related?
> 
> 
> Hi, I booted 2.6.14.2 with the MPT fusion performance fix patch about a
> week ago on my file server.  The machine crashed lat night while it was
> doing backups.  You can see the voluminous kernel output below.
> 
> Someone else recently had seemingly the same thing happen, but didn't
> think it was a kernel problem.  You can read about it here:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=338335
> 
> I will reply later today with the kernel .config, right now I have to
> wait for someone to reboot the machine first.
> 
> Any help would be appreciated,
> -ryan
> 
>  Bad page state at free_hot_cold_page (in process 'taper', page ffff81000260b6f8)
> flags:0x010000000000000c mapping:ffff8100355f1dd8 mapcount:2 count:0
> Backtrace:
> 
> Call Trace:<ffffffff80159f93>{bad_page+99} <ffffffff8015a965>{free_hot_cold_page+101}
>        <ffffffff80162007>{__page_cache_release+151} <ffffffff802b8fe8>{sgl_unmap_user_pages+120}
>        <ffffffff802b48fb>{release_buffering+27} <ffffffff802b4fb1>{st_write+1697}
>        <ffffffff8017af46>{vfs_write+198} <ffffffff8017b0a3>{sys_write+83}
>        <ffffffff8010db7a>{system_call+126} 
> Trying to fix it up, but a reboot is needed
> Bad page state at free_hot_cold_page (in process 'taper', page ffff81000260b6f8)
> flags:0x010000000000081c mapping:ffff81005c0fc310 mapcount:0 count:0
> Backtrace:
> 
> Call Trace:<ffffffff80159f93>{bad_page+99} <ffffffff8015a965>{free_hot_cold_page+101}
>        <ffffffff80162007>{__page_cache_release+151} <ffffffff802b8fe8>{sgl_unmap
> _user_pages+120}
>        <ffffffff802b48fb>{release_buffering+27} <ffffffff802b4fb1>{st_write+1697}
>        <ffffffff8017af46>{vfs_write+198} <ffffffff8017b0a3>{sys_write+83}
>        <ffffffff8010db7a>{system_call+126} 
> Trying to fix it up, but a reboot is needed
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at include/linux/mm.h:341
> invalid operand: 0000 [1] SMP 
> CPU 1 
> Modules linked in: bonding
> Pid: 2418, comm: taper Tainted: G    B 2.6.14.2 #1
> RIP: 0010:[<ffffffff802b8fcd>] <ffffffff802b8fcd>{sgl_unmap_user_pages+93}
> RSP: 0018:ffff810035725e18  EFLAGS: 00010256
> RAX: 0000000000000000 RBX: 0000000000000007 RCX: 000000000000000f
> RDX: 00000000000000e0 RSI: 0000000000000001 RDI: ffff81000260b6f8
> RBP: ffff810004852068 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000000000008000 R11: 0000000000000200 R12: 0000000000000008
> R13: 0000000000000000 R14: 0000000000008000 R15: ffff810004949d10
> FS:  00002aaaab53d880(0000) GS:ffffffff804db880(0000) knlGS:00000000556b6920
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002aaaaaac0000 CR3: 0000000035691000 CR4: 00000000000006e0
> Process taper (pid: 2418, threadinfo ffff810035724000, task ffff81017d680300)
> Stack: ffff8101423f3600 ffff810004852000 0000000000000040 0000000000008000 
>        ffff810004949c00 ffffffff802b48fb ffff810004852000 ffffffff802b4fb1 
>        ffff810000000000 ffffffff00000001 
> Call Trace:<ffffffff802b48fb>{release_buffering+27} <ffffffff802b4fb1>{st_write+1697}
>        <ffffffff8017af46>{vfs_write+198} <ffffffff8017b0a3>{sys_write+83}
>        <ffffffff8010db7a>{system_call+126} 
> 
> Code: 0f 0b 68 ba 12 3a 80 c2 55 01 f0 83 47 08 ff 0f 98 c0 84 c0 
> RIP <ffffffff802b8fcd>{sgl_unmap_user_pages+93} RSP <ffff810035725e18>
>  ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at mm/rmap.c:487
> invalid operand: 0000 [2] SMP 
> CPU 1 
> Modules linked in: bonding
> Pid: 2418, comm: taper Tainted: G    B 2.6.14.2 #1
> RIP: 0010:[<ffffffff8016f3f7>] <ffffffff8016f3f7>{page_remove_rmap+39}
> RSP: 0018:ffff810035725ab0  EFLAGS: 00010286
> RAX: 00000000ffffffff RBX: ffff8100356976f8 RCX: ffff81000000f000
> RDX: 0000000000000000 RSI: 8000000064c69067 RDI: ffff81000260b6f8
> RBP: 00002aaaaaadf000 R08: 0000000000000000 R09: ffff81000260b688
> R10: 00000000fffffffa R11: 0000000000000000 R12: ffff810101c22380
> R13: 8000000064c69067 R14: ffff81000260b6f8 R15: 0000000000000000
> FS:  00002aaaab53d880(0000) GS:ffffffff804db880(0000) knlGS:00000000556b6920
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002aaaaaac0000 CR3: 0000000035691000 CR4: 00000000000006e0
> Process taper (pid: 2418, threadinfo ffff810035724000, task ffff81017d680300)
> Stack: ffffffff80166ecd 00002aaaaab62000 ffff810035696aa8 00002aaaaab62000 
>        00002aaaaab62000 00002aaaaab61fff ffff810035695550 00002aaaaab62000 
>        ffffffff80167180 ffff810035725d68 
> Call Trace:<ffffffff80166ecd>{zap_pte_range+477} <ffffffff80167180>{unmap_page_range+496}
>        <ffffffff801672e5>{unmap_vmas+293} <ffffffff8016cfa2>{exit_mmap+162}
>        <ffffffff80131ce1>{mmput+49} <ffffffff801371c6>{do_exit+438}
>        <ffffffff8010f6f1>{die+81} <ffffffff8010f9df>{do_invalid_op+159}
>        <ffffffff802b8fcd>{sgl_unmap_user_pages+93} <ffffffff80381f76>{thread_return+86}
>        <ffffffff802a8662>{sym_setup_data_and_start+402} <ffffffff8010e84d>{error_exit+0}
>        <ffffffff802b8fcd>{sgl_unmap_user_pages+93} <ffffffff802b8fe8>{sgl_unmap_user_pages+120}
>        <ffffffff802b48fb>{release_buffering+27} <ffffffff802b4fb1>{st_write+1697}
>        <ffffffff8017af46>{vfs_write+198} <ffffffff8017b0a3>{sys_write+83}
>        <ffffffff8010db7a>{system_call+126} 
> 
[ Rest of the oopses cut ]

I have installed amanda and learned to use it enough to do experiments 
with my main system. Unfortunately I have not been able to see any oopses.

My system is somewhat similar to yours but not completely. I have a single 
processor system with 1 GB memory whereas your system is a dual processor 
system with 5 GB memory. We both use the sym53c8xx driver to control the 
tape drive.

I have tried 2.6.14.2 and 2.6.15-rc3 kernels with and without the patch I 
sent earlier to the list. The first kernels did not have preemption and 
NUMA support enabled but later I configured the 2.6.14.2 kernel with both 
enabled. This is the nearest thing to your NUMA dual processor system but 
it does not seem to be near enough.

Since I can't reproduce the problem, I have to look at the oopses more 
carefully. Both yout oopses and those from 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=338335 are quite similar 
at the beginning. First come one or more reports about "Bad page state at 
free_hot_cold_page". The mapping_count is always two and count is zero. 
This condition triggers the message.

The next thing is "Kernel BUG at include/linux/mm.h:341". This is in 
put_page(struct page *page) and points to page pointer being NULL.

The third event is "Kernel BUG at mm/rmap.c:487" which results from 
"BUG_ON(page_mapcount(page) < 0)". The page pointer has been used used 
earlier in page_remove_rmap().

I am not an mm expert and have no idea what could cause this sequence of 
events. Any ideas?

If someone has any ideas for my debugging, they are welcome. I will 
continue thinking about this but now I am out of useful ideas.

-- 
Kai
