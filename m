Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLAAym>; Thu, 30 Nov 2000 19:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLAAyc>; Thu, 30 Nov 2000 19:54:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1806 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129257AbQLAAy2>;
	Thu, 30 Nov 2000 19:54:28 -0500
Date: Thu, 30 Nov 2000 16:08:30 -0800
Message-Id: <200012010008.QAA07573@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ben@zeus.com
CC: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0011302342590.1741-100000@bagpipe.bogo.bogus>
	(message from Ben Mansell on Fri, 1 Dec 2000 00:15:45 +0000 (GMT))
Subject: Re: TCP push missing with writev()
In-Reply-To: <Pine.LNX.4.30.0011302342590.1741-100000@bagpipe.bogo.bogus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 1 Dec 2000 00:15:45 +0000 (GMT)
   From: Ben Mansell <ben@zeus.com>

   Paranoia check: can this bug occur with writev() and other
   combinations of sizes, or is it only when there is a 0-length
   buffer in there?

Only the 0-length buffer at the end of the iovec can trigger this
problem.  The PSH bit check during writes is basically:

	if (we are emptying the current iovec entry &&
            no more iovecs to process)
		set PSH bit

Zero length iovec entries do not even make it to this test
since the zero length makes the loop this test is within
never execute.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
