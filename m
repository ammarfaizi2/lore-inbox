Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSJaQSm>; Thu, 31 Oct 2002 11:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbSJaQSl>; Thu, 31 Oct 2002 11:18:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:26127 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262804AbSJaQSU>; Thu, 31 Oct 2002 11:18:20 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.22856.534975.384956@laputa.namesys.com>
Date: Thu, 31 Oct 2002 19:24:40 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
In-Reply-To: <20021031161826.A9747@infradead.org>
References: <15809.21559.295852.205720@laputa.namesys.com>
	<20021031161826.A9747@infradead.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Tomato: Green
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Thu, Oct 31, 2002 at 07:03:03PM +0300, Nikita Danilov wrote:
 > > Hello, Linus,
 > > 
 > >     Following patch exports remove_from_page_cache(). reiser4 stores all
 > >     meta-data in the page cache. When piece of meta-data is removed,
 > >     corresponding page has to be removed from the page cache (this is
 > >     similar to truncate, but for meta-data), explicit call to
 > >     remove_from_page_cache() is required at this point.
 > 
 > Could you please explain the code that needs it?  No one should
 > call this in individual filesystem drivers.

Reiser4 stores meta-data in a huge balanced tree. This tree is kept
(partially) in the page cache. All pages in this tree are attached to
"fake" inode. Sometimes you need to remove node from the tree. At this
moment page has to be removed from the fake inode mapping.

Other file systems don't need remove_from_page_cache() because they only
store in the page cache data (and remove_from_page_cache() is called by
truncate()) and meta data that are never explicitly deleted (like
directory content in ext2).

Nikita.
