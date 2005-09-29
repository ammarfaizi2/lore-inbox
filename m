Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVI2KKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVI2KKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 06:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVI2KKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 06:10:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:128 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751328AbVI2KKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 06:10:39 -0400
Date: Thu, 29 Sep 2005 12:10:38 +0200
From: Jan Kara <jack@suse.cz>
To: pinotj@club-internet.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
Message-ID: <20050929101037.GC13827@atrey.karlin.mff.cuni.cz>
References: <mnet2.1127960641.3944.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnet2.1127960641.3944.pinotj@club-internet.fr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >Date: Thu, 29 Sep 2005 02:57:20 +0100
> >From: Al Viro
> >To: pinotj
> >Cc: linux-kernel
> >Subject: Re: [PATCH][2.6.14-rc2] ext3: fix build warning if !quota
> [...]
> >.... and puts declaration in the middle of code.
> >
> 
> Is this better ?
  Yes, I like this version better. I guess you can submit it to Andrew.
(and add your Signed-off-by before the patch (Andrew's scripts won't find 
it otherwise I guess. Feel free to add mine too).

								Honza

> ------8<------
> diff -Naur a/fs/ext3/super.c b/fs/ext3/super.c
> --- a/fs/ext3/super.c	2005-09-29 00:28:16.000000000 +0000
> +++ b/fs/ext3/super.c	2005-09-29 02:18:22.000000000 +0000
> @@ -513,7 +513,9 @@
>  static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
>  {
>  	struct super_block *sb = vfs->mnt_sb;
> +#if defined(CONFIG_QUOTA)
>  	struct ext3_sb_info *sbi = EXT3_SB(sb);
> +#endif
>  
>  	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
>  		seq_puts(seq, ",data=journal");
> ------8<------
> 
> 
> -- 
> Jerome Pinot
> http://ngc891.blogdns.net/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
