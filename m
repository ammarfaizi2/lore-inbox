Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUJZBuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUJZBuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbUJZBtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:49:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:42196 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261926AbUJZBTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:19:55 -0400
Message-ID: <417D88BB.70907@osdl.org>
Date: Mon, 25 Oct 2004 16:14:03 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org>	<417D7EB9.4090800@osdl.org> <20041025155626.11b9f3ab.akpm@osdl.org>
In-Reply-To: <20041025155626.11b9f3ab.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>I'm trying to spend time on kexec++ this week, but this little BUG
>>keeps getting in the way.  Has it already been reported/fixed?
>>
>>kernel BUG at arch/i386/mm/highmem.c:42!
> 
> 
> oops, we did it again.
> 
> --- 25/drivers/ide/ide-taskfile.c~ide_pio_sector-kmap-fix	Mon Oct 25 15:54:35 2004
> +++ 25-akpm/drivers/ide/ide-taskfile.c	Mon Oct 25 15:54:48 2004
> @@ -304,7 +304,7 @@ static void ide_pio_sector(ide_drive_t *
>  	else
>  		taskfile_input_data(drive, buf, SECTOR_WORDS);
>  
> -	kunmap_atomic(page, KM_BIO_SRC_IRQ);
> +	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
>  #ifdef CONFIG_HIGHMEM
>  	local_irq_restore(flags);
>  #endif
> _

Yes, that gets further.   :(
Maybe I'll just (try) apply the kexec patch to a vanilla kernel.


Unable to handle kernel paging request at virtual address fffea000
  printing eip:
c02c8e4d
*pde = 0064b067
*pte = 00000000
Oops: 0002 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c02c8e4d>]    Not tainted VLI
EFLAGS: 00010006   (2.6.9-mm1)
EIP is at ide_insw+0xd/0x20
eax: 000001f0   ebx: c05ee7ec   ecx: 00000100   edx: 000001f0
esi: c05ee7ec   edi: fffea000   ebp: c056fe80   esp: c056fe7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c056e000 task=c0486b80)
Stack: c05ee740 c056fea0 c02c93b8 000001f0 fffea000 00000100 c05ee7ec 
00000080
        fffea000 c056fec0 c02ccf06 c05ee7ec fffea000 00000080 00000000 
00000000
        c05ee740 c056feec c02cd62b c05ee7ec fffea000 00000080 00000000 
fffea000
Call Trace:
  [<c0107eff>] show_stack+0xaf/0xc0
  [<c010808d>] show_registers+0x15d/0x1e0
  [<c01082a6>] die+0x106/0x190
  [<c011c707>] do_page_fault+0x517/0x6a6
  [<c0107b4d>] error_code+0x2d/0x38
  [<c02c93b8>] ata_input_data+0x98/0xa0
  [<c02ccf06>] taskfile_input_data+0x26/0x50
  [<c02cd62b>] ide_pio_sector+0xcb/0xf0
  [<c02cd892>] task_in_intr+0xe2/0x100
  [<c02c8c16>] ide_intr+0xb6/0x150
  [<c0142cd8>] handle_IRQ_event+0x38/0x70
  [<c0142df2>] __do_IRQ+0xe2/0x150
  [<c0109606>] do_IRQ+0x36/0x60
  [<c0107a30>] common_interrupt+0x18/0x20
  [<c01050f1>] cpu_idle+0x31/0x50
  [<c05709bf>] start_kernel+0x15f/0x180
  [<c0100211>] 0xc0100211
Code: e5 8b 55 08 ec 0f b6 c0 5d c3 8d 74 26 00 55 89 e5 8b 55 08 66 
ed 0f b7 c
  <0>Kernel panic - not syncing: Fatal exception in interrupt
  <0>Dumping messages in 0 seconds : last chance for Alt-SysRq...




-- 
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
