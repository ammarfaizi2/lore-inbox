Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbRGXGG1>; Tue, 24 Jul 2001 02:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267000AbRGXGGR>; Tue, 24 Jul 2001 02:06:17 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42711 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266995AbRGXGGO>;
	Tue, 24 Jul 2001 02:06:14 -0400
Date: Tue, 24 Jul 2001 02:06:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <20010723223413.G15284@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0107240140400.25475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Mon, 23 Jul 2001, Larry McVoy wrote:

> That said, I'd really urge people to listen to Rik, he has the right idea
> with the user level NFS idea.  There is no good reason and a lot of bad
> reasons to put this stuff in the kernel.
 
> > Distributed filesystems like Coda seem to get pretty close
> > to having revision control anyway. They need something like
> > it for conflict resolution.
> 
> Yeah!  No kidding.  If Coda had this I think there is a reasonable chance
> that most SCM systems would go away.  Certainly the trivial ones would.

	CODA servers tend to be simpler than NFS ones (stateful protocol,
commit-on-close, all file IO handled by local fs code, you name it).
Full-blown Venus is, indeed, a lurking horror from beyond, but that's a
different story - nightmarish stuff is in the distributed fs part. As a
glue for userland fs CODA wins hands down (BTW, that goes not only for
simplicity of code, but for performance and deadlock avoidance reasons).

	There's a whole shitcan of worms around the semantics of versioned
fs, though - e.g. what happens if you create a link to an old version of
file? What happens if you rename an old version away? What happens if you
rename _over_ it? There are obvious answers to that (e.g. all versions
except the last one are read-only and can be freely moved around or removed;
all association between them is semblance of names), but I doubt that
any of the easy variants will satisfy those who want that stuff. Personally,
I'd go for "you can take a read-only snapshot of a subtree and then bind
its parts anywhere you want", but that's not the only variant and I really
doubt that _any_ variant would satisfy everyone.

	No matter what implementation you choose, semantics will be a fscking
minefild and I'd rather _not_ see that flamewar on l-k. If somebody cares
to set a maillist - great, but let's keep it separate from l-k. This stuff
has a potential for flamewar worse than devfs, forked-files, bk licensing
and CML2 ones combined (and is very likely to resurrect the first two, in
bargain).

