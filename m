Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbSJMPKn>; Sun, 13 Oct 2002 11:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJMPKn>; Sun, 13 Oct 2002 11:10:43 -0400
Received: from [203.117.131.12] ([203.117.131.12]:47779 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261526AbSJMPKm>; Sun, 13 Oct 2002 11:10:42 -0400
Message-ID: <3DA98E48.9000001@metaparadigm.com>
Date: Sun, 13 Oct 2002 23:16:24 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/02 21:49, Christoph Hellwig wrote:
> On Sun, Oct 13, 2002 at 08:41:20PM +0800, Michael Clark wrote:
> 
>>Exactly. I think Christoph is comparing it to the original md
>>architecture thich was more of an evolutionary design on the existing
>>block layer
> 
> 
> No, I do not.  MD is in _no_ ways a volume managment framwork but just
> a few drivers that share common code.  That's somethig entirely different.

So why then the requirement that internal remapping layers be
implemented as block devices?

>>it is merely an artifact of this that intermediary
>>devices were present (and consuming minors)
> 
> 
> I don not think cosumes minors is a valid design criteria for designing
> an inkernel framework.

Neither is implementing an internal logical remapping layer as a
block device just so you can do an ioctl directly to it.

>>in a well architected
>>volume manager, this is not necessary or desirable - not presenting
>>the intermediary devices is IMHO also a saftey feature preventing
>>access to devices that shouldn't be accessed.
> 
> 
> Please explain why they shouldn't be accessed.  And following your

I think the point is really explaining why they _should_ be accessed.
If there is some valid reason other than having something you
can do an ioctl on.

> argumentation tell me why you haven't submitted a patch to Linus
> yet to disallow direct access to block devices that are in use
> by a filesystem.

I think the issue here is an md block device in use by another md block
device. Possbily becuase md's design precludes this (a design artifact)
(ie. md tools need access to the intermediary devices - users don't).

>>Yes, considering the abstraction (and the futureproofing this provides),
>>it would not make sense to bind these logical nodes to the orthogonal
>>block layer - which would probably also make maintenance more complex
>>in the future.
> 
> 
> Please explain the added complexity in detail.  In fact it does remove
> complexity by having a standard set of object to work on, removing the
> need for code, data and data structure duplication.  Before answering
> this mail I'd suggest you take a look at ldev_mgr.c in the evms
> tree in detail (and yes, that file is horribly broken implementation-wise,
> but this discussion is about the complexity it adds)

Yes, but the block device encapsulation here removes the need for plugins
to be implemented as block devices ie. removing complexity elsewhere.
I must admit to not being an expert on the block layer - but wouldn't
your suggesed approach mean intermediary layers would each have a
request queue and other unneeded stuff - if so, is this desirable?
(although i suspect i'm likely to be proved wrong - but i'm sure
there are issues with where you want your request queues - only on
the block devices exposed as volumes).

I still can't see the rationale of implementing instances of intermediary
remapping layers as block devices. Since you are the one that is objecting
to the current approach, the owness is on you to prove why an alternative
is needed.

>>I guess one of the advantages of the EVMS approach
>>is the ability for the core code to fit more easily with less changes
>>into kernels with differing block layers (2.4,2.5,future).
> 
> 
> This argument is NIL if the infrastructure is part of exactly that
> evolving block layer.  You might have noticed that kernel code
> compatility to other releases is not really a criteria for the
> linux kernel development, btw..

I agree, maybe this would be worth doing for 2.7/2.8. In the meatime
do you think this would be feasible? - you are basically suggesting
a complete rewrite (or do you think you can do the rewrite to IBM's
satisfaction before the freeze ie. in the eternal linux kernel way,
you want it you write it ;). Me, i'm happy with the current approach
- but of course, i'm only a user ;).

~mc

