Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAIMAU>; Tue, 9 Jan 2001 07:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAIL77>; Tue, 9 Jan 2001 06:59:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28033 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129584AbRAIL74>;
	Tue, 9 Jan 2001 06:59:56 -0500
Date: Tue, 9 Jan 2001 03:42:47 -0800
Message-Id: <200101091142.DAA01640@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: hch@caldera.de
CC: mingo@elte.hu, riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010109122810.A3115@caldera.de> (message from Christoph Hellwig
	on Tue, 9 Jan 2001 12:28:10 +0100)
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.21.0101081603080.21675-100000@duckman.distro.conectiva> <Pine.LNX.4.30.0101091051460.1159-100000@e2> <20010109113145.A28758@caldera.de> <200101091031.CAA01242@pizda.ninka.net> <20010109122810.A3115@caldera.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 9 Jan 2001 12:28:10 +0100
   From: Christoph Hellwig <hch@caldera.de>

   Sure.  But sendfile is not one of the fundamental UNIX operations...

It's a fundamental Linux interface and VFS-->networking interface.

   An alloc_kiovec before and an free_kiovec after the actual call
   and the memory overhaed of a kiobuf won't hurt so much that it stands
   against a clean interface, IMHO.

This whole exercise is pointless unless it performs well.

The overhead _DOES_ matter, we've tested and profiled all of this with
full specweb99 runs, zerocopy ftp server loads, etc.  Removing one
word of information from anything involved in these code paths makes
enormous differences.  Have you run such tests with your suggested
kiobuf scheme?

Know what I really hate?  People who are talking, "almost done", and
"designing" the "real solution" to a problem and have no code to show
for it.  Ie. a total working implementation.  Often they have not one
line of code to show.

Then the folks who actually get off their lazy asses and make
something real, which works, and in fact exceeded most of our personal
performance expectations, are the ones who are getting told that what
they did was crap.

What was the first thing out of people's mouths?  Not "nice work", but
"I think writepage is ugly and an eyesore, I hope nobody seriously
considers this code for inclusion."  Keep designing... like Linus
says, "show me the code".

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
