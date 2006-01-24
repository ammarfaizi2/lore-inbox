Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWAXLGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWAXLGH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 06:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWAXLGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 06:06:07 -0500
Received: from mail.gmx.net ([213.165.64.21]:49296 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030449AbWAXLGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 06:06:06 -0500
X-Authenticated: #428038
Date: Tue, 24 Jan 2006 12:06:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060124110601.GC26042@merlin.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <20060123213400.GC14409@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123213400.GC14409@thunk.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Theodore Ts'o wrote:

> On Mon, Jan 23, 2006 at 07:55:49PM +0100, Matthias Andree wrote:
> > The question that's open is one for the libc guys: malloc(), valloc()
> > and others seem to use mmap() on some occasions (for some allocation
> > sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
> > if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
> > is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
> > then drops privileges.
> 
> Maybe mlockall(MLC_FUTURE) when run with privileges should
> automatically adjust the RLIMIT_MEMLOCK resource limit?

Adding special cases to no end.
Is this really sensible?

How about leaving RLIMIT_MEMLOCK alone (and at RLIM_INFINITY) for root
processes altogether? At least that wouldn't add a new special case but
just change the existing one to remove an inconsistency, and the effect
will be the same, only that it is inherited across seteuid().

I doubt that the kernel is the right place to implement policies that
belong into user space.  As long as the kernel is meant to be universal,
any default will collide with an application's requirement sooner or
later.

-- 
Matthias Andree
