Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBFJcM>; Tue, 6 Feb 2001 04:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129553AbRBFJbx>; Tue, 6 Feb 2001 04:31:53 -0500
Received: from chiara.elte.hu ([157.181.150.200]:51209 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129071AbRBFJbm>;
	Tue, 6 Feb 2001 04:31:42 -0500
Date: Tue, 6 Feb 2001 10:30:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102051658530.31998-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0102061027390.931-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Feb 2001, Linus Torvalds wrote:

> [...] But talk to Davem and ank about why they wanted vectors.

one issue is allocation overhead. The fragment array is a natural and
constant-size part of an skb, thus we get all the control structures in
place while allocating a structure that we have to allocate anyway.

another issue is that certain cards have (or can have) SG-limits, so we
have to be prepared to have a 'limited' array of fragments anyway, and
have to be prepared to split/refragment packets. Whether there is a global
MAX_SKB_FRAGS limit or not makes no difference.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
