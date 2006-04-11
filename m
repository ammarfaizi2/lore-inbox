Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWDKFlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWDKFlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 01:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWDKFlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 01:41:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750799AbWDKFlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 01:41:20 -0400
Date: Tue, 11 Apr 2006 07:41:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Hasso Tepper <hasso@estpak.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cciss crash while executing hpacucli
Message-ID: <20060411054143.GK3859@suse.de>
References: <200604081732.47528.hasso@estpak.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604081732.47528.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08 2006, Hasso Tepper wrote:
> HP Proliant DL140 with Compaq Compaq Smart Array 642 + StorageWorks MSA20 
> with 8x500GB SATA disks. 2 RAID5 arrays (4 disks in each). Kernel is 
> 2.6.16.2.
> 
> While starting hpacucli, kernel crashes at once with backtrace below. No 
> crash if no arrays is created, but the same crash happens if I'm trying 
> to create second array from hpacucli (first one is created without 
> problem). No problem with 2.4.32 kernel.
> 
> Kernel config and lspci -vvv output are attached.
> 
> 
> 
> kernel BUG at block/ll_rw_blk.c:3349!
> invalid opcode: 0000 [#1]
> Modules linked in: ipv6
> CPU:    0
> EIP:    0060:[<c01ea6e3>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.16.2 #1)
> EIP is at blk_complete_request+0xe/0x41
> eax: f79c176c   ebx: f7a00000   ecx: f7973ac4   edx: f7e83f40
> esi: f7e83c00   edi: 00000001   ebp: 00000000   esp: c0385f50
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c0384000 task=c0329b00)
> Stack: <0>f7a00000 c021ee71 f7973ac4 00000000 00000000 00000002 f7d88520 
> 00000000
>        00000000 00000018 c0125bc3 00000018 f7e83c00 c0385fb8 c0385fb8 
> c037c600
>        00000018 f7d88520 c0385fb8 c0125c42 c0384000 00099100 c0379800 
> 003ef007
> Call Trace:
>  [<c021ee71>] do_cciss_intr+0x309/0x410
>  [<c0125bc3>] handle_IRQ_event+0x20/0x4c
>  [<c0125c42>] __do_IRQ+0x53/0x91
>  [<c010426d>] do_IRQ+0x19/0x24
>  [<c0102dc2>] common_interrupt+0x1a/0x20
>  [<c0100ba2>] mwait_idle+0x1a/0x2a
>  [<c0100af3>] cpu_idle+0x40/0x5c
>  [<c038662a>] start_kernel+0x143/0x145
> Code: 50 04 89 02 89 5b 04 89 1b 8b 41 68 51 ff 50 64 59 8b 1c 24 39 f3 75 
> df 58 5a 5b 5e c3 53 8b 4c 24 08 8b 41 68 83 78 64 00 75 08 <0f> 0b 15 0d 
> e7 19 2f c0 9c 5b fa c7 41 08 6c e2 3b c0 8b 15 70
>  <0>Kernel panic - not syncing: Fatal exception in interrupt

This one finally got fixed, see Mike's posting from yesterday. Subject
"[PATCH 1/1] cciss: bug fix for crash when running hpacucli"

-- 
Jens Axboe

