Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270609AbRHUD6z>; Mon, 20 Aug 2001 23:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRHUD6q>; Mon, 20 Aug 2001 23:58:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3846 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270609AbRHUD6c>;
	Mon, 20 Aug 2001 23:58:32 -0400
Date: Tue, 21 Aug 2001 00:58:32 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8/2.4.9 VM problems
In-Reply-To: <20010821034550Z16007-32383+621@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108210053260.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Daniel Phillips wrote:

> I have to admit, the 100 FTP clients case wasn't on the top of my
> mind.  Even so, think about what is really happening.  Nothing is
> getting activated and nothing is competing with these allocations so

> Assuming that some of the files are more popular than others, these
> file pages will be touched more than once and will go onto the active
> ring, also exactly what you want.

... and so you contradict yourself in consecutive
paragraphs...

> As they get old they get fed into the inactive queue at a rate that's
> tunable.  I don't see what the problem is.

You just pointed it out.  The old pages get fed into the
inactive queue at a rate which isn't influenced by how
much pressure the new pages put on the VM, but only by
some "tunable" rate.

> There are a couple of simple improvements that can be made.  We could mark
> all new pages referenced, age=1 (to distinguish from aged-to-zero pages).  We
> would not do unlazy activation but just allow age to increment with each
> touch.  Then, in addition to the Referenced test, we would test the age
> against a tunable threshold to decide which pages to rescue.  You can see
> that this would take care of your 100 streaming clients case nicely, while
> not negatively affecting the cases that are already working well.

Nice way to fuck up the 100 streaming client case even more, you mean.

> A second simple improvement is to have separate activation and deactivation
> queues.  This allows you to tune the rate at which pages are pulled from the
> activation queue (these would be the streaming IO pages) against pages culled
> from the active list.  I can't think of any downside at all for doing this,
> except that it's not something I'd consider appropriate for the 2.4 series.

This is called "better page aging".

> > [...] you haven't yet made any
> > proposal on how to make the rest of the VM interact nicely
> > with the use-once idea, preventing things like the thrashing
> > of the readahead window, etc...
>
> This is hypothetical thrashing so far, have you see it in the wild?

Yes.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

