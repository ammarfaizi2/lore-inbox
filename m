Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWIDHDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWIDHDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWIDHDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:03:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:33417 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932392AbWIDHDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:03:03 -0400
Date: Mon, 4 Sep 2006 08:59:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
In-Reply-To: <20060901014251.GF5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014251.GF5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* Determine the mode based on the copyup flags, and the existing dentry. */
>+static int copyup_permissions(struct super_block *sb,
>+			      struct dentry *old_hidden_dentry,
>+			      struct dentry *new_hidden_dentry)
>+{
>+	struct iattr newattrs;
>+	int err;
>+
>+	newattrs.ia_atime = old_hidden_dentry->d_inode->i_atime;
>+	newattrs.ia_mtime = old_hidden_dentry->d_inode->i_mtime;
>+	newattrs.ia_ctime = old_hidden_dentry->d_inode->i_ctime;

How about,

	struct inode *ohi = old_hidden_dentry->d_inode;
	newattrs.ia_atime = ohi->i_atime;

reduces typing a little.

>+	if (S_ISDIR(old_mode)) {
>+		args.u.mkdir.parent = new_hidden_parent_dentry->d_inode;
>+		args.u.mkdir.dentry = new_hidden_dentry;
>+		args.u.mkdir.mode = old_mode;

Like above maybe?

>+	} else {
>+		printk(KERN_ERR "Unknown inode type %d\n",
>+				old_mode);
>+		BUG();
>+	}

Is BUG the right thing, what do others think? (Using WARN, and set err to
something useful?)

>+	} while ((read_bytes > 0) && (len > 0));

-()

>+/* This function creates a copy of a file represented by 'file' which currently
>+ * resides in branch 'bstart' to branch 'new_bindex.
                                                     ^

+'

>+struct dentry *create_parents(struct inode *dir, struct dentry *dentry,
>+			      int bindex)
>+{
>+	struct dentry *hidden_dentry;
>+
>+	hidden_dentry =
>+	    create_parents_named(dir, dentry, dentry->d_name.name, bindex);
>+
>+	return (hidden_dentry);
>+}

{
	return create_parents_named(dir, dentry, dentry->d_name.name, bindex);
}


>+struct dentry *create_parents_named(struct inode *dir, struct dentry *dentry,
>+				    const char *name, int bindex)
>+{
>+	struct dentry **path = NULL;
>+	path = (struct dentry **)kzalloc(kmalloc_size, GFP_KERNEL);

Nocast.

>+	if (!path)
>+		;

Woha?!

>+			tmp_path =
>+			    (struct dentry **)kzalloc(kmalloc_size, GFP_KERNEL);

Nocast.



Jan Engelhardt
-- 

-- 
VGER BF report: H 0
