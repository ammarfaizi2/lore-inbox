Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267909AbRGVGv4>; Sun, 22 Jul 2001 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267910AbRGVGvq>; Sun, 22 Jul 2001 02:51:46 -0400
Received: from are.twiddle.net ([64.81.246.98]:42378 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267909AbRGVGvg>;
	Sun, 22 Jul 2001 02:51:36 -0400
Date: Sat, 21 Jul 2001 23:49:52 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010721234952.A4349@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010721151055.A3676@twiddle.net> <Pine.LNX.4.33.0107212017470.6166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107212017470.6166-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Jul 21, 2001 at 08:43:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 08:43:43PM -0700, Linus Torvalds wrote:
> So:
>  - you _always_ generate the fast case. A call is always considered to be
>    a short one, simple "bsr", no GP change, no nothing.
>  - you generate a trampoline as well, and teach the linker to go through
>    the trampoline if it has to do a far call (one trampoline per target,
>    not per caller). Think of it as a "overflow" case for a .rel20.

This is all well and good if one is designing an ABI from scratch.
You can't retrofit it onto the current ABI, however.  Not without
pain anyway.

The call-clobbered GP means that your trampoline has to play games
in order to get the GP restored when coming back from an intra 
module call.  Which means a new stack frame.  Which is a tad more
than you bargined for, really.  I can't see that kind of heavyweight
solution being any better than the nops.


r~
