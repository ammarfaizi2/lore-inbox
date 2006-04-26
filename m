Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWDZUDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWDZUDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDZUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:03:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:58000 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932370AbWDZUDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:03:19 -0400
Message-ID: <444FD204.7040708@garzik.org>
Date: Wed, 26 Apr 2006 16:03:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git patch] fuse fixes
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> Linus,
> 
> Please pull from 'for-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/mszeredi/fuse.git

Reading the code...
> struct fuse_req *fuse_request_alloc(void)
> {
>         struct fuse_req *req = kmem_cache_alloc(fuse_req_cachep, SLAB_KERNEL);
>         if (req)
>                 fuse_request_init(req);
>         return req;
> }

This function is called from everywhere, and so, it looks like it should 
use SLAB_NOFS rather than SLAB_KERNEL.  I would audit every GFP_KERNEL 
and SLAB_KERNEL usage, and consider replacing with SLAB_NOFS or GFP_NOFS.

	Jeff


