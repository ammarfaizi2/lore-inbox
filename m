Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVIUDoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVIUDoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 23:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVIUDoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 23:44:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25778 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750936AbVIUDoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 23:44:18 -0400
Date: Wed, 21 Sep 2005 04:44:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>,
       Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/12] HPPFS: add dentry_ops->d_revalidate
Message-ID: <20050921034416.GW7992@ftp.linux.org.uk>
References: <20050918141006.31461.23599.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050918141006.31461.23599.stgit@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 04:10:07PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> +static int hppfs_d_revalidate(struct dentry * dentry, struct nameidata * nd)
> +{
> +	int (*d_revalidate)(struct dentry *, struct nameidata *);
> +	struct dentry *proc_dentry;
> +
> +	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
> +	if (proc_dentry->d_op && proc_dentry->d_op->d_revalidate)
> +		d_revalidate = proc_dentry->d_op->d_revalidate;
> +	else
> +		return 1; /* "Still valid" code */
> +
> +	return (*d_revalidate)(proc_dentry, nd);
> +}

Ahem...  Guess what that will do with negative dentry?
