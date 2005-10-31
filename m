Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVJaCza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVJaCza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVJaCza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:55:30 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:16133 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S1751293AbVJaCz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:55:29 -0500
Date: Mon, 31 Oct 2005 00:55:26 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][noop-iosched] don't reuse a freed request
Message-ID: <20051031025526.GD5632@mandriva.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@mandriva.com>,
	Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20051031023024.GC5632@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031023024.GC5632@mandriva.com>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 31, 2005 at 12:30:24AM -0200, Arnaldo Carvalho de Melo escreveu:
> Hi,
> 
> 	I'm getting the oops below when trying to use qemu with a kernel
> built with just the noop iosched, I'm never had looked at this code before,
> so I did a quick hack that seems enough for my case.
> 
> 	Ah, this is with a fairly recent git tree (today), haven't checked
> if it is present in 2.6.14.

Further info: building with all the io schedulers and using 'elevator=cfq'
in the kernel cmd line produces another oops, with or without my patch:

hda:<1>Unable to handle kernel paging request at virtual address c554ef60
printing eip:
01b14f7
pde = 00015067
pte = 0554e000
ops: 0000 [#1]
EBUG_PAGEALLOC
odules linked in:
PU:    0
IP:    0060:[<c01b14f7>]    Not tainted VLI
FLAGS: 00000046   (2.6.14acme)
IP is at __elv_add_request+0xe7/0x13f
ax: c54f8e4c   ebx: 00000003   ecx: c54f6ef8   edx: c554ef58
si: c554ef58   edi: c54f8e4c   ebp: c1165ae0   esp: c1165ad4
s: 007b   es: 007b   ss: 0068
rocess swapper (pid: 1, threadinfo=c1165000 task=c1164af0)
tack: c554ef58 00000000 00000008 c1165b24 c01b45a5 c54f8e4c c554ef58 00000003
      00000000 00000000 00000000 00000008 00000000 00000000 c12a8710 c0128837
      c554ef58 00000008 c54f8e4c 00000100 c1165b60 c01b478d c54f8e4c c12a5a90
all Trace:
[<c0102a63>] show_stack+0x78/0x83
[<c0102b88>] show_registers+0x100/0x167
[<c0102d35>] die+0xcb/0x140
[<c0239780>] do_page_fault+0x393/0x53a
[<c0102777>] error_code+0x4f/0x54
[<c01b45a5>] __make_request+0x3ea/0x425
[<c01b478d>] generic_make_request+0x125/0x137
[<c01b4842>] submit_bio+0xa3/0xa9
[<c013d48a>] submit_bh+0xeb/0x10c
[<c013c702>] block_read_full_page+0x23e/0x253
[<c0140039>] blkdev_readpage+0x10/0x12
[<c012711b>] read_cache_page+0x74/0x1af
[<c0165822>] read_dev_sector+0x2d/0xb0
[<c0165c16>] msdos_partition+0x47/0x2cd
[<c01653a4>] check_partition+0x87/0xce
[<c016578e>] rescan_partitions+0x77/0xde
[<c014094b>] do_open+0x22c/0x2df
[<c0140a5d>] blkdev_get+0x5f/0x67
[<c0165702>] register_disk+0x96/0xab
[<c01b5d48>] add_disk+0x2f/0x3d
[<c01cb3f6>] ide_disk_probe+0x17a/0x199
[<c01ae283>] driver_probe_device+0x36/0x8a
[<c01ae382>] __driver_attach+0x33/0x48
[<c01adadd>] bus_for_each_dev+0x42/0x69
[<c01ae3ad>] driver_attach+0x16/0x1b
[<c01ade91>] bus_add_driver+0x5d/0xa6
[<c01ae752>] driver_register+0x54/0x5c
[<c01cb455>] idedisk_init+0xd/0xf
[<c02ac6b7>] do_initcalls+0x46/0x96
[<c02ac73c>] do_basic_setup+0x21/0x23
[<c01002a1>] init+0x25/0x10c
[<c0100c8d>] kernel_thread_helper+0x5/0xb
ode: 59 5b eb 52 8b 46 08 a8 20 75 08 0f 0b 79 01 6f ed 24 c0 83 c8 04 89 46 08 8b 47 0c 8b 00 56 57 ff 50 10 83 7f 08 00 58 5a 75 2b <8b> 46 08 a8 d8 75 24 a8 20 74 20 89 77 08 eb 1b 53 68 c0 e6 23
<0>Kernel panic - not syncing: Attempted to kill init!

