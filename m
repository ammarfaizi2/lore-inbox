Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265231AbSJaRAL>; Thu, 31 Oct 2002 12:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSJaQ7l>; Thu, 31 Oct 2002 11:59:41 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:21418 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S263215AbSJaQ6Y>; Thu, 31 Oct 2002 11:58:24 -0500
Date: Thu, 31 Oct 2002 10:04:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031170420.GA30193@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031165113.GB8565@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 11:51:13AM -0500, Mark Mielke wrote:
> On Thu, Oct 31, 2002 at 07:33:01AM -0700, Tom Rini wrote:
> > > If gcc regularly generates larger code with -Os the answer is to talk to
> > > the gcc people, not to avoid using -Os...
> > It's not that it does regularly, it's that it can, and if it does, it's
> > not really a gcc bug from what I recall.  So I don't think CONFIG_TINY
> > should prefer -Os over -O2 but instead we should just ask the user what
> > level of optimization they want.  Remember, one of the real important
> > parts of embedded systems is flexibility.
> 
> Not to stretch this point too long, but turning off inlined functions 'can'
> make code bigger too. It usually doesn't.
> 
> I have no problem with the other suggestion that CONFIG_TINY specify a
> template for a set of build options, but if CONFIG_TINY is used (either
> as an option, or a template of options) -Os should always be preferred
> over -O2. Whether the user can still override this or not is a different
> issue from whether -Os should be preferred over -O2 when CONFIG_TINY is
> specified.
> 
> Or specified more clearly: If the compiler optimization flag is configurable,
> choosing CONFIG_TINY should default the optimization flag to -Os before it
> defaults the optimization flag to -O2.

You're still missing the point of flexibility remark.  Changing the
optimization level has nothing to do with CONFIG_TINY, and is a
generally useful option, and should be done seperate from CONFIG_TINY.
In fact people seem to be getting the wrong idea about CONFIG_TINY.  We
don't need a CONFIG_TINY, we need CONFIG_FINE_TUNE.  Different 'tiny'
projects need different things.  And when you take into account that the
embedded world is a whole lot of !i386, the fact that -Os hasn't been as
well tested on !i386, you introduce the possibility of compiler bugs
sneaking in as well.

In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about anything /
everything which might want to be tuned up.  Then this becomes a truely
useful set of options, since as Alan pointed out in one of the earlier
CONFIG_TINY threads, his Athlon could benefit from some of these 'tiny'
options too.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
