Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272381AbRHYBez>; Fri, 24 Aug 2001 21:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272382AbRHYBep>; Fri, 24 Aug 2001 21:34:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13582 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272381AbRHYBec>;
	Fri, 24 Aug 2001 21:34:32 -0400
Date: Fri, 24 Aug 2001 22:34:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825003508Z16139-32383+1258@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108242231480.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Daniel Phillips wrote:

> > The queue looks like this, with new pages being added to the
> > front and old pages being dropped off the right side:
> > 	AAaaBBbbCCccDDdd
> >
> > With the current use-once thing, we will end up dropping ALL
> > pages from file D, even the ones we are about to use (DDdd).
>
> I call that gracefull.  Look, you only lost 2 pages out of 16, and
> when you have to re-read them it will be a clustered read.  It's just
> not that big a deal.

The difference is that with the use-once idea file D would
lose all 4 pages, while with the drop-behind idea every file
would use one page it had already used.

> > With drop-behind we'll drop four pages we have already used,
> > without affecting the pages we are about to use (dcba).
>
> Well, yes, but you will also drop that header file your compiler wants
> to read over and over.  How do you tell the difference?  There are
> lots of nice things you can do if your algorithm can assume
> omniscience.

Agreed, this thing should be fixed. I'm sure we'll come
up with a way to get around this problem.

> My point is, even with the case you supplied the expected behaviour of
> the existing algorithm is acceptable.  There is no burning fire to put
> out, not here anyway.

True, it's just an issue of performance and heavily used
servers falling over under load, nothing as serious as
data corruption or system instability.

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

