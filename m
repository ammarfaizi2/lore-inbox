Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWAYMT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWAYMT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWAYMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:19:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6800 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751149AbWAYMT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:19:27 -0500
Date: Wed, 25 Jan 2006 13:19:26 +0100
From: Jan Kara <jack@suse.cz>
To: Herbert Poetzl <herbert@13thfloor.at>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] quota: fix error code for ext2_new_inode()
Message-ID: <20060125121926.GB8640@atrey.karlin.mff.cuni.cz>
References: <20060125064059.GA3778@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060125064059.GA3778@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> the quota check in ext2_new_inode() returns ENOSPC where
> IMHO it should return EDQUOT instead. here is a trivial
> patch to fix that ...
> 
> rationale: ext3, reiser, udf and ufs do similar checks
> and already return EDQUOT
  Of course, you're right! Andrew please commit this one too.

						Honza


> Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
  Acked-by: Jan Kara <jack@suse.cz>

> --- ./fs/ext2/ialloc.c.orig	2006-01-03 17:29:56 +0100
> +++ ./fs/ext2/ialloc.c	2006-01-25 07:26:42 +0100
> @@ -605,7 +605,7 @@ got:
>  	insert_inode_hash(inode);
>  
>  	if (DQUOT_ALLOC_INODE(inode)) {
> -		err = -ENOSPC;
> +		err = -EDQUOT;
>  		goto fail_drop;
>  	}
>  
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
