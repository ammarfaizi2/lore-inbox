Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWD0GJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWD0GJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWD0GJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:09:30 -0400
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:18637 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964948AbWD0GJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:09:29 -0400
To: jeff@garzik.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <444FD204.7040708@garzik.org> (message from Jeff Garzik on Wed,
	26 Apr 2006 16:03:16 -0400)
Subject: Re: [git patch] fuse fixes
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> <444FD204.7040708@garzik.org>
Message-Id: <E1FYzgA-0002V4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Apr 2006 08:08:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This function is called from everywhere, and so, it looks like it should 
> use SLAB_NOFS rather than SLAB_KERNEL.  I would audit every GFP_KERNEL 
> and SLAB_KERNEL usage, and consider replacing with SLAB_NOFS or GFP_NOFS.

GFP_NOFS doesn't make much sense, since mm never calls back into FUSE
anyway: FUSE writes through the page-cache, and hence never dirties
any pages.

I'll add a comment to fuse_request_alloc().

Thanks,
Miklos
