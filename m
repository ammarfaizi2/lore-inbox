Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281039AbRKCVC1>; Sat, 3 Nov 2001 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKCVCR>; Sat, 3 Nov 2001 16:02:17 -0500
Received: from are.twiddle.net ([64.81.246.98]:9402 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S281039AbRKCVCF>;
	Sat, 3 Nov 2001 16:02:05 -0500
Date: Sat, 3 Nov 2001 13:01:56 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Juergen Doelle <jdoelle@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Pls apply this spinlock patch to the kernel
Message-ID: <20011103130156.D5984@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Juergen Doelle <jdoelle@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011103115556.A5984@twiddle.net> <Pine.LNX.4.33.0111031215490.2026-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111031215490.2026-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 03, 2001 at 12:20:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 12:20:53PM -0800, Linus Torvalds wrote:
> If you have a 4-byte entry that is aligned to 128 bytes, you have 124
> bytes of stuff that the linker _will_ fill up with other things.

If you put the alignment on the type, not the variable, e.g.

  typedef int aligned_int __attribute__((aligned(128)));
  aligned_int foo;

then sizeof(foo) == 128, and the linker sees a 128-byte object,
not a 4 byte object with 128 byte alignment.

It's a subtle difference between alignment of types and alignment
of variables, but it makes sense if you think about it.


r~
