Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284731AbRLPRoC>; Sun, 16 Dec 2001 12:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284737AbRLPRnw>; Sun, 16 Dec 2001 12:43:52 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:58752 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S284731AbRLPRnm>;
	Sun, 16 Dec 2001 12:43:42 -0500
Date: Sun, 16 Dec 2001 12:43:33 -0500 (EST)
From: Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>
To: Terje Eggestad <terje.eggestad@scali.no>
cc: Andrew Morton <akpm@zip.com.au>, GOTO Masanori <gotom@debian.org>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: O_DIRECT wierd behavior..
In-Reply-To: <Pine.LNX.4.30.0112161454160.26995-100000@elin.scali.no>
Message-ID: <Pine.GSO.4.02A.10112161208160.25791-100000@aramis.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Dec 2001, Terje Eggestad wrote:
> The problem is that the kernel that don't support O_DIRECT has
> erronous handling of the O_DIRECT flag. Meaning they happily accept
> it. In order to figure out ifthe running kernel support O_DIRECT you
> MUST attempt an unaligned read/write, if it succed the kernel DON'T
> support O_DIRECT. TJ

You are right! It went through on 2.4.2 even with an unaligned buffer.

So direct i/o has to be multiple of page size blocks, from page aligned
buffer, and apparently into page aligned offset in the file! Is this the
expected behavior?

--suresh

> > Thanks for the patches. There seems to be one more fix required: the test
> > program below works in 2.4.16 only if the write size is a multiple of 4K.
> > (Why) are all writes expected to be page size, in addition to being page
> > aligned? (It works fine on 2.4.2 for all sizes). Any quick fixes? :)
> > --suresh


