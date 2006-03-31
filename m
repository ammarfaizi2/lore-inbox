Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWCaHbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWCaHbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCaHbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:31:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751229AbWCaHbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:31:24 -0500
Date: Thu, 30 Mar 2006 23:30:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce sys_splice() system call
Message-Id: <20060330233059.42ee1ae2.akpm@osdl.org>
In-Reply-To: <20060331071635.GA14022@suse.de>
References: <200603302109.k2UL9Auj011419@hera.kernel.org>
	<20060330161240.11ee3d5f.akpm@osdl.org>
	<20060331071635.GA14022@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > > +	ret = write_one_page(page, 0);
>  > 
>  > Still want to know why this is here??
>  > 
>  > > +out:
>  > > +	if (ret < 0)
>  > > +		unlock_page(page);
>  > 
>  > If write_one_page()'s call to ->writepage() failed, this will cause a
>  > double unlock.
> 
>  Can probably be improved - can I drop write_one_page() and just unlock
>  the page and regular cleaning will flush it out?
> 

Of course - commit_write() will mark the page dirty and it'll get flushed
back in the normal manner.  We don't need that set_page_dirty() in there
either.

But we do need some O_SYNC/S_ISSYNC handling...
