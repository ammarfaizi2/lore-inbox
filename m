Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUIAWPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUIAWPf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267708AbUIAWMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:12:51 -0400
Received: from mail.shareable.org ([81.29.64.88]:19914 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268165AbUIAWHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:07:04 -0400
Date: Wed, 1 Sep 2004 23:05:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alex Zarochentsev <zam@namesys.com>
Cc: Christophe Saout <christophe@saout.de>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901220546.GL31934@mail.shareable.org>
References: <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826140500.GA29965@fs.tum.de> <1093530313.11694.56.camel@leto.cs.pocnet.net> <20040826150434.GF5733@mail.shareable.org> <20040829123428.GP5108@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829123428.GP5108@backtop.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:
> > > What reiser4 can do, but the VFS can't is to insert or remove data in
> > > the middle of a file. Adding this above the page cache would probably be
> > > almost impossible (truncate seems already complicated enough).
> > 
> > That would be one of those "special features" that a
> > VFS-plus-userspace implementation of archive views could take
> > advantage of on reiser4, while using a slower method (sometimes much
> > slower) on all other filesystems.
> > 
> > By the way, can reiser4 share parts of files between different files?
> 
> no, those file plugins are not written yet :)
> 
> Do you mean COW files or some another thing?

COW files would be nice as well, but I meant another thing: for files
which are parts of an uncompressed archive, it makes sense, if the fs
offers it efficiently, to share the storage.

Doing it properly requires that memory is also shared, for example
when COW files are used to isolate trees in virtual server jails, you
still want the mapped executables to share memory.

You can't do that just by writing a plugin.

> For COW files, the reiser4 support is not enough, we need to teach
> cp(1) or another utility to inform the fs layer that copying can be
> done by creation of COW files.

Actually we don't.  The VM and VFS layers could deduce it with no
changes to cp(1), by tracking which pages are identical due to read(3)
and write(3).  However, changing cp(1) is easier.

reiser4 support is obviously the first prerequisite...

-- Jamie
