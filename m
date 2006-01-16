Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWAPVWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWAPVWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWAPVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:22:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18880 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751184AbWAPVWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:22:51 -0500
Date: Mon, 16 Jan 2006 22:22:50 +0100
From: Jan Kara <jack@suse.cz>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unmount oops in log_do_checkpoint
Message-ID: <20060116212250.GD12159@atrey.karlin.mff.cuni.cz>
References: <20060116160420.GA21064@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116160420.GA21064@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.15-git12 (and 11, not sure when it started) oops when unmounting
> an ext3 filesystem. Looks like 'transaction' in log_do_checkpoint is
> garbage.
> 
> Reproduced it every time for about 3 or 4 reboots now.
>
> Unable to handle kernel paging request at virtual address f63b4f7c
>  printing eip:
> c019db03
> *pde = 004b0067
> *pte = 363b4000
> Oops: 0000 [#1]
> SMP DEBUG_PAGEALLOC
> Modules linked in: ide_cd cdrom 8250_pnp 8250 serial_core piix ide_core
> CPU:    1
> EIP:    0060:[<c019db03>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.15-git12) 
> EIP is at log_do_checkpoint+0x6b/0x47b
> eax: f63b4f78   ebx: 00000001   ecx: 00000000   edx: 00015e0a
> esi: f57b78cc   edi: f57e7e90   ebp: f57e7e6c   esp: f57e7d38
> ds: 007b   es: 007b   ss: 0068
> Process umount (pid: 2418, threadinfo=f57e7000 task=f5396ad0)
> Stack: <0>00000001 c18364b8 00000082 c04aa3a8 348ea000 f642bf24 f642bdf8 f63b4f78 
>        00015e0a 00000001 c1836490 00000000 f57e7d80 c0114e96 00000000 00000000 
>        f57e7d98 f4e7bad0 f57e7d98 c01151a0 c0441788 0000001f 00000000 c0441780 
> Call Trace:
>  [<c0103dc0>] show_stack_log_lvl+0xbb/0x105
>  [<c0103f69>] show_registers+0x15f/0x1ef
>  [<c010422a>] die+0x11b/0x22d
>  [<c0114217>] do_page_fault+0x1ea/0x5d4
>  [<c01037d7>] error_code+0x4f/0x54
>  [<c019ff19>] journal_destroy+0x10d/0x24b
>  [<c0195986>] ext3_put_super+0x20/0x1ec
>  [<c015c89d>] generic_shutdown_super+0x89/0x131
>  [<c015c954>] kill_block_super+0xf/0x20
>  [<c015cb60>] deactivate_super+0x62/0x75
>  [<c016f59c>] mntput_no_expire+0x44/0x62
>  [<c0162f85>] path_release_on_umount+0x15/0x18
>  [<c0170362>] sys_umount+0x3a/0x21d
>  [<c017055e>] sys_oldumount+0x19/0x1b
>  [<c0102bdf>] sysenter_past_esp+0x54/0x75
> Code: e8 fe ff ff 89 d0 85 d2 0f 84 f2 01 00 00 8b 52 04 89 95 ec fe ff ff 39 85 e8 fe ff ff 74 15 8b 95 ec fe ff ff 8b 85 e8 fe ff ff <3b> 50 04 0f 85 cc 01 00 00 c7 45 f0 00 00 00 00 8b 85 e8 fe ff 

  It would be useful to find out which patch cause it (by git bisect)
but one obvious suspect is my merged ext3 patch to checkpoint.c. I'll
investigate tomorrow.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
