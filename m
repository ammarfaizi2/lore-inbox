Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLRWEN>; Mon, 18 Dec 2000 17:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLRWED>; Mon, 18 Dec 2000 17:04:03 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:62100 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129464AbQLRWDq>;
	Mon, 18 Dec 2000 17:03:46 -0500
Date: Mon, 18 Dec 2000 16:33:13 -0500
Message-Id: <200012182133.QAA02136@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: David Schwartz <davids@webmaster.com>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
In-Reply-To: Jamie Lokier's message of Mon, 18 Dec 2000 21:38:01 +0100,
	<20001218213801.A19903@pcep-jamie.cern.ch>
Subject: Re: /dev/random: really secure?
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 18 Dec 2000 21:38:01 +0100
   From: Jamie Lokier <lk@tantalophile.demon.co.uk>

   David Schwartz wrote:
   > The code does its best to estimate how much actual entropy it is gathering.

   A potential weakness.  The entropy estimator can be manipulated by
   feeding data which looks random to the estimator, but which is in fact
   not random at all.

Yes, absolutely.  That's why you have to be careful before you make
changes to the kernel code to feed additional data to the estimator.
*Usually* relying on interrupt timing is safe, but not always.  For
example, an adversary can observe, and in some cases control the
arrivial of network packets which control the network card's interrupt
timings.  Is it enough to be able to predict with cpu-counter
resolution the inputs to the /dev/random pool?  Maybe; it depends on how
paranoid you are.

Note that writing to /dev/random does *not* update the entropy estimate,
for this very reason.  The assumption is that inputs to the entropy
estimator have to be trusted, and since /dev/random is typically
world-writeable, it is not so trusted.

					- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
