Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUBDAVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266251AbUBDAVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:21:33 -0500
Received: from gprs156-172.eurotel.cz ([160.218.156.172]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266248AbUBDAVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:21:16 -0500
Date: Tue, 3 Feb 2004 23:20:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: the grugq <grugq@hcunix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
Message-ID: <20040203222030.GB465@elf.ucw.cz>
References: <4017E3B9.3090605@hcunix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4017E3B9.3090605@hcunix.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  }
>  
> +static inline void destroy_block(struct inode *inode, unsigned long block)
> +{
> +#ifdef CONFIG_EXT2_FS_PRIVACY
> +	struct buffer_head	* bh;
> +
> +	bh = sb_getblk(inode->i_sb, block);
> +
> +	memset(bh->b_data, 0x00, bh->b_size);
> +
> +	mark_buffer_dirty(bh);
> +	wait_on_buffer(bh);
> +	brelse(bh);
> +
> +	return;
> +#endif
> +}
> +

Perhaps this should still be controlled by (chattr(1)) [its already
documented, just not yet implemented].

       When a file with the `s' attribute set is deleted, its blocks
	are zeroed and written back to the disk.

...at which point config option is not really neccessary.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
