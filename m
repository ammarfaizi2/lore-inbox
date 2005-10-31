Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVJaCac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJaCac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJaCac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:30:32 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:13829 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S1751251AbVJaCab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:30:31 -0500
Date: Mon, 31 Oct 2005 00:30:24 -0200
From: Arnaldo Carvalho de Melo <acme@mandriva.com>
To: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][noop-iosched] don't reuse a freed request
Message-ID: <20051031023024.GC5632@mandriva.com>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@mandriva.com>,
	Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

	I'm getting the oops below when trying to use qemu with a kernel
built with just the noop iosched, I'm never had looked at this code before,
so I did a quick hack that seems enough for my case.

	Ah, this is with a fairly recent git tree (today), haven't checked
if it is present in 2.6.14.

Best Regards,

- Arnaldo

Unable to handle kernel paging request at virtual address c5f20f60
 printing eip:
c01b0ecd
*pde = 00017067
*pte = 05f20000
Oops: 0000 [#1]
DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c01b0ecd>]    Not tainted VLI
EFLAGS: 00000046   (2.6.14acme)
EIP is at elv_rq_merge_ok+0x15/0x7b
eax: 00000014   ebx: c5f20f58   ecx: 000003f8   edx: 00000046
esi: c12a5a90   edi: c5f20f58   ebp: c11658d0   esp: c11658c4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1165000 task=c1164af0)
Stack: c0251883 c5ecfe4c c5d688c0 c1165904 c01b0f48 c5f20f58 c12a5a90 00000000
       c5874000 c018c5e1 c5f15f24 0000002b 00000000 c5ecfe4c c5d688c0 c12a5a90
       c1165920 c01b128d c5f20f58 c12a5a90 000a568a 00000000 00000002 c1165960
Call Trace:
 [<c0102a63>] show_stack+0x78/0x83
 [<c0102b88>] show_registers+0x100/0x167
 [<c0102d35>] die+0xcb/0x140
 [<c0234308>] do_page_fault+0x393/0x53a
 [<c0102777>] error_code+0x4f/0x54
 [<c01b0f48>] elv_try_merge+0x15/0x84
 [<c01b128d>] elv_merge+0x1d/0x4f
 [<c01b41d9>] __make_request+0xb2/0x425
 [<c01b46f9>] generic_make_request+0x125/0x137
 [<c01b47ae>] submit_bio+0xa3/0xa9
 [<c013d48a>] submit_bh+0xeb/0x10c
 [<c013b953>] __bread_slow+0x4a/0x86
 [<c013bba4>] __bread+0x25/0x2c
 [<c016b736>] ext3_get_branch+0x6c/0xe9
 [<c016bc20>] ext3_get_block_handle+0x99/0x28e
 [<c016be74>] ext3_get_block+0x5f/0x66
 [<c0157942>] do_mpage_readpage+0x110/0x3ab
 [<c0157c62>] mpage_readpages+0x85/0x114
 [<c016ca53>] ext3_readpages+0x16/0x18
 [<c012b27a>] read_pages+0x22/0xf5
 [<c012b442>] __do_page_cache_readahead+0xf5/0x113
 [<c012b553>] blockable_page_cache_readahead+0x43/0x9a
 [<c012b6ab>] page_cache_readahead+0x72/0x101
 [<c0126204>] do_generic_mapping_read+0xfc/0x451
 [<c012679b>] __generic_file_aio_read+0x15a/0x1a8
 [<c012682b>] generic_file_aio_read+0x42/0x49
 [<c0139712>] do_sync_read+0x9c/0xcd
 [<c01397cd>] vfs_read+0x8a/0x12a
 [<c014263e>] kernel_read+0x37/0x41
 [<c0142fa4>] prepare_binprm+0xbc/0xce
 [<c0143348>] do_execve+0xe9/0x1d9
 [<c01013e9>] sys_execve+0x2a/0x75
 [<c010254d>] syscall_call+0x7/0xb
Code: b9 21 08 00 59 eb 98 66 4a 75 e9 51 e8 55 c3 fd ff 59 eb e0 90 90 55 89 e5 56 8b 75 0c 53 8b 5d 08 68 83 18 25 c0 e8 bf db f5 ff <8b> 43 08 5a a8 d8 75 55 a8 20 74 51 68 b1 18 25 c0 e8 a9 db f5
 <0>Kernel panic - not syncing: Attempted to kill init!

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="noop-iosched.patch"

--- a/drivers/block/ll_rw_blk.c
+++ b/drivers/block/ll_rw_blk.c
@@ -1787,6 +1787,9 @@ static inline void blk_free_request(requ
 	if (rq->flags & REQ_ELVPRIV)
 		elv_put_request(q, rq);
 	mempool_free(rq, q->rq.rq_pool);
+
+	if (rq == q->last_merge)
+		q->last_merge = NULL;
 }
 
 static inline struct request *

--fdj2RfSjLxBAspz7--
