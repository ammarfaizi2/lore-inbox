Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131040AbQL1Fhp>; Thu, 28 Dec 2000 00:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132362AbQL1Fhe>; Thu, 28 Dec 2000 00:37:34 -0500
Received: from SMTP2.ANDREW.CMU.EDU ([128.2.10.82]:5522 "EHLO
	smtp2.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S131040AbQL1FhW>; Thu, 28 Dec 2000 00:37:22 -0500
Date: Thu, 28 Dec 2000 00:06:47 -0500 (EST)
From: Ari Heitner <aheitner@andrew.cmu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001228160005.B14479@metastasis.f00f.org>
Message-ID: <Pine.SOL.3.96L.1001228000150.3482A-100000@unix13.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Chris Wedgwood wrote:

> (cc' list trimmed)
[further]
> I use ramfs for /tmp on my laptop -- it's very handy because it
> extends the amount of the the disk had spent spun down and therefore
> battery life; but writing large files into /tmp can blow away the
> system or at the very least eat away at otherwise usable ram. Not
> terribly desirable.

mph.

does anyone other than me think that the pm code is *way* too agressive about
spinning down the hard drive? my 256mb laptop (2.2.16) will only spin down the
disk for about 30 seconds before it decides it's got something else it feels
like writing out, and spins back up. Spinnup has got to be more wasteful than
just leaving the drive spinning...

unless the vfs code is cleaning dirty pages to disk when there's no activity,
then any time the vfs writes to disk, it's got something that's really hot and
shouldn't stay in ram ... if that's the case, and the frequency of such
occurrences is so high, perhaps the pm code should wait a couple of times as
long as it does before it spins down. basically, if there's still code doing
stuff, the drive should be spinning. only spindown when we're sure the user has
walked away for good :)





ari



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
