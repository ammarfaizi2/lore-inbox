Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJBhr>; Tue, 9 Jan 2001 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbRAJBhg>; Tue, 9 Jan 2001 20:37:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5258 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129406AbRAJBhc>;
	Tue, 9 Jan 2001 20:37:32 -0500
Date: Tue, 9 Jan 2001 17:20:08 -0800
Message-Id: <200101100120.RAA07805@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: jgarzik@mandrakesoft.com
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3A5BB985.8A249BE1@mandrakesoft.com> (message from Jeff Garzik on
	Tue, 09 Jan 2001 20:23:17 -0500)
Subject: Re: Updated zerocopy patch up on kernel.org
In-Reply-To: <200101100055.QAA07674@pizda.ninka.net> <3A5BB985.8A249BE1@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 09 Jan 2001 20:23:17 -0500
   From: Jeff Garzik <jgarzik@mandrakesoft.com>

   Is there any value to supporting fragments in a driver which
   doesn't do hardware checksumming?  IIRC Alexey had a patch to do
   such for Tulip, but I don't see it in the above patchset.

I'm actually considering making the SG w/o hwcsum situation illegal.

Basically, with SG only, you can run into some problems.
We don't prevent anyone from making modifications to the
paged data, we just grab references to the pages.

This works perfectly fine when the card does the checksumming,
the card DMAs a snapshot of the data into it's internal buffers,
checksums that local snapshot of the data, and the checksum is fine.

If, on the other hand, we're doing this in software, we can send out
packets with bad checksums.  The next retransmit could fix it up, but
this is a horrible scheme quality of implementation wise.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
