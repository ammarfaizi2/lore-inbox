Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVAMVtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVAMVtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVAMVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:44:15 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60932 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261706AbVAMVlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:41:22 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, grendel@caudium.net,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113115004.Z24171@build.pdx.osdl.net>
	 <20050113202905.GD24970@beowulf.thanes.org>
	 <1105645267.4644.112.camel@localhost.localdomain>
	 <1105649837.6031.54.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501131307430.2310@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 22:41:04 +0100
Message-Id: <1105652464.6031.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But that doesn't mean that all the same things aren't true for vendor-sec 
> that are true for MS. They are just bad to a (much, I hope) smaller 
> degree.

(for the record, I'm no great fan of vendor-sec, and haven't been on it
for quite some time and am glad for that. I also try to avoid it for
things I find myself for a lot of the reasons you stated earlier.
However I do still think that it is nice if people who find security
issues give the upstream author (or a select subset thereof) SOME time
to come up with a fix, and audit for similar bugs elsewhere in the code.
1 week should in nearly all cases be more than plenty for that though)


> So instead, let's look at FACTS:
> 
>  - fixing a security bug is almost always much easier than writing an 
>    exploit.  Arjan, your argument simply isn't true except for the worst 
>    possible fundamental design issues. You should know that. In the case 
>    of "uselib()", it was literally four lines of obvious code - all the 
>    rest was just to make sure that there weren't any other cases like that
>    lurking around.

I've seen it both ways; some of the worst issues fix wise (remember the
seek thing) took a while to fix, and especially to audit the rest of the
code for teh same bug. Ok it's also the best proof against the v-s
approach at the same time since the fix that came out of that wasn't a
really nice/good/maintainable fix.

Also I'm thinking "hours" not "days" here. Getting a fix done and
released will generally take a few hours, for example, you sleep a few
hours a day already, so a fix just cannot make your bk tree "within 2
hours" at any time of the day. Oh of course there is lkml, and patches
go out that way as well; but that's not quite the same. Sometimes
someone gives a "here this fixes it" patch that is worse than the
original problem.


>  - There are more white-hats around than black-hats, but they are often 
>    less "driven" and motivated. Now _that_, I would argue, is the real 
>    problem with early disclosure - motivation.  The people really 
>    motivated to find the bugs are the people who are also motivated to
>    mis-use them. However, vendor-sec and "the game" just makes it more 
>    worth-while for security firms to participate in it - it gives them the 
>    "good PR" thing. And how much can you trust the "gray hats"?

I've seen enough of this go wrong/abused to agree with you to a large
extend. To the point where I have a natural initial distrust to people
who come with an embargoed hole and want to make a really big splash
about it (as opposed to mere developers finding something by accident
that want to do the right thing). Both sides happen. The later ones we
should have something for, that is both easy for such developers to
report, and that gets the patch out at least close in time to the hole
becoming widespread knowledge. 

> And this is why I believe vendor-sec is part of the problem. If you don't
> see that, then you're blinding yourself to the downsides, and trying to
> only look at the upsides.

I think v-s has gone too far and is not really useful anymore. In the
last four years I've been in a job where I both got to like the few days
of advanced notice and got to hate the downsides. (fwiw I'm no longer in
that position so by now I probably have a different perspective than
Dave has;). I would absolutely agree with the statement that the
downsides of the current v-s outweigh the advantages by far.

That does not mean that I think that ANY system that makes it easy for
people to report things such that the upstream developers get a
reasonable advance notice and can come up with a fix before the hole
goes public is flawed in design. It can be done right, and some of the
things on this list (putting a time cap on the notice period for
example) will go a long way to making a sensible system that serves the
users of the software best. After all its a balance between remaining
vulnerable a bit longer than perhaps strictly needed versus having a lot
of active exploits out there without a fix. And yes you can't guarantee
that the alter is the case while you think you do the former. That's the
gamble you take and that is what a reasonable cap on the disclosure time
will at least limit in extend.

Also, to be fair, I suspect half the things that come into v-s and
similar don't have a reporter who is interested in more than "I let them
know and please let me forget about it now I want to move on with other
things in life". Getting that case right is important.


