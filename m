Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266818AbUAXAmM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUAXAmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:42:12 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:13900 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266818AbUAXAmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:42:11 -0500
Date: Sat, 24 Jan 2004 11:41:13 +1100
From: Nathan Scott <nathans@sgi.com>
To: davej@redhat.com, marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: logic error in XFS
Message-ID: <20040124114113.A3508196@wobbly.melbourne.sgi.com>
References: <E1Ajuub-0000xw-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1Ajuub-0000xw-00@hardwired>; from davej@redhat.com on Fri, Jan 23, 2004 at 06:35:25AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 06:35:25AM +0000, davej@redhat.com wrote:
> Yet another misplaced ! by the looks..
> 

Thanks Dave, your fix looks good to me too.  Marcelo, this affects
2.4 too - please apply this patch.

thanks.

> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/xfs/xfs_log_recover.c linux-2.5/fs/xfs/xfs_log_recover.c
> --- bk-linus/fs/xfs/xfs_log_recover.c	2003-10-09 01:01:24.000000000 +0100
> +++ linux-2.5/fs/xfs/xfs_log_recover.c	2004-01-14 07:06:40.000000000 +0000
> @@ -1553,7 +1553,7 @@ xlog_recover_reorder_trans(
>  		case XFS_LI_BUF:
>  		case XFS_LI_6_1_BUF:
>  		case XFS_LI_5_3_BUF:
> -			if ((!flags & XFS_BLI_CANCEL)) {
> +			if (!(flags & XFS_BLI_CANCEL)) {
>  				xlog_recover_insert_item_frontq(&trans->r_itemq,
>  								itemq);
>  				break;

-- 
Nathan
