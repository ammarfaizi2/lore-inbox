Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVAGEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVAGEVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVAGEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:21:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261225AbVAGEVU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:21:20 -0500
Date: Fri, 7 Jan 2005 04:21:17 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andy Adamson <andros@citi.umich.edu>, Neil Brown <neilb@cse.unsw.edu.au>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] knfsd: check for existence of file_lock parameter inside of the kernel lock.
Message-ID: <20050107042117.GQ27371@parcelfarce.linux.theplanet.co.uk>
References: <200501050742.j057gGvV013421@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501050742.j057gGvV013421@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 05:48:59AM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2177, 2005/01/04 21:48:59-08:00, neilb@cse.unsw.edu.au
> 
> 	[PATCH] knfsd: check for existence of file_lock parameter inside of the kernel lock.

Why?  What is lock_kernel() protecting here?

> 	Signed-off-by: Andy Adamson <andros@citi.umich.edu>
> 	Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  locks.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> 
> diff -Nru a/fs/locks.c b/fs/locks.c
> --- a/fs/locks.c	2005-01-04 23:42:28 -08:00
> +++ b/fs/locks.c	2005-01-04 23:42:28 -08:00
> @@ -1096,15 +1096,13 @@
>  */
>  void remove_lease(struct file_lock *fl)
>  {
> -	if (!IS_LEASE(fl))
> -		return;
> -
>  	lock_kernel();
> -
> +	if (!fl || !IS_LEASE(fl))
> +		goto out;
>  	fl->fl_type = F_UNLCK | F_INPROGRESS;
>  	fl->fl_break_time = jiffies - 10;
>  	time_out_leases(fl->fl_file->f_dentry->d_inode);
> -
> +out:
>  	unlock_kernel();
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
