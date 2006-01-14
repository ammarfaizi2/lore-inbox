Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWANRym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWANRym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWANRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:54:42 -0500
Received: from [62.38.115.213] ([62.38.115.213]:30396 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S1750738AbWANRyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:54:41 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: Regression in Autofs, 2.6.15-git
Date: Sat, 14 Jan 2006 19:54:20 +0200
User-Agent: KMail/1.9
Cc: hch@lst.de, linux-kernel@vger.kernel.org
References: <200601140217.56724.p_christ@hol.gr> <200601141725.28347.p_christ@hol.gr> <1137258375.2847.19.camel@eagle.themaw.net>
In-Reply-To: <1137258375.2847.19.camel@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141954.22724.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well done Ian!
That patch fixes the problem.
That explains the conditions needed to reproduce the oops. Konqueror would 
perform a number of lookups (some failing) before requesting the mountpoint 
directory.

On Saturday 14 January 2006 7:06 pm, Ian Kent wrote:

> Yes. It's me again.
>
> Could you try this patch please.
>
> --- linux-2.6.15/fs/autofs4/root.c.dumb-nameidata	2006-01-15
> 01:01:26.000000000 +0800 +++ linux-2.6.15/fs/autofs4/root.c	2006-01-15
> 01:02:12.000000000 +0800 @@ -193,6 +193,8 @@ static int
> autofs4_dir_open(struct inode
>  		if (!empty)
>  			d_invalidate(dentry);
>
> +		nd.dentry = dentry;
> +		nd.mnt = mnt;
>  		nd.flags = LOOKUP_DIRECTORY;
>  		status = (dentry->d_op->d_revalidate)(dentry, &nd);
