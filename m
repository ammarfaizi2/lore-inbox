Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTABWKy>; Thu, 2 Jan 2003 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbTABWKJ>; Thu, 2 Jan 2003 17:10:09 -0500
Received: from stargate-43-81.salzburg-online.at ([213.153.43.81]:41225 "EHLO
	window.dhis.org") by vger.kernel.org with ESMTP id <S267303AbTABWHS>;
	Thu, 2 Jan 2003 17:07:18 -0500
Date: Thu, 2 Jan 2003 23:12:11 +0100
From: Thomas Ogrisegg <tom@rhadamanthys.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20030102221210.GA7704@window.dhis.org>
References: <20021230010953.GA17731@window.dhis.org> <20021230012937.GC5156@work.bitmover.com> <1041489421.3703.6.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041489421.3703.6.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 10:37:01PM -0800, David S. Miller wrote:
> On Sun, 2002-12-29 at 17:29, Larry McVoy wrote:
> > How about putting this into a different function?  It's a lot to add
> > inline for a special case.

All right.

> 1) Does not handle writes that straddle multiple VMAs

What exactly do you mean? In my test, files larger than a
page were handled perfectly, as well.

> 2) We do not want to encourage people to use this mmap
>    scheme anyways.  The mmap way consumes precious VM
>    space, whereas the sendfile scheme does not.

Is that the answer to my "sendfile is now obsolete"?

Sure we cannot remove sendfile now, as some applications
depends on it, but that's not what I wanted.

I made this patch, so that _portable_ applications (and sendfile
is miles away from beeing portable - even if the target has a
sendfile systemcall, its highly unlikely that it has the same
semantics as Linux' sendfile) are sped up.

However, I didn't like the VM waste either, but I believe there
is no other way.

> 3) Finally, I'm very dubious about the "this is faster than
>    TUX claim".  Firstly because you've not provided your
>    self-made HTTP server so that others can try to reproduce
>    your benchmark.  And secondly because you haven't indicated
>    if your self-made HTTP server is as full featured as TUX or
>    not.  And thirdly you haven't indicated what happens if in
>    parallel clients ask to be served more files than you could
>    mmap fit into the HTTP server processes address space (ie. see
>    #2)

Hehe. In fact that wasn't a really serious claim. My tests
were (as explicitly stated by me) done over the Loopback-
Interface. And as far as I know TUX can handle interrupts
from the network card directly, which probably makes it by
far faster.

As I neither have the time nor the infrastructure to do a real
test, I cannot really say whether TUX or my (currently unreleased)
Webserver is faster.

BTW: My webservers maps files only once, so there shouldn't be
a problem with parallel transfers.

> So I think this patch stinks :)

But it worked? If I didn't misunderstood #1 then I don't see a
problem for integrating it into the current kernel.
