Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUAFRrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbUAFRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:47:20 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:62592 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264553AbUAFRrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:47:19 -0500
Date: Tue, 6 Jan 2004 09:46:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Hans Reiser <reiser@namesys.com>,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Hans Reiser <reiserfs-dev@namesys.com>,
       Daniel Pirkl <daniel.pirkl@email.cz>,
       Russell King <rmk@arm.linux.org.uk>, Will Dyson <will_dyson@pobox.com>,
       linux-kernel@vger.kernel.org, nikita@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
Message-ID: <20040106174650.GD1882@matchmail.com>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Hans Reiser <reiser@namesys.com>,
	"Tigran A. Aivazian" <tigran@veritas.com>,
	Hans Reiser <reiserfs-dev@namesys.com>,
	Daniel Pirkl <daniel.pirkl@email.cz>,
	Russell King <rmk@arm.linux.org.uk>,
	Will Dyson <will_dyson@pobox.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:28:34PM +0100, Jesper Juhl wrote:
> --- linux-2.6.1-rc1-mm2-orig/fs/reiserfs/inode.c        2004-01-06 01:33:08.000000000 +0100
> +++ linux-2.6.1-rc1-mm2/fs/reiserfs/inode.c     2004-01-06 12:16:16.000000000 +0100
> @@ -574,11 +574,6 @@ int reiserfs_get_block (struct inode * i
>      th.t_trans_id = 0 ;
>      version = get_inode_item_key_version (inode);
> 
> -    if (block < 0) {
> -       reiserfs_write_unlock(inode->i_sb);
> -       return -EIO;
> -    }
> -

Did you check the locking after this is removed?

Maybe after the sector_t merges, this code covered a case that is left open
now...
