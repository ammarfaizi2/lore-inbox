Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULNSjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULNSjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULNSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:39:46 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52707 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261592AbULNSjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:39:43 -0500
Date: Tue, 14 Dec 2004 19:39:11 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Harald Welte <laforge@netfilter.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Patrick McHardy <kaber@trash.net>,
       akpm@osdl.org, torvalds@osdl.org,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
Message-ID: <20041214183911.GA15606@apps.cwi.nl>
References: <20041114013724.GA21219@apps.cwi.nl> <41970FAD.6010501@trash.net> <20041114112610.GB8680@pclin040.win.tue.nl> <20041214130041.GU22577@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214130041.GU22577@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 02:00:41PM +0100, Harald Welte wrote:

> > This is not to say that there is a bug here, that the .init
> > data would actually be referenced by non-init stuff, but
> > it is better to convince oneself by static inspection of
> > the binary than by reasoning about the flow of the program.
> > 
> > Where the memory savings are important, the code should
> > be rewritten a bit.
> 
> We just had a discussion, and the netfilter core team really disagrees
> with this change, which apparently was merged in
> http://linux.bkbits.net:8080/linux-2.5/cset@1.2055.4.50
> 
> I think it's not a good idea to waste memory by removing __initdata,
> just to make it more convenient for some static inspection tools.  This
> is just the wrong way around.
> 
> If we _know_ that it works, and there is no  bug, we could just add a
> comment "This is handled correctly, since the ip_tables core copies the
> data just as rulesets comming from userspace."

I think that argument is valid only when satisfying the static tool
is especially cumbersome or inefficient, requires ugly code, etc.
In most cases a trivial rewrite will suffice, and the result is cleaner
code, easier to maintain, fewer bugs.

You say "but today nothing is wrong". But the longer the reasoning is,
the easier one of the steps in the argument will be broken by some
trivial change. By someone who did not know about all the invariants
required by a certain piece of code.

Look

-rw-r--r--    1 aeb      aeb      26693922 Dec  3 22:33 patch-2.6.10-rc3

26 megabytes of changes. In a hundred trivial changes there is at least
one flaw. These 26 megabytes will again introduce lots of minor problems.
The more of these can be found automatically, by static analysis, the
more time is left for debugging serious stuff.

> Pleaes pull out that change again and submit one that adds a comment,

Not me.

> or alternatively pick up the (incremental) change attached to this mail.
> I hope this makes your checker not spit any warnings.

I checked, and indeed, no warnings for this patch.
But that is the only thing I checked. I would never submit it.
Probably you should send it to davem and see whether he likes it.

Andries
