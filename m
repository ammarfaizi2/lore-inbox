Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWF1XQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWF1XQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWF1XQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:16:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:55250 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751768AbWF1XQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:16:32 -0400
X-Authenticated: #704063
Date: Thu, 29 Jun 2006 01:16:28 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Russ Cox <rsc@swtch.com>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Message-ID: <20060628231627.GA28463@alice>
References: <1151535167.28311.1.camel@alice> <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.17-mm3 (i686)
X-Uptime: 01:11:24 up 15:05,  6 users,  load average: 1.91, 1.39, 1.02
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russ Cox (rsc@swtch.com) wrote:
> >coverity (id #971) found some dead code. In all error
> >cases ret is NULL, so we can remove the if statement.
> >
> >Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> >
> >--- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig   2006-06-29 
> >00:50:53.000000000 +0200
> >+++ linux-2.6.17-git11/fs/9p/vfs_inode.c        2006-06-29 
> >00:51:11.000000000 +0200
> >@@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
> >
> > error:
> >        kfree(fcall);
> >-       if (ret)
> >-               iput(ret);
> >-
> >        return ERR_PTR(err);
> > }
> 
> What about when someone changes the code and does have ret != NULL here?
> This seems like reasonable defensive programming to me.
> 
> Is the official LK policy that we can't have code that trips coverity
> checks like this?

If this is whats agreed upon I will no longer send patches for
such bugs, and mark them as ignore in the coverity system.
But I guess it makes also sense to remove unused code, because I
am not sure if gcc can figure out to remove it. In this case
the generated object file is 10 bytes smaller.

Eric

