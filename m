Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129235AbRAYU3D>; Thu, 25 Jan 2001 15:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135925AbRAYU2x>; Thu, 25 Jan 2001 15:28:53 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:519 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131811AbRAYU2h>; Thu, 25 Jan 2001 15:28:37 -0500
Date: Thu, 25 Jan 2001 12:28:19 -0800
Message-Id: <200101252028.f0PKSJR02124@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, andrewm@uow.EDU.AU (Andrew Morton)
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <200101251929.WAA10001@ms2.inr.ac.ru>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001 22:29:14 +0300 (MSK), kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
>> no problems.  I simply mounted an NFS server with rsize=wsize=8192
>> and read a few files - I assume this is sufficient?
> 
> This is orthogonal.
> 
> Only TCP uses this and you need not to do something special
> to test it. Any TCP connection going through 3c tests it.

Well, yes and no. It's not quite orthogonal, because normally TCP
will never transmit fragmented packets, and it's precisely fragmented
packets that make the interesting case with a card that supports
hardware TCP/UDP checksums.

If the packets are not fragmented, then the card can just verify the
checksums and be done with it. However, with fragments, all it can
do is report a partial checksum to the driver and let the driver
(or the stack) combine those partial checksums into one complete
checksum once all fragments have arrived. At least that's what the
Starfire card does, maybe the 3com is different. :-)

Are we even bothering with the partial checksums at this point, or
are we falling back to CPU checksumming if the packet is fragmented?

And, on a related note: what's involved in making a driver
zerocopy-aware? I haven't looked too closely to the current patch,
but I was thinking of playing with the starfire driver, since I
have all the chipset docs..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
