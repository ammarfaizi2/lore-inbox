Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132061AbRAMUYy>; Sat, 13 Jan 2001 15:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbRAMUYo>; Sat, 13 Jan 2001 15:24:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:29496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132061AbRAMUYl>; Sat, 13 Jan 2001 15:24:41 -0500
Date: Sat, 13 Jan 2001 21:24:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre6aa1 weird error
Message-ID: <20010113212458.B25855@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0101132007540.11593-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101132007540.11593-100000@iq.rulez.org>; from sape@iq.rulez.org on Sat, Jan 13, 2001 at 08:10:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 08:10:33PM +0100, Sasi Peter wrote:
> Jan 13 01:58:17 iq kernel: probable hardware bug: clock timer
> configuration lost - probably a VIA686a.
> Jan 13 01:58:17 iq kernel: probable hardware bug: restoring chip
> configuration.
> 
> I get these, do not know why. MB is abit BH6, IDE controllers are the
> onboard and a WinFast CMD648.
> 
> Have never seen such before (2.0.x and 2.2.x up till now).
> 
> Bug rather in SW maybe?

That's a new check in the 2.2.19pre kernels (not part of the aa patchkit).

It means your timer chip didn't resetted itself to the timeout value (LATCH)
after triggering the irq and in turn it means you are losing system time (you
lose more time the the higher is the irq latency). I don't know the details of
the hardware bug though, maybe somebody else can give more details on it.

It doesn't look like a sw problem (previous kernel would malfunction silenty if
that would happen without such a new sanity check).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
