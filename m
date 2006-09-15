Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWIOUHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWIOUHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWIOUHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:07:20 -0400
Received: from pat.uio.no ([129.240.10.4]:54496 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751692AbWIOUHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:07:19 -0400
Subject: Re: [NFS] 2.6.18-rc5 page_to_pfn: Unable to handle kernel NULL
	pointer dereference
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andre Noll <maan@systemlinux.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <20060915124043.GA20462@skl-net.de>
References: <20060908073125.GA23642@skl-net.de>
	 <20060915124043.GA20462@skl-net.de>
Content-Type: multipart/mixed; boundary="=-w8A28nqyWJAXbWiEac21"
Date: Fri, 15 Sep 2006 16:07:07 -0400
Message-Id: <1158350827.5501.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.564, required 12,
	autolearn=disabled, AWL 1.44, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w8A28nqyWJAXbWiEac21
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-09-15 at 14:40 +0200, Andre Noll wrote:
> On 09:31, Andre Noll wrote:
> > The following just happend to one of our 8-way Opteron cluster nodes
> > (nfs client version 3, solaris nfs server).
> 
> The problem is still present in 2.6.18-rc7. This time it happend on a
> 2-processor Opteron machine:
> 
> Pid: 945, comm: sge_execd Not tainted 2.6.18-rc7-tt64-6-g1883c5ab #4
> RIP: 0010:[<ffffffff80150cad>]  [<ffffffff80150cad>] page_to_pfn+0x0/0x33
> RSP: 0018:ffff8100fac73bb0  EFLAGS: 00010283
> RAX: 0000000000000a57 RBX: 00000000000004ae RCX: 0000000000000a57
> RDX: ffff8100fac73bf0 RSI: ffff8101b9b1c540 RDI: 0000000000000000
> RBP: 00000000000005a9 R08: ffff8101f7aa31d0 R09: ffff8101f7aa3040
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000b52
> R13: ffff8100fac73bf8 R14: 0000000000002000 R15: ffff8101f7aa32e8
> FS:  00002b83ded037a0(0000) GS:ffff8101000dc540(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 00000000fad78000 CR4: 00000000000006a0
> Process sge_execd (pid: 945, threadinfo ffff8100fac72000, task ffff810004be5180)
> Stack:  ffffffff801d6276 ffff8101fc4f0440 ffff8101b9b1c3c0 0000000000000a57
>  ffff8101f7aa31d0 00000000000005a9 ffffffff801d64fc 0000000000000001
>  ffff8101ffec2e18 0000000000000000 ffff8101f7aa31d0 ffff8101ffec2e18
> Call Trace:
>  [<ffffffff801d6276>] nfs_readpage_truncate_uninitialised_page+0x76/0xeb
>  [<ffffffff801d64fc>] nfs_readpage_sync+0x211/0x253
>  [<ffffffff801d6f89>] nfs_readpage+0x118/0x151
>  [<ffffffff8014c6fe>] do_generic_mapping_read+0x1ec/0x398
>  [<ffffffff8014c8aa>] file_read_actor+0x0/0xd1
>  [<ffffffff8014caf2>] __generic_file_aio_read+0x177/0x1b0
>  [<ffffffff8014cb5f>] generic_file_aio_read+0x34/0x39
>  [<ffffffff801cf3eb>] nfs_file_read+0x84/0x93
>  [<ffffffff8016e0fc>] do_sync_read+0xc9/0x106
>  [<ffffffff8013e5fd>] autoremove_wake_function+0x0/0x2e
>  [<ffffffff8015bf32>] do_mmap_pgoff+0x5fd/0x6de
>  [<ffffffff8016e1e6>] vfs_read+0xad/0x14c
>  [<ffffffff8016e520>] sys_read+0x45/0x6e
>  [<ffffffff80109726>] system_call+0x7e/0x83

Does the attached patch fix it?

Cheers,
  Trond

--=-w8A28nqyWJAXbWiEac21
Content-Description: 
Content-Type: message/rfc822
Content-Disposition: inline; filename=linux-2.6.18-071-fix_sync_read.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Fri, 15 Sep 2006 16:03:45 -0400
NFS: Fix Oopsable condition in nfs_readpage_sync()
Subject: No Subject
Message-Id: <1158350827.5501.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/read.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 9e6f2db..69f1549 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -204,9 +204,11 @@ static int nfs_readpage_sync(struct nfs_
 	NFS_I(inode)->cache_validity |= NFS_INO_INVALID_ATIME;
 	spin_unlock(&inode->i_lock);
 
-	nfs_readpage_truncate_uninitialised_page(rdata);
-	if (rdata->res.eof || rdata->res.count == rdata->args.count)
+	if (rdata->res.eof || rdata->res.count == rdata->args.count) {
 		SetPageUptodate(page);
+		if (rdata->res.eof && count != 0)
+			memclear_highpage_flush(page, rdata->args.pgbase, count);
+	}
 	result = 0;
 
 io_error:

--=-w8A28nqyWJAXbWiEac21--

