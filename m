Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268123AbRGWCIx>; Sun, 22 Jul 2001 22:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268124AbRGWCIn>; Sun, 22 Jul 2001 22:08:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:41296 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268123AbRGWCI3>; Sun, 22 Jul 2001 22:08:29 -0400
Date: Mon, 23 Jul 2001 04:08:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de
Subject: Re: RFC: block/loop.c & crypto
Message-ID: <20010723040846.F23517@athlon.random>
In-Reply-To: <20010723002158.A23517@athlon.random> <200107230147.f6N1lQV200016@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107230147.f6N1lQV200016@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Sun, Jul 22, 2001 at 09:47:26PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 09:47:26PM -0400, Albert D. Cahalan wrote:
> Andrea Arcangeli writes:
> > On Sun, Jul 22, 2001 at 08:53:50PM +0200, Herbert Valerio Riedel wrote:
> 
> >> security is not the issue; it's more of practical terms... since
> >> 512 byte seems to be the closest practical transfer size (there
> >> isn't any smaller blocksize supported with linux) it seems natural
> >> to use that one....
> >
> > to me it sounds more natural to use the 1k blocksize that seems to
> > be backwards compatible automatically (without the special case),
> > the only disavantage of 1k compared to 512bytes is the decreased
> > security, so if the decreased security is not your concern I'd
> > suggest to use the 1k fixed granularity for the IV. 1k is also the
> > default BLOCK_SIZE I/O granularity used by old linux (which
> > incidentally is why it seems backwards compatible automatically).
> 
> Being backwards compatible with non-Linus kernels is less important
> than choosing a block size that is fit for all block devices.
> Disks, partitions, and block-based filesystems are all organized
> in power-of-two multiples of 512 bytes.
> 
> The smaller size can handle the larger size; the reverse is not true.

I think you misunderstood the issue, IV granularity has nothing to do
with anything hardware. It is only a software convention.

> We all have to live with the size choice until the end of time.

1k fits for all block devices and filesystems you can invent, but it
also has the bonus that it should also be backwards compatible with the
current crypto transfer API.

As I just said said twice in this thread: the _only_ disavantage of 1k
compared to 512bytes is the decrease security, you will share the same
IV for the double number of bits, that's all. If the security point is
not your concern 1k is better (and a bit faster).

Andrea
