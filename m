Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSJaSv6>; Thu, 31 Oct 2002 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJaSv6>; Thu, 31 Oct 2002 13:51:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45836 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262712AbSJaSvy>; Thu, 31 Oct 2002 13:51:54 -0500
Date: Thu, 31 Oct 2002 10:57:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
In-Reply-To: <20021031163104.A9845@infradead.org>
Message-ID: <Pine.LNX.4.44.0210311053170.1526-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Christoph Hellwig wrote:

> On Thu, Oct 31, 2002 at 07:24:40PM +0300, Nikita Danilov wrote:
> > Reiser4 stores meta-data in a huge balanced tree. This tree is kept
> > (partially) in the page cache. All pages in this tree are attached to
> > "fake" inode. Sometimes you need to remove node from the tree. At this
> > moment page has to be removed from the fake inode mapping.
> 
> What about chaing truncate_inode_pages to take an additional len
> argument so you don't have to remove all pages past an offset?

Actually, we may want that for other reasons anyway. In particular, I can
well imagine why a networked filesystem in particular might want to
invalidate a range of a file cache, but not necessarily all of it.

(Yeah, I don't know of any network filesystem that does invalidation on
anything but a file granularity, but I assume such filesystems have to
exist. Especially in cluster environments it sounds like a sane thing to
do invalidates on a finer granularity)

			Linus

