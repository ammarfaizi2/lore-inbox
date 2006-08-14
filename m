Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWHNXQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWHNXQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWHNXQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:16:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965051AbWHNXQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:16:47 -0400
Date: Mon, 14 Aug 2006 16:16:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, cmm@us.ibm.com
Subject: Re: + ext3-and-jbd-cleanup-replace-brelse-to-put_bh.patch added to
 -mm tree
Message-Id: <20060814161634.a24fe5a2.akpm@osdl.org>
In-Reply-To: <20060814225941.GB5175@martell.zuzino.mipt.ru>
References: <200608120146.k7C1kDVd006044@shell0.pdx.osdl.net>
	<20060814225941.GB5175@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 02:59:41 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Fri, Aug 11, 2006 at 06:46:13PM -0700, akpm@osdl.org wrote:
> > Replace all brelse() calls with put_bh().  Because brelse() is
> > old-fashioned, has a weird name and neelessly permits a NULL
> 
> > --- a/fs/ext3/balloc.c~ext3-and-jbd-cleanup-replace-brelse-to-put_bh
> > +++ a/fs/ext3/balloc.c
> > @@ -351,7 +351,7 @@ do_more:
> >  		overflow = bit + count - EXT3_BLOCKS_PER_GROUP(sb);
> >  		count -= overflow;
> >  	}
> > -	brelse(bitmap_bh);
> > +	put_bh(bitmap_bh);
> 
> Is it safe to always s/brelse/put_bh/ ? Or someone has to audit every
> occurence for this "neelessly permits a NULL"?

Yeah, it crashed all over the place.

I'd be inclined to give up on this idea.  Life's too short.
