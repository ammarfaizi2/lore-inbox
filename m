Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272873AbRIPWPS>; Sun, 16 Sep 2001 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272886AbRIPWPI>; Sun, 16 Sep 2001 18:15:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272873AbRIPWO7>; Sun, 16 Sep 2001 18:14:59 -0400
Date: Sun, 16 Sep 2001 15:14:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Andreas Steinmetz <ast@domdv.de>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <200109162159.XAA11989@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.33.0109161509300.915-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Stephan von Krawczynski wrote:

> > [...]
> > Anybody willing to test the simple used-once cleanups? No
> guarantees, but
> > at least they make sense (some of the old interactions certainly do
> not).
>
> Very willing. Just send it to me, please.

It's there as 2.4.10pre10, on ftp.kernel.org under "testing" now.

However, note that it hasn't gotten any "tweaking", ie there's none of the
small changes that aging differences usually tend to need. I'm hoping
that's ok, as the new behaviour shouldn't be that different from the old
behaviour in most cases, and that the biggest differences _should_ be just
proper once-use things.

But it would be interesting to hear which loads show markedly worse/better
behaviour. If any.

> >  - age a referenced page on a list: clear ref bit and move to beginning of
> >    same list.
>
> Are you sure about the _beginning_? You are aging out _all_ non-ref
> pages in the next step?

Well, it depends on what your definition of "is" is..

Or rather, what the "beginning" is. The way things work now, is that all
pages are added to the "beginning", and the aging is done from the end,
moving pages at the end to other lists (or, in the case of a referenced
page, back to the beginning).

You could, of course, define the list to be done the other way around. It
won't make any actual behavioural difference, unless there are bugs due to
confusion about which end is "new" and which is "old".

Which there might well be, of course.

		Linus

