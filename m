Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBEV6f>; Mon, 5 Feb 2001 16:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRBEV6Z>; Mon, 5 Feb 2001 16:58:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14599 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129031AbRBEV6N>; Mon, 5 Feb 2001 16:58:13 -0500
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
To: sct@redhat.com (Stephen C. Tweedie)
Date: Mon, 5 Feb 2001 21:51:23 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        sct@redhat.com (Stephen C. Tweedie),
        manfred@colorfullife.com (Manfred Spraul),
        hch@caldera.de (Christoph Hellwig), lord@sgi.com (Steve Lord),
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010205205429.V1167@redhat.com> from "Stephen C. Tweedie" at Feb 05, 2001 08:54:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PtXi-0004Fp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, this is exactly where we have a problem: I can see too many cases
> where we *do* need to know about completion stuff at a fine
> granularity when it comes to disk IO (unlike network IO, where we can
> usually rely on a caller doing retransmit at some point in the stack).

Ok so whats wrong with embedded kiovec points into somethign bigger, one
kmalloc can allocate two arrays, one of buffers (shared with networking etc)
followed by a second of block io completion data.

Now you can also kind of cast from the bigger to the smaller object and get
the right result if the kiovec array is the start of the combined allocation


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
