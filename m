Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRAYVMI>; Thu, 25 Jan 2001 16:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135827AbRAYVL6>; Thu, 25 Jan 2001 16:11:58 -0500
Received: from cs.columbia.edu ([128.59.16.20]:14277 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135200AbRAYVLu>;
	Thu, 25 Jan 2001 16:11:50 -0500
Date: Thu, 25 Jan 2001 13:11:40 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.EDU.AU>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <14960.36869.977528.642327@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101251253300.20615-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, David S. Miller wrote:

>
> Ion Badulescu writes:
>  > Well, yes and no. It's not quite orthogonal, because normally TCP
>  > will never transmit fragmented packets, and it's precisely fragmented
>  > packets that make the interesting case with a card that supports
>  > hardware TCP/UDP checksums.
>
> No it is not the interesting case for such cards.  I have a feeling
> you have no idea what you are talking about or who you are speaking
> to.  Alexey bascially implemented all of the zerocopy stuff in that
> patch, so it's a good bet that he has a good idea what is orthogonal
> or not.

Wrong feeling. :-) No, I know who Alexey is and I think I know what I'm
talking about, too. We're just talking about different things, RX vs TX.

Obviously there isn't much we can do with fragmented packets on TX. If
only the IP people had learned from Ethernet people about a good place for
a CRC/csum...

> On transmit, on transmit, that's all that matters on the hardware side
> with these changes, where the card does the checksumming for us.
> We've supported receive checksum verification from the hardware
> forever, long before these changes.

Hmm, I must have missed the CHECKSUM_HW stuff. Mea culpa. Not that many
drivers use it at this time, I see a grand total of 2 (hamachi and hme) in
2.4.0 -- and yes I know who wrote the hme driver, too. :)

>  > And, on a related note: what's involved in making a driver
>  > zerocopy-aware? I haven't looked too closely to the current patch,
>
> When you look closely at the current patch, you will see exactly what
> is required.  3 hardware drivers are ported there, and are to be used
> as examples.

Ok.

I'm just wondering, if a card supports sg but *not* TX csum, is it worth
it to make use of sg? eepro100 falls into this category..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
