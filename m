Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbQLWBuf>; Fri, 22 Dec 2000 20:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbQLWBu0>; Fri, 22 Dec 2000 20:50:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:5134 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130214AbQLWBuT>; Fri, 22 Dec 2000 20:50:19 -0500
Date: Fri, 22 Dec 2000 21:26:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <84320000.977527131@coffee>
Message-ID: <Pine.LNX.4.21.0012221933050.3382-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Dec 2000, Chris Mason wrote:

> It is enough to leave buffer heads we don't flush on the dirty list (and
> redirty the page), they'll get written by a future loop through
> flush_dirty_pages, or by page_launder.  We could use ll_rw_block instead,
> even though anon pages do have a writepage with this patch (just check if
> page->mapping == &anon_space_mapping).

If we use ll_rw_block directly on buffers of anonymous pages
(page->mapping == &anon_space_mapping) instead using
dirty_list_writepage() (which will end up calling block_write_anon_page)
we can fix the buffer flushtime issue.

> There are lots of things we could try here, including some logic inside
> block_write_anon_page to check the current memory pressure/dirty levels to
> see how much work should be done.

At writepage() context we do not know if we should care about the
flushtime.

> I'll play with this a bit, but more ideas would be appreciated.
>
> BTW, recent change to my local code was to remove the ll_rw_block call from
> sync_page_buffers.  It seemed cleaner than making try_to_free_buffers
> understand that sometimes writepage will be called, and sometimes the page
> will end up unlocked because of it....comments?

Could you please send me your latest patch ?

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
