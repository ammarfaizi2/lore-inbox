Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967180AbWKYUns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967180AbWKYUns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967181AbWKYUns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:43:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:23264 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S967180AbWKYUnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:43:47 -0500
Subject: Re: [PATCH-2.4] jfs: incorrect use of "&&" instead of "&"
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061125212440.GA5930@1wt.eu>
References: <20061125212440.GA5930@1wt.eu>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 14:43:41 -0600
Message-Id: <1164487421.16418.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 22:24 +0100, Willy Tarreau wrote:
> Hi Dave,
> 
> I'm about to merge this fix in 2.4. It's already in 2.6 BTW.
> Do you have any objection ?

No objection.

> 
> Thanks in advance,
> Willy
> 
> From b14cb91c6621908f8e957aad5a85d6c41b31dfea Mon Sep 17 00:00:00 2001
> From: Willy Tarreau <w@1wt.eu>
> Date: Sat, 25 Nov 2006 21:57:26 +0100
> Subject: [PATCH] jfs: incorrect use of "&&" instead of "&"
> 
> in jfs_txnmgr, the use of "tblk->flag && COMMIT_DELETE" in a
> if() condition is obviously wrong. This bug has already been
> fixed in 2.6.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

> ---
>  fs/jfs/jfs_txnmgr.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
> index 62e6493..4e6a280 100644
> --- a/fs/jfs/jfs_txnmgr.c
> +++ b/fs/jfs/jfs_txnmgr.c
> @@ -1175,7 +1175,7 @@ int txCommit(tid_t tid,		/* transaction 
>  		jfs_ip = JFS_IP(ip);
>  
>  		if (test_and_clear_cflag(COMMIT_Syncdata, ip) &&
> -		    ((tblk->flag && COMMIT_DELETE) == 0))
> +		    ((tblk->flag & COMMIT_DELETE) == 0))
>  			fsync_inode_data_buffers(ip);
>  
>  		/*
-- 
David Kleikamp
IBM Linux Technology Center

