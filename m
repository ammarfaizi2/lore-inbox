Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPlZ>; Tue, 9 Jan 2001 10:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRAIPlP>; Tue, 9 Jan 2001 10:41:15 -0500
Received: from chiara.elte.hu ([157.181.150.200]:16396 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131134AbRAIPlI>;
	Tue, 9 Jan 2001 10:41:08 -0500
Date: Tue, 9 Jan 2001 16:40:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephen Frost <sfrost@snowman.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, <hch@caldera.de>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109102525.Q26953@ns>
Message-ID: <Pine.LNX.4.30.0101091638130.4491-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen Frost wrote:

> 	Now, the interesting bit here is that the processes can grow to be
> pretty large (200M+, up as high as 500M, higher if we let it ;) ) and what
> happens with MOSIX is that entire processes get sent over the wire to
> other machines for work.  MOSIX will also attempt to rebalance the load on
> all of the machines in the cluster and whatnot so it can often be moving
> processes back and forth.

then you'll love the zerocopy patch :-) Just use sendfile() or specify
MSG_NOCOPY to sendmsg(), and you'll see effective memory-to-card
DMA-and-checksumming on cards that support it.

the discussion with Stephen is about various device-to-device schemes.
(which Mosix i dont think wants to use. Mosix wants to use memory to
device zero-copy, right?)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
