Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVF0Van@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVF0Van (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVF0V33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:29:29 -0400
Received: from thunk.org ([69.25.196.29]:62687 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261817AbVF0V0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:26:55 -0400
Date: Mon, 27 Jun 2005 17:26:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Markus T?rnqvist <mjt@nysv.org>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, Steve Lord <lord@xfs.org>
Subject: Re: reiser4 plugins
Message-ID: <20050627212628.GB27805@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>,
	Steve Lord <lord@xfs.org>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C0578F.7030608@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 12:46:23PM -0700, Hans Reiser wrote:
> A difference between us is
> that I tell them that with all the major linux filesystems (I include
> XFS and JFS in this)  it is by this time far more likely to be hardware
> that caused corruption than the filesystem software, whereas I guess you
> tell them something else.

Oh, I agree with this, and I do tell people that.  The question though
is how the filesystem recovers from said hardware-caused corruption
once it does happen.  You've admitted that reiserfs3 has less than
optimal recovery characteristics from hardware-induced corruptions if
said filesystem contains reiserfs filesystem images; that would be an
example of a filesystem not being as robust as it could be.  (It'll be
interesting to see if SuSE will support reiserfsv3 in combination with
the Xen hypervisor or other virtualization systems, which makes use of
filesystem images.)  Another example would be DMA'ing garbage into the
hard drive after a power failure --- how does a filesystem respond to
this eventuality?

You probably hear more stories people who got unlucky with
hardware-induced corruptions with ext2/3, and I probably hear more
from users who have sworn off of reiserfs just because are sample sets
are somewhat biased.  Such are the dangers of relying on anecdotal
evidence.

However, logically speaking, if a filesystem is designed such that in
certain cases, the fsck program has to brute-force search every single
disk block looking for data structures that _look_ like they might be
part of the filesystem data, well, that's always going to be more
error prone than one where the filesystem metadata is in
easily-predicted locations.  It sounds like you've added some more
checks in reiser4, and that's definitely a good thing.  Time will tell
whether they are sufficient or not.

Regards,

						- Ted
