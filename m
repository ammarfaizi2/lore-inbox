Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132009AbRARVEc>; Thu, 18 Jan 2001 16:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135669AbRARVEW>; Thu, 18 Jan 2001 16:04:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32096 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135623AbRARVED>; Thu, 18 Jan 2001 16:04:03 -0500
Date: Thu, 18 Jan 2001 22:04:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118220428.G28276@athlon.random>
In-Reply-To: <20010118212441.E28276@athlon.random> <200101182037.XAA08671@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101182037.XAA08671@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Jan 18, 2001 at 11:37:10PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 11:37:10PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > Doing PUSH from setsockopt(TCP_CORK) looked obviously wrong because it isn't
> > setting any socket state,
> 
> ? 8)

I thought setsockopt is meant to set an option in the socket, something
_stateful_, a PUSH doesn't set any option, it isn't stateful and it _only_
controls the I/O (aka ioctl ;). Anyways either ioctl or setsockopt is fine in
pratice so I've no real problem.

> > and also because the SIOCPUSH has nothing specific
> > with TCP_CORK, as said it can be useful also to flush the last fragment of data
> > pending in the send queue without having to wait all the unacknowledged data to
> > be acknowledged from the receiver when TCP_NODELAY isn't set.
> 
> Andrea, TCP_CORK and TCP_NODELAY is _one_ option, which was split to two
> mostly due to historical reasons. Its real name is TCP_CONTROL_NAGLING
> or something sort of this, only readable. 8)

NAGLE algorithm is only one, CORK algorithm is another different algorithm. So
probably it would be not appropriate to mix CORK and NAGLE under the name
"CONTROL_NAGLING", but certainly I agree they could stay together under another
name ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
