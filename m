Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUHZU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUHZU25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269562AbUHZUMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:12:38 -0400
Received: from mail.shareable.org ([81.29.64.88]:62150 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269232AbUHZTyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:54:09 -0400
Date: Thu, 26 Aug 2004 20:53:57 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hans Reiser <reiser@namesys.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826195357.GY5733@mail.shareable.org>
References: <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826183532.GP1501@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826183532.GP1501@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Aug 26, 2004 at 01:49:15AM -0700, Hans Reiser wrote:
> > Yes, this was part of the plan, tar file-directory plugins would be cute.
> 
> 	Question:  Is "cat /foo/bar/baz.tar.gz/metas" the attribute
> directory or a directory in the tarball named "metas"?

This needs to be designed.

Perhaps /foo/bar/baz.tar.gz/tar/metas is the directory in the tarball
named "metas".

Or perhaps /foo/bar/baz.tar.gz/x/metas is: it's independent of archive
format, and I personally tend to extract things into a directory
called "x". [*]

Or perhaps /foo/bar/baz.tar.gz/metas is, and the attribute directory
is /foo/bar/baz.tar.gz/../metas, to be perverse ;)

I prefer the second one, ("x/metas"), but not with any conviction.

-- Jamie


[*] Actually I prefer:

      /foo/bar/baz.tar.gz/content/metas
      /foo/bar/baz-0.01.tar.gz/content/baz-0.01/metas

           Archives always in "content".  One layer of decompression
           always tried for .tar files and other uncompressed archive
           formats.

      /foo/bar/baz.tar.gz/x -> content/
      /foo/bar/baz-0.01.tar.gz/x -> content/baz-0.01/

           If the root of the archive contains a single directory, "x"
           is a symlink to it.  Otherwise "x" is a symlink to the root
           directory of the archive.  This is comfortable with the
           common practice by which archives are distributed, without
           making a mess when someone forgets to put everything in a
           top-level directory.
