Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbQJ0BDe>; Thu, 26 Oct 2000 21:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129427AbQJ0BDZ>; Thu, 26 Oct 2000 21:03:25 -0400
Received: from ns1.wintelcom.net ([209.1.153.20]:43274 "EHLO fw.wintelcom.net")
	by vger.kernel.org with ESMTP id <S129281AbQJ0BDN>;
	Thu, 26 Oct 2000 21:03:13 -0400
Date: Thu, 26 Oct 2000 18:02:57 -0700
From: Alfred Perlstein <bright@wintelcom.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, Gideon Glass <gid@cisco.com>,
        Simon Kirby <sim@stormix.com>, Dan Kegel <dank@alumni.caltech.edu>,
        chat@FreeBSD.ORG, linux-kernel@vger.kernel.org
Subject: Re: kqueue microbenchmark results
Message-ID: <20001026180256.R28123@fw.wintelcom.net>
In-Reply-To: <20001026115057.A22681@prism.flugsvamp.com> <E13oxjH-00041y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E13oxjH-00041y-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 27, 2000 at 01:50:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [001026 17:50] wrote:
> > kqueue currently does this; a close() on an fd will remove any pending
> > events from the queues that they are on which correspond to that fd.
> 
> This seems an odd thing to do. Surely what you need to do is to post a
> 'close completed' event to the queue. This also makes more sense when you
> have a threaded app and another thread may well currently be in say a read
> at the time it is closed

Kqueue's flexibility could allow this to be implemented, all you
would need to do is make a new filter trigger.  You might need
a _bit_ of hackery to make sure those aren't removed, or one
could just add the event after clearing all pending events.

Adding a filter to be informed when a specific fd is closed is
certainly an option, it doesn't make very much sense because that
fd could then be reused quickly by something else...

but anyhow:

The point of this interface is to ask kqueue to report only on the
things you are interested in, not to generate superfluous that you
wouldn't care about.  You could make such a flag if Linux adopted
this interface and I'm sure we'd be forced to adopt it, but if you
make kqueue generate info an application won't care about I don't
think that would be taken back.

-- 
-Alfred Perlstein - [bright@wintelcom.net|alfred@freebsd.org]
"I have the heart of a child; I keep it in a jar on my desk."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
