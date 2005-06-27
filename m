Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVF0UeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVF0UeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVF0Ubc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:31:32 -0400
Received: from thunk.org ([69.25.196.29]:32991 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261726AbVF0U3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:29:24 -0400
Date: Mon, 27 Jun 2005 16:28:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Steve Lord <lord@xfs.org>
Cc: Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627202841.GA27805@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Steve Lord <lord@xfs.org>,
	Hans Reiser <reiser@namesys.com>, Markus T?rnqvist <mjt@nysv.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Masover <ninja@slaphack.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <42C05F16.5000804@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C05F16.5000804@xfs.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:18:30PM -0500, Steve Lord wrote:
> I presume Ted is referring to problems guaranteeing the integrity of
> the journal at recovery time. I am coming into this without all the
> available context, so I may be barking up the wrong tree.... In
> particular, I am not sure how journaling whole blocks protects
> you from this.

Actually, I was talking about the problem what happens when power
fails while DMA'ing to the disk, and memory, which is more sensitive
to voltage drops than the rest of the system, starts sending garbage
to the bus, which the disk then faithfully writes to the inode table.

As I recall, you were the one who told me about this problem, and how
it was fixed in Irix by using a powerfail interrupt to abort DMA
transfers, as well as giving me a program which tests for this
condition (basically it writes known test pattern to the disk, and
then you do an unclean shutdown, and you look to see if garbage is
written to the disk instead of one of the known test patterns).  If it
wasn't you, it must have been Jim Mostek --- but I could have sworn it
was you.....

						- Ted
