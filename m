Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDSEBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDSEBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 00:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDSEBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 00:01:41 -0400
Received: from THUNK.ORG ([69.25.196.29]:21222 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261314AbVDSEBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 00:01:38 -0400
Date: Tue, 19 Apr 2005 00:01:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fortuna
Message-ID: <20050419040116.GA6517@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20050414141538.3651.qmail@science.horizon.com> <d3poiv$vrn$2@abraham.cs.berkeley.edu> <20050418191316.GL21897@waste.org> <d419gl$qvq$2@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d419gl$qvq$2@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 09:40:37PM +0000, David Wagner wrote:
> Yes, that is a minor glitch, but I believe all their points remain
> valid nonetheless.  My advice is to apply the appropriate s/MD5/SHA1/g
> substitution, and re-read the paper to see what you can get out of it.
> 
> The problem is not that the paper is shallow; it is not.  The source
> of the error is likely that this paper was written by theorists, not
> implementors.  There are important things we can learn from them, and I
> think it is worth reading their paper carefully to understand what they
> have to offer.

Since the paper was written by theorists, it appears that they didn't
bother to read the implementation, but instead made assumptions from
the man pages, as well as making the assumption that the man page
(which was not written as a specification from which the code was
implemented, and indeed was not even written by the code authors) was
in fact an accurate representation of drivers/char/random.c.

So section 5.3 is essense a criticism of a straw man implementation
based on a flawed reading of a flawed man page.  Other than that, it's
fine.  :-)

> I believe they raise substantial and deep questions in their Section 5.3.
> I don't see why you say Section 5.3 is all wrong.  Can you elaborate?
> Can you explain one or two of the substantial errors you see?

For one, /dev/urandom and /dev/random don't use the same pool
(anymore).  They used to, a long time ago, but certainly as of the
writing of the paper this was no longer true.  This invalidates the
entire last paragraph of Section 5.3.

The criticisms of the /dev/random man page do have some point, but the
man page != the implementation.  Also, the paper does not so much make
an attack on the entropy estimator, so much as it casts asperions on
it, while at the same time making the unspoken assumption that
cryptographic primitives are iron-clad and unbreakable.

So I don't see any particular substantial deep questions, unless you
count, "It is not at all clear that /dev/random ... provides
information-theoretic security.  Indeed, we suspect it sometimes
doesn't" as a deep question.  I don't.

						- Ted
