Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272318AbRHXUZb>; Fri, 24 Aug 2001 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272319AbRHXUZL>; Fri, 24 Aug 2001 16:25:11 -0400
Received: from [209.10.41.242] ([209.10.41.242]:43414 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272318AbRHXUZH>;
	Fri, 24 Aug 2001 16:25:07 -0400
Date: Fri, 24 Aug 2001 17:19:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108241713420.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Daniel Phillips wrote:
> On August 24, 2001 07:43 pm, Rik van Riel wrote:

> > 1) under memory pressure, the inactive_dirty list is
> >    only as large as 1 second of pageout IO, meaning
> 		      ^^^^^^^^
> This is the problem.  In the absense of competition and truly
> active pages, the inactive queue should just grow until it is
> much larger than the active ring.  Then the replacement policy
> will naturally become fifo, which is exactly what you want in
> your example.

Actually, no.  FIFO would be ok if you had ONE readahead
stream going on, but when you have multiple readahead
streams going on you want to evict the data each of the
streams has already used, and not all the readahead data
which happened to be read in first.

> Anyway, this is a theoretical problem, we haven't seen it in the
> wild yet, or a test load that demonstrates it.

I've seen it in the wild, have given you a test load and
have shown you the arithmetic explaining what's going on.

How long will you continue ignoring things which aren't
convenient to your idea of the world ?

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

