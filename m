Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUGAGJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUGAGJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 02:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUGAGJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 02:09:27 -0400
Received: from web11202.mail.yahoo.com ([216.136.131.184]:15685 "HELO
	web11202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264153AbUGAGJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 02:09:25 -0400
Message-ID: <20040701060924.11587.qmail@web11202.mail.yahoo.com>
Date: Wed, 30 Jun 2004 23:09:24 -0700 (PDT)
From: Hongwei Li <hwli98@yahoo.com>
Subject: reiserfs bug
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
My machine am running linux-2.4.25, it crash in the
reiser_panic.
I looked at the oops and find out the followings:
check_leaf_block_head pass the 0 as "sb" value, and
cause reiser_panic crash.
Any fix for this?

static void check_leaf_block_head (struct buffer_head
* bh)
{
  struct block_head * blkh;
  int nr;

  blkh = B_BLK_HEAD (bh);
  nr = blkh_nr_item(blkh);
  if ( nr > (bh->b_size - BLKH_SIZE) / IH_SIZE)
    reiserfs_panic (0, "vs-6010:
check_leaf_block_head: invalid item number %z", bh);
  if ( blkh_free_space(blkh) > 
      bh->b_size - BLKH_SIZE - IH_SIZE * nr )
    reiserfs_panic (0, "vs-6020:
check_leaf_block_head: invalid free space %z", bh);
    
}

void reiserfs_panic (struct super_block * sb, const
char * fmt, ...)
{
  show_reiserfs_locks() ;
  do_reiserfs_warning(fmt);
  printk ( KERN_EMERG "%s (device %s)\n", error_buf,
bdevname(sb->s_dev));
  BUG ();

  /* this is not actually called, but makes
reiserfs_panic() "noreturn" */
  panic ("REISERFS: panic (device %s): %s\n",
	 sb ? kdevname(sb->s_dev) : "sb == 0", error_buf);
}

Li Hongwei


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
