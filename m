Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263024AbTDBO6m>; Wed, 2 Apr 2003 09:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbTDBO6m>; Wed, 2 Apr 2003 09:58:42 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:57074 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263024AbTDBO6l>; Wed, 2 Apr 2003 09:58:41 -0500
Date: Wed, 2 Apr 2003 10:10:06 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jakob Oestergaard <jakob@unthought.net>,
       Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap-related questions
Message-ID: <20030402101006.A30582@redhat.com>
References: <20030401125020.E25225@redhat.com> <20030402031840.60077.qmail@web20005.mail.yahoo.com> <20030402093049.GB17859@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030402093049.GB17859@unthought.net>; from jakob@unthought.net on Wed, Apr 02, 2003 at 11:30:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 11:30:50AM +0200, Jakob Oestergaard wrote:
>   make_dirty(big_map)
>   msync(first half of big_map)
>   msync(second half of big_map)    { crash during this }
> 
> Then I am guaranteed that (unless the server crashes), the first half of
> big_map *will* have reached the server, but not that all of the second
> half has.   Right?

Assuming you used MS_SYNC for the msync() flags.  MS_ASYNC could still be 
proceeding to flush the pages out in the background.  And the kernel may 
have triggered writeback of the second half -- it is free to do so as it 
sees fit.

> Like any local-disk backed file.
> 
> Ignoring the case where the NFS *server* crashes, where could the write
> ordering differ, compared to local disk files ?

> In other words, what does Benjamin's "unexpected ways" refer to ?

All local clients will see the mmap() being updated from the time it is 
dirtied, but there is no ordering of write()s with respect to the mmap 
unless you explicitely msync(..MS_SYNC..) as in your example.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
