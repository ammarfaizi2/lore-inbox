Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136072AbRAYUp4>; Thu, 25 Jan 2001 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRAYUpi>; Thu, 25 Jan 2001 15:45:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23178 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136071AbRAYUpZ>;
	Thu, 25 Jan 2001 15:45:25 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.36869.977528.642327@pizda.ninka.net>
Date: Thu, 25 Jan 2001 12:43:49 -0800 (PST)
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        andrewm@uow.EDU.AU (Andrew Morton)
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <200101252028.f0PKSJR02124@moisil.dev.hydraweb.com>
In-Reply-To: <200101251929.WAA10001@ms2.inr.ac.ru>
	<200101252028.f0PKSJR02124@moisil.dev.hydraweb.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ion Badulescu writes:
 > Well, yes and no. It's not quite orthogonal, because normally TCP
 > will never transmit fragmented packets, and it's precisely fragmented
 > packets that make the interesting case with a card that supports
 > hardware TCP/UDP checksums.

No it is not the interesting case for such cards.  I have a feeling
you have no idea what you are talking about or who you are speaking
to.  Alexey bascially implemented all of the zerocopy stuff in that
patch, so it's a good bet that he has a good idea what is orthogonal
or not.

 > If the packets are not fragmented, then the card can just verify the
 > checksums and be done with it. However, with fragments, all it can
 > do is report a partial checksum to the driver and let the driver
 > (or the stack) combine those partial checksums into one complete
 > checksum once all fragments have arrived. At least that's what the
 > Starfire card does, maybe the 3com is different. :-)

On transmit, on transmit, that's all that matters on the hardware side
with these changes, where the card does the checksumming for us.
We've supported receive checksum verification from the hardware
forever, long before these changes.

The only interesting new thing on receive is that we do not linearize
a fragmented packet before passing it on to UDP etc.  And this has
nothing to do with what the card can or cannot do, it is purely a
software issue.

 > And, on a related note: what's involved in making a driver
 > zerocopy-aware? I haven't looked too closely to the current patch,

When you look closely at the current patch, you will see exactly what
is required.  3 hardware drivers are ported there, and are to be used
as examples.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
