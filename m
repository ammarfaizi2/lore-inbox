Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRBEXQY>; Mon, 5 Feb 2001 18:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbRBEXQP>; Mon, 5 Feb 2001 18:16:15 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:26314 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S130231AbRBEXQD>; Mon, 5 Feb 2001 18:16:03 -0500
Message-ID: <3A7F3420.A3B10510@alumni.caltech.edu>
Date: Mon, 05 Feb 2001 15:15:44 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Reply-To: dank@alumni.caltech.edu
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony Finch <dot@dotat.at>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that 
 sexy?)
In-Reply-To: <3A66729E.3E9E3C64@alumni.caltech.edu> <Pine.LNX.4.10.10101172046170.17109-100000@penguin.transmeta.com> <20010202013104.A48377@hand.dotat.at> <20010205225411.E70673@hand.dotat.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Finch wrote:
> 
> Tony Finch <dot@dotat.at> wrote:
> >Linus Torvalds <torvalds@transmeta.com> wrote:
> >>
> >>Without proper uncorking (and it really shouldn't be that hard to
> >>add), TCP_NOPUSH simply can't be used in the generic sense.
> >
> >It was easy :-) I've put up a patch for FreeBSD that adds proper
> >uncorking on my homepage <http://apache.org/~fanf/> in the "Stuff"
> >section.
> 
> ... and it has been committed to -CURRENT, too.

How very cool.

How close is TCP_NOPUSH to behaving identically to TCP_CORK now?
If it does behave identically, it might be time to standardize
the symbolic name for this option, to make apps more portable
between the two OS's.  (It'd be nice to also standardize the
numeric value, in the interest of making the ABI's more compatible, too.)

Here are the definitions in the two OS's at the moment:

FreeBSD: netinet/tcp.h (from 
http://minnie.cs.adfa.oz.au/FreeBSD-srctree/newsrc/netinet/tcp.h.html#TCP_NOPUSH )

/*
 * User-settable options (used with setsockopt).
 */
#define TCP_NODELAY     0x01    /* don't delay send to coalesce packets */
#define TCP_MAXSEG      0x02    /* set maximum segment size */
#define TCP_NOPUSH      0x04    /* don't push last block of write */

Linux: netinet/tcp.h:

/*
 * User-settable options (used with setsockopt).
 */
#define TCP_NODELAY 0x01    /* don't delay send to coalesce packets */
#define TCP_MAXSEG  0x02    /* set maximum segment size */
#define TCP_CORK    0x03    /* control sending of partial frames */      

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
