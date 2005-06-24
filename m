Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbVFXXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbVFXXHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 19:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVFXXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 19:07:32 -0400
Received: from thunk.org ([69.25.196.29]:9655 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S263106AbVFXXHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 19:07:19 -0400
Date: Fri, 24 Jun 2005 19:06:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050624230644.GA20185@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Masover <ninja@slaphack.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain> <42BC5D2E.1070307@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BC5D2E.1070307@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 12:21:18PM -0700, Hans Reiser wrote:
> There is an area where we suffered from writing fsck last.  When there
> are two leaf nodes with the same key range AND the bitmap cannot be
> trusted to tell us which is the valid one, we don't know which is the
> most recent, and pick arbitrarily.  Also, if you store a backup of V3,
> and you don't compress it, and you wipe out the bitmap blocks and need
> to use fsck, we don't know what blocks are backup image and what blocks
> are the fs.  We advise users to never store a V3 backup on V3 without
> compressing it.

Unfortunately, there are plenty of reasons why you might want to store
a filesystem image on disk besides for backup purposes:

	* Regression tests --- I have some 70+ small filesystem images
		used for e2fsck's regression test suite.  (I am always
		amazed how many filesystem fsck programs don't have
		regression test suites.)
	* Initial ram-disk images
	* Image files for qemu or user-mode-linux

... and probably many more.  None of these are safe to store on a
reiserfs3 filesystem if you're worried about fsck being robust after a
disk failure.

Funny thing.  When I tell system administrators who have been around
the block more than a few times about this particular "feature" of
reiserfs3, they usually very quickly decide that it's time to switch
to another filesystem.....

						- Ted
