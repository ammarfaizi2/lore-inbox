Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTBKCGe>; Mon, 10 Feb 2003 21:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTBKCGe>; Mon, 10 Feb 2003 21:06:34 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:43454 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S261456AbTBKCGd>; Mon, 10 Feb 2003 21:06:33 -0500
Date: Tue, 11 Feb 2003 15:17:03 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: extra PG_* bits for page->flags
In-reply-to: <20030210162018.385642f0.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dhowells@redhat.com, torvalds@transmeta.com, jgarzik@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1044929823.1611.30.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20459.1044874267@warthog.cambridge.redhat.com>
 <20030210151244.7e42d3fb.akpm@digeo.com>
 <1044922034.4866.14.camel@laptop-linux.cunninghams>
 <20030210162018.385642f0.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 13:20, Andrew Morton wrote:
> 256 zones is fairly exorbitant.  I suspect the number of machines which have
> 
> a) more than 16 zones and 
> b) CONFIG_SOFTWARE_SUSPEND
> 
> is zero. So you can always munch into the top eight bits.

So bits <= 27 should be safe or are guaranteed safe? :> (Keep in mind
that people are starting to port swsusp to other archs)

> PG_checked is supposed to be removed - I have not looked into that.  PG_slab
> is fairly optional.
AFAICS, PG_checked is cleared in page_alloc.c and only otherwise used in
fs/ext2/dir.c, freexfs/xvfs_subr.c(commented out actually) and
afs/dir.c.

For PG_slab, should I understand 'fairly optional' to mean 'possibly
dangerous' (ie don't use)?

> PG_highmem can go away.  (just use page_zone(page)->is_highmem)

> I would dearly like to dump PG_reserved, but I doubt if I'll get onto that.
> (thinks about what happens if you start a direct-io read from a soundcard DMA
> buffer, and munmap/close while that is in progress...)
> 
> So.  There's not a lot of fat there, but we're not all out of options.

I can still happily do a few dynamically allocated bitmaps if there are
better things the bits can be used for. (The flags are not costly redo
and need to be redone each suspend & resume anyway).

Of course, on top of all of these questions, Pavel might not like my
code anyway so this might be a moot point :>

Anyway, for the moment, I'll proceed on the assumption that there'll be
enough flags, and I can always switch if needs be.

Regards,

Nigel

