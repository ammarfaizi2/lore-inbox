Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422708AbWAMPCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422708AbWAMPCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWAMPCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:02:25 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29371 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1422708AbWAMPCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:02:25 -0500
Date: Fri, 13 Jan 2006 16:02:24 +0100
From: Jan Kara <jack@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.15-mm3 - make useless quota error message informative
Message-ID: <20060113150224.GB9978@atrey.karlin.mff.cuni.cz>
References: <200601122044.k0CKihol003230@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601122044.k0CKihol003230@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fs/quota_v2.c can, under some conditions, issue a kernel message that
> says, in totality, 'failed read'.  This patch does the following:
> 
> 1) Gives a hint who issued the error message, so people reading the logs
> don't have to go grepping the entire kernel tree (with 11 false positives).
> 
> 2) Say what amount of data we expected, and actually got.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> --- linux-2.6.15-mm3/fs/quota_v2.c.quot-bug	2006-01-02 22:21:10.000000000 -0500
> +++ linux-2.6.15-mm3/fs/quota_v2.c	2006-01-12 15:26:43.000000000 -0500
> @@ -35,7 +35,8 @@ static int v2_check_quota_file(struct su
>   
>  	size = sb->s_op->quota_read(sb, type, (char *)&dqhead, sizeof(struct v2_disk_dqheader), 0);
>  	if (size != sizeof(struct v2_disk_dqheader)) {
> -		printk("failed read\n");
> +		printk("quota_v2: failed read expected=%d got=%d\n",
> +			sizeof(struct v2_disk_dqheader), size);
>  		return 0;
>  	}
>  	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
>  

  The patch is fine. Thanks for fixing. I wonder how I managed to write such
error message ;).

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
