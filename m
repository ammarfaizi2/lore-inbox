Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268995AbUJEPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268995AbUJEPFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269068AbUJEPFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:05:19 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:33934 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S268995AbUJEPFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:05:04 -0400
Subject: Re: reiserfs bug
From: Vladimir Saveliev <vs@namesys.com>
To: Hongwei Li <hwli98@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040701060924.11587.qmail@web11202.mail.yahoo.com>
References: <20040701060924.11587.qmail@web11202.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096988498.10831.76.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Oct 2004 19:01:39 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Thu, 2004-07-01 at 10:09, Hongwei Li wrote:
> Hi:
> My machine am running linux-2.4.25, it crash in the
> reiser_panic.
> I looked at the oops and find out the followings:
> check_leaf_block_head pass the 0 as "sb" value, and
> cause reiser_panic crash.
> Any fix for this?
> 

Reiserfs found metadata corruption. It is supposed to not crash but
return i/o error, 

but you should reiserfsck your filesystem.

We have to improve reiserfs data corruption handling.

> static void check_leaf_block_head (struct buffer_head
> * bh)
> {
>   struct block_head * blkh;
>   int nr;
> 
>   blkh = B_BLK_HEAD (bh);
>   nr = blkh_nr_item(blkh);
>   if ( nr > (bh->b_size - BLKH_SIZE) / IH_SIZE)
>     reiserfs_panic (0, "vs-6010:
> check_leaf_block_head: invalid item number %z", bh);
>   if ( blkh_free_space(blkh) > 
>       bh->b_size - BLKH_SIZE - IH_SIZE * nr )
>     reiserfs_panic (0, "vs-6020:
> check_leaf_block_head: invalid free space %z", bh);
>     
> }
> 
> void reiserfs_panic (struct super_block * sb, const
> char * fmt, ...)
> {
>   show_reiserfs_locks() ;
>   do_reiserfs_warning(fmt);
>   printk ( KERN_EMERG "%s (device %s)\n", error_buf,
> bdevname(sb->s_dev));
>   BUG ();
> 
>   /* this is not actually called, but makes
> reiserfs_panic() "noreturn" */
>   panic ("REISERFS: panic (device %s): %s\n",
> 	 sb ? kdevname(sb->s_dev) : "sb == 0", error_buf);
> }
> 
> Li Hongwei
> 
> 
> 	
> 		
> __________________________________
> Do you Yahoo!?
> New and Improved Yahoo! Mail - 100MB free storage!
> http://promotions.yahoo.com/new_mail
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

