Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264782AbSJaSTK>; Thu, 31 Oct 2002 13:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSJaSTJ>; Thu, 31 Oct 2002 13:19:09 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:23046 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264782AbSJaSTD>; Thu, 31 Oct 2002 13:19:03 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.30100.403073.595578@laputa.namesys.com>
Date: Thu, 31 Oct 2002 21:25:24 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
In-Reply-To: <20021031173311.GA23959@clusterfs.com>
References: <15809.21559.295852.205720@laputa.namesys.com>
	<20021031161826.A9747@infradead.org>
	<15809.22856.534975.384956@laputa.namesys.com>
	<20021031163104.A9845@infradead.org>
	<20021031173311.GA23959@clusterfs.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Emacs: because idle RAM is the Devil's playground.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Oct 31, 2002  16:31 +0000, Christoph Hellwig wrote:
 > > On Thu, Oct 31, 2002 at 07:24:40PM +0300, Nikita Danilov wrote:
 > > > Reiser4 stores meta-data in a huge balanced tree. This tree is kept
 > > > (partially) in the page cache. All pages in this tree are attached to
 > > > "fake" inode. Sometimes you need to remove node from the tree. At this
 > > > moment page has to be removed from the fake inode mapping.
 > > 
 > > What about chaing truncate_inode_pages to take an additional len
 > > argument so you don't have to remove all pages past an offset?
 > 
 > That would be what we have been calling "punch", and is quite useful
 > for putting holes in files (i.e. making them sparse again).  This
 > can be used for InterMezzo (among other things) so that the KML log
 > file can be growing at the end, but being punched out at the start
 > so it doesn't use up a lot of disk space.

Abusing truncate for such things will remain abuse exactly. Separate
interface is required.

 > 
 > Not that I'm holding my breath on getting this in the kernel, but
 > it is definitely useful.
 > 
 > Cheers, Andreas

Nikita.
