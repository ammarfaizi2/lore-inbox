Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUGMTtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUGMTtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 15:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUGMTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 15:49:17 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:23687 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S265743AbUGMTtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 15:49:16 -0400
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
In-reply-to: <20040713115716.4db55d72.akpm@osdl.org> (message from Andrew
	Morton on Tue, 13 Jul 2004 11:57:16 -0700)
Subject: Re: [PATCH] fix inode state corruption (2.6.8-rc1-bk1)
References: <E1BkNI0-0007j5-00@dorka.pomaz.szeredi.hu> <20040713115716.4db55d72.akpm@osdl.org>
Message-Id: <E1BkTFw-0007z9-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 Jul 2004 21:48:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > This patch fixes a hard-to-trigger condition, where the inode is on
> >  the inode_in_use list while it's state is dirty.  In this state dirty
> >  pages are not written back in sync() or from kupdate, only from direct
> >  page reclaim.  And this causes a livelock in balance_dirty_pages after
> >  a while.
> 
> How ghastly.
> 
> Why did you make the list movement conditional on non-zero `wait'?

Because, I think this particular case can only happen in sync
writeback.  Otherwise the inode_lock is not released in
__writeback_single_inode so the inode must be on the s_io list.  I
don't see wheter it makes any difference performance-wise whether the
inode is left on s_io or unconditionally moved to s_dirty, but this is
the smaller change.

Miklos
