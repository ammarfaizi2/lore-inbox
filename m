Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCTEHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCTEHb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWCTEHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:07:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59018 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751370AbWCTEHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:07:30 -0500
Date: Sun, 19 Mar 2006 20:04:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and
 forget options
Message-Id: <20060319200424.5a3647aa.akpm@osdl.org>
In-Reply-To: <441E142F.2030305@cfl.rr.com>
References: <441E142F.2030305@cfl.rr.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
>
> This patch corrects the incorrect patch previously applied in
> commit 4d6660eb3665f22d16aff466eb9d45df6102b254.  I had posted
> the correction as a reply on lkml, but it seems that the earlier
> and incorrect patch got merged into Linus's tree.

I didn't see that update, and I don't miss much.

> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -1341,13 +1341,11 @@ udf_update_inode(struct inode *inode, in
> 
> 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
> 		fe->uid = cpu_to_le32(-1);
> -	else if (inode->i_uid != UDF_SB(inode->i_sb)->s_uid)
> -		fe->uid = cpu_to_le32(inode->i_uid);
> +	else fe->uid = cpu_to_le32(inode->i_uid);
> 
> 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
> 		fe->gid = cpu_to_le32(-1);
> -	else if (inode->i_gid != UDF_SB(inode->i_sb)->s_gid)
> -		fe->gid = cpu_to_le32(inode->i_gid);
> +	else fe->gid = cpu_to_le32(inode->i_gid);
> 
> 	udfperms =	((inode->i_mode & S_IRWXO)     ) |
> 			((inode->i_mode & S_IRWXG) << 2) |

This is an unchangelogged alteration.

Please provide a description of this change.  What problem is it fixing? 
How does it fix it?  What are the consequences of not making this change?

Thanks.
