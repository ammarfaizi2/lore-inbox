Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSJaQYm>; Thu, 31 Oct 2002 11:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJaQYm>; Thu, 31 Oct 2002 11:24:42 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:8202 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262871AbSJaQYl>; Thu, 31 Oct 2002 11:24:41 -0500
Date: Thu, 31 Oct 2002 16:31:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021031163104.A9845@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
References: <15809.21559.295852.205720@laputa.namesys.com> <20021031161826.A9747@infradead.org> <15809.22856.534975.384956@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15809.22856.534975.384956@laputa.namesys.com>; from Nikita@Namesys.COM on Thu, Oct 31, 2002 at 07:24:40PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 07:24:40PM +0300, Nikita Danilov wrote:
> Reiser4 stores meta-data in a huge balanced tree. This tree is kept
> (partially) in the page cache. All pages in this tree are attached to
> "fake" inode. Sometimes you need to remove node from the tree. At this
> moment page has to be removed from the fake inode mapping.

What about chaing truncate_inode_pages to take an additional len
argument so you don't have to remove all pages past an offset?

> 
> Other file systems don't need remove_from_page_cache() because they only
> store in the page cache data (and remove_from_page_cache() is called by
> truncate()) and meta data that are never explicitly deleted (like
> directory content in ext2).

Sorry, but that's wrong.  XFS does use the pagecache for all metadata and JFS
for all but the superblock (which is never changed durin use)

