Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUBQVWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUBQVUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:20:37 -0500
Received: from mail.shareable.org ([81.29.64.88]:9861 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266652AbUBQVRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:17:40 -0500
Date: Tue, 17 Feb 2004 21:17:32 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marc <pcg@goof.com>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217211732.GH24311@mail.shareable.org>
References: <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217163613.GA23499@mail.shareable.org> <20040217175209.GO8858@parcelfarce.linux.theplanet.co.uk> <20040217192917.GA24311@mail.shareable.org> <Pine.LNX.4.58.0402171134180.2154@home.osdl.org> <20040217203056.GC24311@mail.shareable.org> <Pine.LNX.4.58.0402171236180.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171236180.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >     1. Eliminate "." and ".." components, leaving only leading ".."s.
> 
> Who does this anyway? It's wrong. It gives the wrong answer if there was a 
> symlink somewhere.

It's wrong for GCC, but correct for HTML/XLink relative path
resolution.

> > O_NODOTDOT won't protect against that.
> 
> Ok, so explain why? O_NODOTDOT will certainly guarantee that it stays
> inside "/var/public/files", since it has no way to escape (modulo
> symlinks/mounts, of course).

Oh, I meant to say "will" but my mailer must have used the wrong
character encoding. :)

> O_NOMOUNT may actually become a good idea.

Right now, you can avoid crossing filesystems by calling lstat()
_except_ that it doesn't detect a bind mount.  Among other things,
this makes it difficult to know for sure when there is only one path
to a file, because n_link==1 doesn't mean that any more.  O_NOMOUNT
might be useful as a way to detect when you're crossing a bind mount.

-- Jamie
