Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbQJ0Bdd>; Thu, 26 Oct 2000 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129938AbQJ0BdN>; Thu, 26 Oct 2000 21:33:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129774AbQJ0BdI>; Thu, 26 Oct 2000 21:33:08 -0400
Subject: Re: kqueue microbenchmark results
To: jlemon@flugsvamp.com (Jonathan Lemon)
Date: Fri, 27 Oct 2000 02:32:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jlemon@flugsvamp.com (Jonathan Lemon),
        gid@cisco.com (Gideon Glass), sim@stormix.com (Simon Kirby),
        dank@alumni.caltech.edu (Dan Kegel), chat@freebsd.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20001026201042.A38500@prism.flugsvamp.com> from "Jonathan Lemon" at Oct 26, 2000 08:10:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13oyOE-00044z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the application of a close event.  What can I say, "the fd formerly known
> as X" is now gone?  It would be incorrect to say that "fd X was closed",
> since X no longer refers to anything, and the application may have reused
> that fd for another file.

Which is precisely why you need to know where in the chain of events this
happened. Otherwise if I see

	'read on fd 5'
	'read on fd 5'

How do I know which read is for which fd in the multithreaded case

> As for the multi-thread case, this would be a bug; if one thread closes
> the descriptor, the other thread is going to get an EBADF when it goes 
> to perform the read.

Another thread may already have reused the fd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
