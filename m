Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUGAUoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUGAUoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUGAUoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:44:54 -0400
Received: from [217.73.129.129] ([217.73.129.129]:13231 "EHLO
	car.linuxhacker.ru") by vger.kernel.org with ESMTP id S266281AbUGAUow
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:44:52 -0400
Date: Thu, 1 Jul 2004 23:44:46 +0300
Message-Id: <200407012044.i61Kikfk016519@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: reiserfs bug
To: hwli98@yahoo.com, linux-kernel@vger.kernel.org
References: <20040701060924.11587.qmail@web11202.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Hongwei Li <hwli98@yahoo.com> wrote:
HL> My machine am running linux-2.4.25, it crash in the
HL> reiser_panic.
HL> I looked at the oops and find out the followings:
HL> check_leaf_block_head pass the 0 as "sb" value, and
HL> cause reiser_panic crash.
HL> Any fix for this?

Well, reiserfs_panic is supposed to crash with BUG().
And the reason for the reiserfs_panic call seems to be on-disk corruption
in your case.

HL>     reiserfs_panic (0, "vs-6020:
HL> check_leaf_block_head: invalid free space %z", bh);

This is fine.

HL> void reiserfs_panic (struct super_block * sb, const
HL> char * fmt, ...)
HL> {
HL>   show_reiserfs_locks() ;
HL>   do_reiserfs_warning(fmt);
HL>   printk ( KERN_EMERG "%s (device %s)\n", error_buf,
HL> bdevname(sb->s_dev));

This line looks this way in current bk tree:
  panic ("REISERFS: panic (device %s): %s\n",
         sb ? kdevname(sb->s_dev) : "sb == 0", error_buf);
And I think it was like this for some significant time already.
bk diffs output suggest that this change was in there since Feb 4th, 2002.

Are you using vanilla tree?
I seem to remember that bdevname was used early in 2.5.

Bye,
    Oleg
