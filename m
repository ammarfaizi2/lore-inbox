Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265248AbSJRVMI>; Fri, 18 Oct 2002 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbSJRVMI>; Fri, 18 Oct 2002 17:12:08 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:8207 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S265248AbSJRVMI>; Fri, 18 Oct 2002 17:12:08 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: can chroot be made safe for non-root?
Date: 18 Oct 2002 21:00:34 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <aopspi$alg$1@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <20021018190101.GE237@elf.ucw.cz> <aopq2p$9pm$2@abraham.cs.berkeley.edu> <1034975267.2259.81.camel@zaphod>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1034974834 10928 128.32.153.211 (18 Oct 2002 21:00:34 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 18 Oct 2002 21:00:34 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaya Potter  wrote:
>the problem with chroot() is that they dont nest.

That's *a* problem, but not (IMHO) the most significant problem.
The biggest disadvantages with chroot() (as I see it) are:
 * not useable unless you're root
 * too coarse-grained
 * only protects the filesystem, but not other resources (e.g., the network)
 * not suitable for jailing root

> If however, one could provide even a single level of nesting, such that
> a chroot outside of a chroot sets the first level, and any other chroot
> after that sets the inner level, then even root wouldn't be able to
> break out of the chroot (presuming it didn't bring any fd's into the
> chroot w/ it).  

This is not quite right.  There are LOTS of other ways that root
can break out of a chroot.

Actually, I suspect that nested chroot()s may not be needed very
frequently, so I think a simpler approach may be simply to prevent
a chrooted process from calling chroot() again: i.e., prevent nesting.
