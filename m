Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbUCUMsa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 07:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUCUMsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 07:48:30 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:21736 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263641AbUCUMs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 07:48:28 -0500
Date: Sun, 21 Mar 2004 13:43:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com,
       viro@parcelfarce.linux.theplanet.co.uk, s.b.wielinga@student.utwente.nl
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040321124302.GA21844@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <20040320004901.4328c1e1.akpm@osdl.org> <20040320112718.GA4688@wohnheim.fh-wedel.de> <20040320112828.7bce82d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040320112828.7bce82d2.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 March 2004 11:28:28 -0800, Andrew Morton wrote:
> 
> yup.  Now you're using i_lock to protect i_flags (which seems reasonable)
> you'll need to hnt down all the other i_flags users and make them use
> i_lock too.  Currently they appear to be using i_sem.

Interesting task.  A few of those users are filesystems that fill
their own flags into inode->i_flags.  Here is an example from
fs/ext3/ialloc.c:

static int find_group_orlov(struct super_block *sb, struct inode *parent)
{
	...
	if ((parent == sb->s_root->d_inode) ||
	    (parent->i_flags & EXT3_TOPDIR_FL)) {

Shouldn't this rather be:

	if ((parent == sb->s_root->d_inode) ||
	    (EXT3_I(parent)->i_flags & EXT3_TOPDIR_FL)) {

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
