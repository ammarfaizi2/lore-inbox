Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJ3XqE>; Mon, 30 Oct 2000 18:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129041AbQJ3Xpy>; Mon, 30 Oct 2000 18:45:54 -0500
Received: from ns.caldera.de ([212.34.180.1]:4871 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129029AbQJ3Xpk>;
	Mon, 30 Oct 2000 18:45:40 -0500
Date: Tue, 31 Oct 2000 00:45:00 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
Message-ID: <20001031004500.A16524@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <200010302332.AAA15959@ns.caldera.de> <Pine.LNX.4.10.10010301536340.3595-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10010301536340.3595-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 30, 2000 at 03:40:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 03:40:24PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 31 Oct 2000, Christoph Hellwig wrote:
> > 
> > It is simple - but a change in _every_ makefile is required.
> > And it is not really needed for old-style makefiles.
> 
> Actually, you don't have to change every makefile, because you CAN do this
> all with a simple backwards-compatibility layer, something like:
> 
> 	OXONLY = $(filter-out $(O_OBJS), $(OX_OBJS))
> 	ALL_O = $(OXONLY) $(O_OBJS)
> 
> which is a no-op for a "proper" makefile that follows the new rules
> (OXONLY will be empty, because all OX_OBJS files will be part of O_OBJS),
> but it will make old-style stuff act the same..

Ok, that should do the job - but it is horribly ugly ...

> I'd actually prefer to just change every Makefile, but hey, I think
> something like the above (untested) would make them work unmodified too.

But when we are changing makefiles everywhere - why not do the proper think
and let the new-style makefiles share their code?

(I have a patch ready - it just needs some forward-porting and testing)

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
