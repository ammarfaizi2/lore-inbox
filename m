Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAYJa2>; Thu, 25 Jan 2001 04:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYJaS>; Thu, 25 Jan 2001 04:30:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:18053 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129413AbRAYJaL>;
	Thu, 25 Jan 2001 04:30:11 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14959.61924.48548.388874@pizda.ninka.net>
Date: Thu, 25 Jan 2001 01:29:08 -0800 (PST)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <3A6F8415.8EC5DB23@uow.edu.au>
In-Reply-To: <200101242123.NAA00986@pizda.ninka.net>
	<3A6F8415.8EC5DB23@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton writes:
 > What I suggest we do here is to add a new flag to the per-device
 > table `HAS_HWCKSM' and use that to set the device capabilities,
 > rather than using the IS_CYCLONE stuff.  Then we can add cards
 > individually as confirmation comes in.

This idea sounds just fine.

 > I do have a 200-line 3c59x patch banked up - it does the following:
...
 > So...  How to coordinate these diffs?  I'd propose that I implement
 > the HAS_HWCKSM thing, test zerocopy with it on the five NICs which
 > I have.  Then what?  Ask Linus to merge the non-zc parts?

I have a better idea.  Look, all the dev->features and flag names are
in the kernel tree already.  The only thing which hasn't propagated
which the driver will reference are the skb frag things.  This code
referencing the skb frags in the 3c59x hard_start_xmit method you can
just protect with #ifdef MAX_SKB_FRAGS or similar.  See?

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
