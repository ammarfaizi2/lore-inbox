Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271894AbRH1TSM>; Tue, 28 Aug 2001 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271887AbRH1TSD>; Tue, 28 Aug 2001 15:18:03 -0400
Received: from www.wen-online.de ([212.223.88.39]:41741 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S271888AbRH1TR5>;
	Tue, 28 Aug 2001 15:17:57 -0400
Date: Tue, 28 Aug 2001 21:17:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Hans Reiser <reiser@namesys.com>
cc: Dieter N|tzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        ReiserFS List <reiserfs-list@namesys.com>,
        "Gryaznova E." <grev@namesys.botik.ru>
Subject: Re: [reiserfs-list] Re: [resent PATCH] Re: very slow parallel read
  performance
In-Reply-To: <3B8B5A73.258A3A0E@namesys.com>
Message-ID: <Pine.LNX.4.33.0108282007440.680-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, Hans Reiser wrote:

> Mike Galbraith wrote:
> >
> > On Tue, 28 Aug 2001, Dieter N|tzel wrote:
> >
> > > * readahead do not show dramatic differences
> > > * killall -STOP kupdated DO
> > >
> > > Yes, I know it is dangerous to stop kupdated but my disk show heavy thrashing
> > > (seeks like mad) since 2.4.7ac4. killall -STOP kupdated make it smooth and
> > > fast, again.
> >
> > Interesting.
> >
> > A while back, I twiddled the flush logic in buffer.c a little and made
> > kupdated only handle light flushing.. stay out of the way when bdflush
> > is running.  This and some dynamic adjustment of bdflush flushsize and
> > not stopping flushing right _at_ (biggie) the trigger level produced
> > very interesting improvements.  (very marked reduction in system time
> > for heavy IO jobs, and large improvement in file rewrite throughput)
> >
> >         -Mike
>
>
> Can you send us the patch, and Elena will run some tests on it?

I think I posted the patch once (including dumb typo), and I know I sent
is to a couple of folks to try if they wanted, but I don't save such.

The specific patch is no longer germain.. large (more sensible) change
to flush logic recently.  Interesting is the kupdated/vm interaction..
I saw it getting in the way here (so I whittled it down to size.. made
it small), and some posts I've seen seem to indicate the same.

("biggie" thing is what leads to rewrite throughput increase.  Whacking
kupdated only removes a noise source)

	-Mike

