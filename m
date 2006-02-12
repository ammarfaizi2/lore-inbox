Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWBLXDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWBLXDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWBLXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:03:21 -0500
Received: from mail.gmx.net ([213.165.64.21]:61621 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751057AbWBLXDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:03:20 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: 2.6.15 Bug? New security model?
Date: Mon, 13 Feb 2006 00:03:15 +0100
User-Agent: KMail/1.9.1
Cc: Jeff Mahoney <jeffm@suse.com>, Chris Wright <chrisw@sous-sol.org>,
       John M Flinchbaugh <john@hjsoft.com>, reiserfs-list@namesys.com,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org
References: <200602080212.27896.bernd-schubert@gmx.de> <20060212175740.GB8805@locomotive.unixthugs.org> <20060212192115.GB8544@procyon.home>
In-Reply-To: <20060212192115.GB8544@procyon.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602130003.15698.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index ef5e541..acafe32 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1124,7 +1124,9 @@ static void handle_attrs(struct super_bl
>  					 "reiserfs: cannot support attributes until flag is set in
> super-block"); REISERFS_SB(s)->s_mount_opt &= ~(1 << REISERFS_ATTRS);
>  		}
> -	} else if (le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) {
> +	} else if ((le32_to_cpu(rs->s_flags) & reiserfs_attrs_cleared) &&
> +		(get_inode_sd_version(s->s_root->d_inode) == STAT_DATA_V2)) {
> +		/* Enable attrs by default on v3.6-native file systems */
>  		REISERFS_SB(s)->s_mount_opt |= (1 << REISERFS_ATTRS);
>  	}
>  }

I'm afraid that still doesn't solve the problem for me, I added two printk to 
be sure whats going on - get_inode_sd_version(s->s_root->d_inode) returns 
STAT_DATA_V2 for all of my partitions.

