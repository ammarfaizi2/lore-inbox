Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265168AbUFHCxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265168AbUFHCxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 22:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUFHCxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 22:53:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265168AbUFHCw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 22:52:57 -0400
Date: Tue, 8 Jun 2004 03:52:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs
Message-ID: <20040608025256.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <1086652124.14180.5.camel@dooby.cs.berkeley.edu> <20040608000310.GL12308@parcelfarce.linux.theplanet.co.uk> <1086656609.14180.16.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086656609.14180.16.camel@dooby.cs.berkeley.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 06:03:29PM -0700, Robert T. Johnson wrote:
> CQual has already found numerous bugs in driver ioctl code, all without
> any explicit annotations in that code.  This is possible because cqual
> infers the required annotations from a few annotations I gave it.  

Pardon me, but I will believe it when I see your bug reports.  All
I had been able to find on MARC was rather unimpressive; if that is
what you've found using cqual in several months...
 
> Maybe sparse has features that I don't know about, but since lots of
> device drivers have ioctl functions, doesn't that mean that lots of
> device drivers need at least one __user annotation (on the ioctl "arg"
> argument)?  If that annotation is missing and the device driver
> dereferences arg (after casting it to a pointer), won't this result in a
> false negative?  I agree that it's not a perfect metric, but it's a
> start.

First of all, it's nowhere near the majority of _files_.  Moreover,
the taint analysis is nowhere near "if it gives no warnings, we are
guaranteed to have no user/kernel pointer mixed".

The only way to convince anybody that it's worth the trouble is to
make your annotations available, run your stuff over the patched
tree and start posting fixes.  If it catches a lot of bugs - who
would argue against its usefulness?  If not - too bad, but then again
there would be no questions.

Neither sparse nor cqual will catch everything that could be, in theory,
automatically caught.  Same story as with optimizations - there's always
one more.

The real questions are
	a) how large subset of tree can $FOO survive?
	b) how many new bugs is $FOO catching?
	c) how much noise does $FOO produce and how hard it is to eliminate
that noise?
	d) how fast $FOO is (it _is_ important, if you hope to get a decent
code coverage, especially on non-x86 platforms).
	e) is everything needed for testing available ($FOO itself, patches
needed to use it on the tree usefully)?

And that's all that matters.  So far you said nothing on (a) or (d), had
rather unimpressive results posted on (b) and basically waved hands on (c).
Not sure about (e); are your initial annotations available for download?
