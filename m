Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaSlv>; Sun, 31 Dec 2000 13:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaSlm>; Sun, 31 Dec 2000 13:41:42 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28184 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129324AbQLaSlf>; Sun, 31 Dec 2000 13:41:35 -0500
Date: Sun, 31 Dec 2000 19:10:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001231191045.B8027@athlon.random>
In-Reply-To: <20001231182127.A24348@gruyere.muc.suse.de> <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10012310924500.4029-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 09:27:23AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 09:27:23AM -0800, Linus Torvalds wrote:
> The alpha systems I remember this problem on were all [..]

Yes the granularity issue has nothing to do with SMP (with preemptive kernel
it can trigger even without interrupts involved into the code). Also
CONFIG_SPACE_EFFICIENT looks not necessary.

The x8 name is confusing IMHO (when I read `8' I expect 8bits only, the x
isn't explicit enough). But by using a better name we could save some byte on
alpha ev6 and x86. Something like granular_char/granular_short/granular_int
looks nicer.  For the generic 64bit cpu they needs to be _unconditionally_
defined to `long'.

BTW, only old chips (ev[45]) doesn't provide byte granularity. Infact a linux
kernel compiled for ev6 can handle byte granularity also on alpha (it uses
-mcpu=ev6).

alpha reference manual 5.2.2:

	[..] For each region, an implementation must support aligned quadword
	access and may optionally support aligned longword access or byte
	access. If byte access is supported in a region, aligned word access
	and aligned longword access are also supported. [..]

21264hrm:

	[..] The 21264-generated external references to memory space are
	always of a fixed 64-byte size, though the internal access granularity
	is byte, word, longword, or quad-word. [..]

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
