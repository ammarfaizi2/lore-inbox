Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbRJJFGW>; Wed, 10 Oct 2001 01:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJJFGE>; Wed, 10 Oct 2001 01:06:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8977 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274749AbRJJFFr>; Wed, 10 Oct 2001 01:05:47 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Date: Wed, 10 Oct 2001 05:05:10 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9q0ku6$175$1@penguin.transmeta.com>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com> <20011010040502.A726@athlon.random>
X-Trace: palladium.transmeta.com 1002690363 22745 127.0.0.1 (10 Oct 2001 05:06:03 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Oct 2001 05:06:03 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011010040502.A726@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>On Tue, Oct 09, 2001 at 08:45:15AM -0700, Paul McKenney wrote:
>> Please see the example above.  I do believe that my algorithms are
>> reliably forcing proper read ordering using IPIs, just in an different
>> way.  Please note that I have discussed this algorithm with Alpha
>> architects, who believe that it is sound.
>
>The IPI way is certainly safe.

Now, before people get all excited, what is this particular code
actually _good_ for?

Creating a lock-free list that allows insertion concurrently with lookup
is _easy_.

But what's the point? If you insert stuff, you eventually have to remove
it. What goes up must come down. Insert-inane-quote-here.

And THAT is the hard part. Doing lookup without locks ends up being
pretty much worthless, because you need the locks for the removal
anyway, at which point the whole thing looks pretty moot.

Did I miss something?

		Linus
