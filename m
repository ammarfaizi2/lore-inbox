Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268249AbRGWOhM>; Mon, 23 Jul 2001 10:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbRGWOgx>; Mon, 23 Jul 2001 10:36:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40718 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268247AbRGWOgp>; Mon, 23 Jul 2001 10:36:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        tuxx@aon.at (Alexander Griesser)
Subject: Re: [PATCH] 64 bit scsi read/write
Date: Mon, 23 Jul 2001 16:41:24 +0200
X-Mailer: KMail [version 1.2]
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        phillips@bonn-fries.net (Daniel Phillips), cw@f00f.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <200107220352.f6M3q8b159289@saturn.cs.uml.edu>
In-Reply-To: <200107220352.f6M3q8b159289@saturn.cs.uml.edu>
MIME-Version: 1.0
Message-Id: <01072316412405.00315@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 05:52, Albert D. Cahalan wrote:
> Alexander Griesser writes:
> > On Sun, Jul 15, 2001 at 09:08:41PM -0400, you wrote:
> >> In a tree-structured filesystem, checksums on everything would
> >> only cost you space similar to the number of pointers you have.
> >> Whenever a non-leaf node points to a child, it can hold a checksum
> >> for that child as well.  This gives a very reliable way to spot
> >> filesystem errors, including corrupt data blocks.
> >
> > Hmm, maybe this is crap, but: If the checksum-calculation for one
> > node fails, wouldn't that mean, that the data in this node, is not
> > to be trusted? therefore also the checksum of this node could be
> > corrupted and so the node, 2 hops away, can't be validated with
> > 100% certitude...
>
> If I understand you right ("one"? "this"?), yes and we want that.
>
> Node 1 has children 2, 3, and 4.
> Node 3 has children 5, 6, and 7.
> Node 6 has children 8, 9, and 10. (children might be data blocks)
>
> To have a child is to have a checksum+pointer pair.
>
> If node 3 contains a corrupt pointer to node 6, then it is unlikely
> that the checksum will match. So node 6 is bad, along 8, 9, and 10.
> (actually we might not be able to know that 8, 9, and 10 exist)
> This result is wonderful, since it prevents interpreting random
> disk blocks as useful data.
>
> If node 3 contains a corrupt checksum for node 6, same thing. Damn.
> This case should be rare, since why for node 1 have a checksum
> that is OK for node 3 if node 3 has corruption?
>
> If node 6 itself is corrupt, same thing. Good, we are stopped from
> using bad data.

I agree that your suggestion will work and that doubling the size of 
the metadata isn't an enormous cost, especially if you'd already 
compressed it using extents.  On the other hand, sometimes I just feel 
like trusting the hardware a little.  Both atomic-commit and 
journalling strategies take care of normal failure modes, and the disk 
hardware is supposed to flag other failures by ecc'ing each sector on 
disk.

--
Daniel
