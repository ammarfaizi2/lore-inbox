Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSHBQuT>; Fri, 2 Aug 2002 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSHBQuT>; Fri, 2 Aug 2002 12:50:19 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:28378 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316592AbSHBQuS>;
	Fri, 2 Aug 2002 12:50:18 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.47386.247705.533190@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 09:53:46 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: adjust prefetch in free_one_pgd()
In-Reply-To: <1028311133.18317.96.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
	<1028310567.18635.87.camel@irongate.swansea.linux.org.uk>
	<15690.46452.806917.37660@napali.hpl.hp.com>
	<1028311133.18317.96.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 02 Aug 2002 18:58:53 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >>  Cacheable and side-effects don't go together.  Even without
  >> explicit software prefetches, most modern CPUs will happily and
  >> aggressively prefetch stuff from cacheable translations.

  Alan> Yes we got burned on that with the latest AMD processors. They
  Alan> prefetch into an area we accidentally have marked with
  Alan> differing cachabilities between kernel and user space when
  Alan> using the nv binary driver stuff (but its our bug not
  Alan> theirs). There's a horrid hack in 2.4.19rc to deal with it
  Alan> pending merging the proper patches

Yes, I'm well aware of this issue as ia64 has basically the same setup
in this regard.  For ia64, it seems to be acceptable to require
that AGP DMA operates in coherent mode, so that all the memory can be
mapped cacheable.  With old chipsets, coherent AGP DMA is slow, but
with more recent chipsets (including hp's zx1), there won't be a
performance penalty.  I realize that this isn't a solution for x86 as
there is too much of an installed base.

	--david
