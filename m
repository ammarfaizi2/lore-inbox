Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSJaQkj>; Thu, 31 Oct 2002 11:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJaQje>; Thu, 31 Oct 2002 11:39:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:15123 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265228AbSJaQjO>; Thu, 31 Oct 2002 11:39:14 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.24115.993132.576769@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:45:39 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
In-Reply-To: <20021031163104.A9845@infradead.org>
References: <15809.21559.295852.205720@laputa.namesys.com>
	<20021031161826.A9747@infradead.org>
	<15809.22856.534975.384956@laputa.namesys.com>
	<20021031163104.A9845@infradead.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: I don't think you fellows would do so much RAPING and PILLAGING if
   you played more PINBALL and watched CABLE TELEVISION!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Thu, Oct 31, 2002 at 07:24:40PM +0300, Nikita Danilov wrote:
 > > Reiser4 stores meta-data in a huge balanced tree. This tree is kept
 > > (partially) in the page cache. All pages in this tree are attached to
 > > "fake" inode. Sometimes you need to remove node from the tree. At this
 > > moment page has to be removed from the fake inode mapping.
 > 
 > What about chaing truncate_inode_pages to take an additional len
 > argument so you don't have to remove all pages past an offset?

It is possible, I think. But this will look more of a hack. Truncate is
rather for truncating mapping than cutting one page from the middle.

Besides, current truncate_inode_pages() with all its
radix_tree_gang_lookup()'s and two passes doesn't looks like easily
adaptable.

 > 
 > > 
 > > Other file systems don't need remove_from_page_cache() because they only
 > > store in the page cache data (and remove_from_page_cache() is called by
 > > truncate()) and meta data that are never explicitly deleted (like
 > > directory content in ext2).
 > 
 > Sorry, but that's wrong.  XFS does use the pagecache for all metadata and JFS
 > for all but the superblock (which is never changed durin use)
 > 

Interesting. Then, XFS and JFS meta data in the page cache probably
are linearly ordered, and there it is never necessary to remove meta
data page from the middle of the mapping, right?

Nikita.
