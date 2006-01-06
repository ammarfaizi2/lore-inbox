Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932858AbWAFSql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbWAFSql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbWAFSql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:46:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30047 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932858AbWAFSqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:46:40 -0500
Date: Fri, 6 Jan 2006 19:48:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Khushil Dep <khushil.dep@help.basilica.co.uk>,
       Al Viro <viro@ftp.linux.org.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
Message-ID: <20060106184810.GR3389@suse.de>
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk> <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06 2006, Jesper Juhl wrote:
> gcc is right to warn in the sense that it doesn't know if
> bvec_alloc_bs() will read or write into idx when its address is passed

The function is right there, on top of bio_alloc_bioset(). It's even
inlined. gcc has absolutely no reason to complain.

> to it. But since we know that bvec_alloc_bs() only reads from it after

bio_alloc_bioset() you mean.

> having assigned a value we know that gcc's warning is wrong, idx can
> never *actually* be used uninitialized.

Indeed, that's the whole point. For the original submitter, you are not
the first to submit this. See archives for basically the same thread as
this one...

-- 
Jens Axboe

