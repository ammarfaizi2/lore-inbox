Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUDAUvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUDAUv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:51:27 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:45870 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S263161AbUDAUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:51:21 -0500
To: ak@suse.de, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-Id: <20040401205133.6C94F4B104@berman.michael-chastain.com>
Date: Thu,  1 Apr 2004 15:51:33 -0500 (EST)
From: mec.gnu@mindspring.com (Michael Elizabeth Chastain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> The solution from back then I actually liked best was to just round
> up to the next second instead of rounding down when going from 1s
> resolution to ns.

(My understanding of kernel internals is way rusty, so if I am
talking nonsense here, just hit me with a cluestick or ignore
me or something).

Ummm, I think that will just fail in the converse way if
insn-conditions.o is retained in the inode cache while
insn-conditions.c is dropped from the cache?

That is, consider these time-stamps:

  insn-conditions.c  SSSS.NS1
  insn-conditions.o  SSSS.NS2

Where SSSS is the same value on both files, and NS2 > NS1.

According to Ulrich, the current problem is that insn-conditions.o
is dropped from the cache, so NS2 becomes 0, and insn-conditions.o
becomes older than insn-conditions.c.

With your patch, suppose that insn-conditions.c is dropped from the
cache, while insn-conditions.o remains.  Then the timestamps will be:

  insn-conditions.c  SSSS+1.0
  insn-conditions.o  SSSS.NS2

We lose again, insn-conditions.c has become newer than insn-conditions.o.

insn-conditions.c is a generated file so I think this can actually
happen during a gcc build.

Michael C
