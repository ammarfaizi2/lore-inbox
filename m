Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSJMNnn>; Sun, 13 Oct 2002 09:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJMNnn>; Sun, 13 Oct 2002 09:43:43 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:5896 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261567AbSJMNnm>; Sun, 13 Oct 2002 09:43:42 -0400
Date: Sun, 13 Oct 2002 14:49:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021013144926.B16668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA969F0.1060109@metaparadigm.com>; from michael@metaparadigm.com on Sun, Oct 13, 2002 at 08:41:20PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 08:41:20PM +0800, Michael Clark wrote:
> Exactly. I think Christoph is comparing it to the original md
> architecture thich was more of an evolutionary design on the existing
> block layer

No, I do not.  MD is in _no_ ways a volume managment framwork but just
a few drivers that share common code.  That's somethig entirely different.

> it is merely an artifact of this that intermediary
> devices were present (and consuming minors)

I don not think cosumes minors is a valid design criteria for designing
an inkernel framework.

> in a well architected
> volume manager, this is not necessary or desirable - not presenting
> the intermediary devices is IMHO also a saftey feature preventing
> access to devices that shouldn't be accessed.

Please explain why they shouldn't be accessed.  And following your
argumentation tell me why you haven't submitted a patch to Linus
yet to disallow direct access to block devices that are in use
by a filesystem.

> Yes, considering the abstraction (and the futureproofing this provides),
> it would not make sense to bind these logical nodes to the orthogonal
> block layer - which would probably also make maintenance more complex
> in the future.

Please explain the added complexity in detail.  In fact it does remove
complexity by having a standard set of object to work on, removing the
need for code, data and data structure duplication.  Before answering
this mail I'd suggest you take a look at ldev_mgr.c in the evms
tree in detail (and yes, that file is horribly broken implementation-wise,
but this discussion is about the complexity it adds)

> I guess one of the advantages of the EVMS approach
> is the ability for the core code to fit more easily with less changes
> into kernels with differing block layers (2.4,2.5,future).

This argument is NIL if the infrastructure is part of exactly that
evolving block layer.  You might have noticed that kernel code
compatility to other releases is not really a criteria for the
linux kernel development, btw..

