Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266763AbUFXXOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266763AbUFXXOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 19:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266760AbUFXXOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 19:14:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54445 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266865AbUFXXNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 19:13:54 -0400
Date: Fri, 25 Jun 2004 00:13:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: OOPS from ext3_follow_link in 2.6.7+BK
Message-ID: <20040624231347.GH12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.44.0406250153410.8143-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0406250153410.8143-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 01:57:27AM +0300, Meelis Roos wrote:
> Call Trace:
>  [<c01594ff>] generic_readlink+0x2f/0x80

--- fs/namei.c	Thu Jun 24 16:06:45 2004
+++ fs/namei.c-fix	Thu Jun 24 16:07:24 2004
@@ -2197,7 +2197,9 @@
 int generic_readlink(struct dentry *dentry, char __user *buffer, int buflen)
 {
 	struct nameidata nd;
-	int res = dentry->d_inode->i_op->follow_link(dentry, &nd);
+	int res;
+	nd.depth = 0;
+	res = dentry->d_inode->i_op->follow_link(dentry, &nd);
 	if (!res) {
 		res = vfs_readlink(dentry, buffer, buflen, nd_get_link(&nd));
 		if (dentry->d_inode->i_op->put_link)
