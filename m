Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAIUhj>; Tue, 9 Jan 2001 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130362AbRAIUh3>; Tue, 9 Jan 2001 15:37:29 -0500
Received: from ns.caldera.de ([212.34.180.1]:270 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129774AbRAIUhN>;
	Tue, 9 Jan 2001 15:37:13 -0500
Date: Tue, 9 Jan 2001 21:36:34 +0100
Message-Id: <200101092036.VAA06353@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: migo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.10.10101091212520.2331-100000@penguin.transmeta.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10101091212520.2331-100000@penguin.transmeta.com> you wrote:


> On Tue, 9 Jan 2001, Ingo Molnar wrote:
>> 
>>				 So i do believe that the networking
>> code is properly designed in this respect, and this concept goes to the
>> highest level of the networking code.

> Absolutely. This is why I have no conceptual problems with the networking
> layer changes, and why I am in violent disagreement with people who think
> the networking layer should have used the (much inferior, in my opinion)
> kiobuf/kiovec approach.

At least I (who has started this threads) haven't said htey should use iobufs
internally.  I said: use iovecs in the interface, because this interface
is a little more general and allows to integrate into other parts (namely Ben's
aio work nicely).

Also the tuple argument you gave earlier isn't right in this specific case:

when doing sendfile from pagecache to an fs, you have a bunch of pages,
an offset in the first and a length that makes the data end before last
page's end.

> For people who worry about code re-use and argue for kiobuf/kiovec on
> those grounds, I can only say that the code re-use should go the other
> way. It should be "the bad code should re-use code from the good code". It
> should NOT be "the new code should re-use code from the old code".

It's not relly about reusing, but about compatiblity with other interfaces...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
