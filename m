Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263289AbSJaQ7e>; Thu, 31 Oct 2002 11:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJaQ6Y>; Thu, 31 Oct 2002 11:58:24 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:22535 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263218AbSJaQ6T>; Thu, 31 Oct 2002 11:58:19 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.25256.143498.726816@laputa.namesys.com>
Date: Thu, 31 Oct 2002 20:04:40 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
In-Reply-To: <20021031165819.A11604@infradead.org>
References: <15809.21559.295852.205720@laputa.namesys.com>
	<20021031161826.A9747@infradead.org>
	<15809.22856.534975.384956@laputa.namesys.com>
	<20021031163104.A9845@infradead.org>
	<15809.24115.993132.576769@laputa.namesys.com>
	<20021031165819.A11604@infradead.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Zippy-Says: It's today's SPECIAL!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Thu, Oct 31, 2002 at 07:45:39PM +0300, Nikita Danilov wrote:
 > > Interesting. Then, XFS and JFS meta data in the page cache probably
 > > are linearly ordered, and there it is never necessary to remove meta
 > > data page from the middle of the mapping, right?
 > 
 > The issue is rather different for XFS and JFS.  in JFS most metadata
 > (actually all metadata but the small superblock) is stored in inodes,
 > and it's accessed through the pagecache mapping for those inodes.
 > 
 > All access to those pages doesn't go directly through the pagecache
 > interface but a small metapage wrapper.  When the page is removed it's synced
 > to disk and removed from the metapage hash, so that you can't acess it
 > anymore.  It might still be on the VM lists for a while.

Interesting. But things like ->vm_writeback() and friends will go
directly to the page bypassing metapage wrapper, right? JFS checks that
page is still "live" on each low-level VM call?

 > 
 > XFS on the other hand only uses the blockdevice mapping to acess it's
 > metadata so it doesn't have to remove the page explicitly from the
 > cache ever.
 > 

Nikita.
