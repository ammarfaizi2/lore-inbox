Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSJaQv5>; Thu, 31 Oct 2002 11:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbSJaQv4>; Thu, 31 Oct 2002 11:51:56 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:23306 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262937AbSJaQvz>; Thu, 31 Oct 2002 11:51:55 -0500
Date: Thu, 31 Oct 2002 16:58:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021031165819.A11604@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
References: <15809.21559.295852.205720@laputa.namesys.com> <20021031161826.A9747@infradead.org> <15809.22856.534975.384956@laputa.namesys.com> <20021031163104.A9845@infradead.org> <15809.24115.993132.576769@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15809.24115.993132.576769@laputa.namesys.com>; from Nikita@Namesys.COM on Thu, Oct 31, 2002 at 07:45:39PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:45:39PM +0300, Nikita Danilov wrote:
> Interesting. Then, XFS and JFS meta data in the page cache probably
> are linearly ordered, and there it is never necessary to remove meta
> data page from the middle of the mapping, right?

The issue is rather different for XFS and JFS.  in JFS most metadata
(actually all metadata but the small superblock) is stored in inodes,
and it's accessed through the pagecache mapping for those inodes.

All access to those pages doesn't go directly through the pagecache
interface but a small metapage wrapper.  When the page is removed it's synced
to disk and removed from the metapage hash, so that you can't acess it
anymore.  It might still be on the VM lists for a while.

XFS on the other hand only uses the blockdevice mapping to acess it's
metadata so it doesn't have to remove the page explicitly from the
cache ever.

