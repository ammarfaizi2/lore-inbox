Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268395AbRGXRkw>; Tue, 24 Jul 2001 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268391AbRGXRkd>; Tue, 24 Jul 2001 13:40:33 -0400
Received: from zeus.kernel.org ([209.10.41.242]:59528 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268390AbRGXRkQ>;
	Tue, 24 Jul 2001 13:40:16 -0400
Date: Tue, 24 Jul 2001 14:04:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <200107241648.f6OGmqp29445@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107241359180.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Linus Torvalds wrote:

> Hey, this looks _really_ nice. I never liked the special-cases
> that you removed (drop_behind in particular), and I have to say
> that the new code looks a lot saner, even without your extensive
> description and timing analysis.

Fully agreed, drop_behind is an ugly hack.  The sooner
it dies the happier I am ;)

> Please people, test this out extensively - I'd love to integrate
> it, but while it looks very sane I'd really like to hear of
> different peoples reactions to it under different loads.

The one thing which has always come up in LRU/k and 2Q
papers is that the "first reference" can really be a
series of references in a very short time.

Counting only the very first reference will fail if we
do eg. sequential IO with non-page aligned read() calls,
which doesn't look like it's too uncommon.

In order to prevent this from happening, either the system
counts all first references in a short timespan (complex to
implement) or it has the new pages on a special - small fixed
size - page list and all references to the page while on that
list are ignored.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

