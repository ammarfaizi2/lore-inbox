Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZBbj>; Thu, 25 Jan 2001 20:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAZBb3>; Thu, 25 Jan 2001 20:31:29 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50572 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129169AbRAZBbZ>;
	Thu, 25 Jan 2001 20:31:25 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.54069.369317.517425@pizda.ninka.net>
Date: Thu, 25 Jan 2001 17:30:29 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <94qcvm$9qp$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H. Peter Anvin writes:
 > I do think they have a point, though; ECN is listed as an
 > experimental standard at IETF, and I do think that it's not exactly
 > fair to *require* everyone to use it until it is standards-track.
 > It would be another thing if Linux could turn it off on a
 > per-connection basis if these packets get dropped.

Firstly, how do these things make standards status if everybody
twiddles their fingers and ignores the issues at the high volume sites
so the thing can't be effectively beta tested by researchers?

Secondly, the RFCs are pretty clear that the bits in question used for
ECN are _reserved_ and to be ignored by implementations.  That means
to not be interpreted, and more importantly not used to discard
packets.

It is specifically described in this way so that things like ECN _can_
be deployed without worrying about existing implementations being
confused.

These sites ignoring this issue, and the fix existing from the vendors
of products with the problem, are only exacerbating the situation.  A
better internet will take longer because they are doing this.  This
better internet with full blown ECN is in their best interest, it will
allow them to serve more connections, more customers, and make more
money.

Thirdly, it was widely discussed by the ECN reserachers on how to
"detect ECN blackholes" sort to speak.  All such schemes suggested
we unusable, it is not doable without impacting performance _and_
violating existing RFCs.  Basically, you have to ignore a valid TCP
reset to deal with some of the ECN holes out there, that is where such
workaround attempts become full crap and are unsatisfactory for
inclusion in any implementation much less an RFC.  Happily, we got the
ECN folks to agree with Alexey and myself on these points.

So turning it off on a per-connection basis is not really an option.

 > In this case, though, they feel that they don't want to potentially
 > destabilize their network over something that is labelled an
 > experimental standard.  I can certainly understand their point.

That's respectible.

However, to my knowledge the fix in question is available from Cisco
as a fully supported "safe" patch, rather than some haphazard beta
patch.

I think it's just a "fud to avoid a small burdon issue" on the hotmail
folks part.  Well, if this is the case they can just let me know how
many support mails at which the burdon of verifying installation of
the fix from Cisco will not see so bad in comparison :-)

Finally, regardless of whether ECN is a standard or not, making
any interpretation of the reserved bits is at best a violation
of the "be liberal of what you receive" mantra of the internet
standards committee which the hotmail person quoted seemed so
keen on mentioning :-)

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
