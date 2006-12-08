Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424381AbWLHE4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424381AbWLHE4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424392AbWLHE4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:56:02 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:43950 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424381AbWLHE4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:56:00 -0500
Date: Thu, 7 Dec 2006 23:43:18 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 16/35] Unionfs: Copyup Functionality
Message-ID: <20061208044318.GC14363@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235470298-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052202250.18570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612052202250.18570@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:09:19PM +0100, Jan Engelhardt wrote:
> 
> On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
> >+/* Determine the mode based on the copyup flags, and the existing dentry. */
> >+static int copyup_permissions(struct super_block *sb,
> >+			      struct dentry *old_hidden_dentry,
> >+			      struct dentry *new_hidden_dentry)
> >+{
> >+	struct inode *i = old_hidden_dentry->d_inode;
> 
> Screams for constification. (Or rather I do.)
 
I'm not following.
 
> >+{
> >+	int err = 0;
> >+	umode_t old_mode = old_hidden_dentry->d_inode->i_mode;
> 
> Generel question for everybody: Why do we have two same (at least on i386
> that's the case) types, umode_t and mode_t?

No idea.

> >+	} else if (S_ISBLK(old_mode)
> >+		   || S_ISCHR(old_mode)
> >+		   || S_ISFIFO(old_mode)
> >+		   || S_ISSOCK(old_mode)) {
> >+		args.mknod.parent = new_hidden_parent_dentry->d_inode;
> >+		args.mknod.dentry = new_hidden_dentry;
> >+		args.mknod.mode = old_mode;
> 
> I'd say the indent got screwed up, and it's not a mailer thing.

Right.

> >+	input_file = dentry_open(old_hidden_dentry,
> >+			unionfs_lower_mnt_idx(dentry, old_bindex), O_RDONLY | O_LARGEFILE);
> >+	if (IS_ERR(input_file)) {
...
> >+	output_file = dentry_open(new_hidden_dentry,
> >+			unionfs_lower_mnt_idx(dentry, new_bindex), O_WRONLY | O_LARGEFILE);
> 
> Here we got an 80-column buster.

/me whistles innocently

> >+	/* TODO: should we reset the error to something like -EIO? */
> 
> Handle it :)  - if it does not take a paper.

I'm not even sure if we want to reset it to begin with.

If we don't reset, the user may get some non-sensical errors, but on the
other hand, if we reset to EIO, we guarantee that the user will get a
"confusing" error message.

Josef "Jeff" Sipek.

-- 
All science is either physics or stamp collecting.
		- Ernest Rutherford
