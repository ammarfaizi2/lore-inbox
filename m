Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbRBFBKQ>; Mon, 5 Feb 2001 20:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRBFBJ5>; Mon, 5 Feb 2001 20:09:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40577 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131532AbRBFBJt>;
	Mon, 5 Feb 2001 20:09:49 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14975.20110.299641.486211@pizda.ninka.net>
Date: Mon, 5 Feb 2001 17:08:30 -0800 (PST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102051658530.31998-100000@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.10.10102060052330.20184-100000@zeus.fh-brandenburg.de>
	<Pine.LNX.4.10.10102051658530.31998-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > But talk to Davem and ank about why they wanted vectors.

SKB setup and free needs to be as light as possible.
Using vectors leads to code like:

skb_data_free(...)
{
...
	for (i = 0; i < MAX_SKB_FRAGS; i++)
		put_page(skb_shinfo(skb)->frags[i].page);
}

Currently, the ZC patches have a fixed frag vector size
(MAX_SKB_FRAGS).  But a part of me wants this to be
made dynamic (to handle HIPPI etc. properly) whereas
another part of me doesn't want to do it that way because
it would increase the complexity of paged SKB handling
and add yet another member to the SKB structure.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
