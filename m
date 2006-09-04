Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWIDHLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWIDHLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWIDHLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:11:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:29607 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932409AbWIDHLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:11:04 -0400
Date: Mon, 4 Sep 2006 09:07:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 07/22][RFC] Unionfs: Directory file operations
In-Reply-To: <20060901014527.GH5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040904260.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014527.GH5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* copied from generic filldir in fs/readir.c */
>+static int unionfs_filldir(void *dirent, const char *name, int namelen,
>+			   loff_t offset, ino_t ino, unsigned int d_type)
>+{
>+	struct unionfs_getdents_callback *buf =
>+	    (struct unionfs_getdents_callback *)dirent;

Nocast.

>+	if ((namelen > UNIONFS_WHLEN) && !strncmp(name, UNIONFS_WHPFX, UNIONFS_WHLEN)) {
()

>+	/* if 'name' isn't a whiteout filldir it. */
                                     ^
I would put a , here

>+		err = vfs_readdir(hidden_file, unionfs_filldir, (void *)&buf);

Most likely nocast.

>+		if (err < 0) {
>+			goto out;
>+		}
>+
>+		if (buf.filldir_error) {
>+			break;
>+		}

-{}

>+				if (offset == rdstate2offset(rdstate)) {
>+					err = offset;
>+				} else if (file->f_pos == DIREOF) {
>+					err = DIREOF;
>+				} else {
>+					err = -EINVAL;
>+				}

-{}

>+/* Trimmed directory options, we shouldn't pass everything down since
>+ * we don't want to operate on partial directories.
>+ */
>+struct file_operations unionfs_dir_fops = {
>+	.llseek = unionfs_dir_llseek,
>+	.read = generic_read_dir,
>+	.readdir = unionfs_readdir,
>+	.unlocked_ioctl = unionfs_ioctl,
>+	.open = unionfs_open,
>+	.release = unionfs_file_release,
>+	.flush = unionfs_flush,
>+};

Might want to line up structs' members.




Jan Engelhardt
-- 

-- 
VGER BF report: H 1.9526e-07
