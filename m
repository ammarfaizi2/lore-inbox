Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTJECeb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 22:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTJECeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 22:34:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262947AbTJECea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 22:34:30 -0400
Date: Sun, 5 Oct 2003 03:34:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Larry McVoy <lm@work.bitmover.com>, Rob Landley <rob@landley.net>,
       andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031005023428.GI7665@parcelfarce.linux.theplanet.co.uk>
References: <20030914064144.GA20689@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org> <200310041952.09186.rob@landley.net> <20031005010521.GA21138@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031005010521.GA21138@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 06:05:21PM -0700, Larry McVoy wrote:
> 
> Yeah, but Linus stating his position about a license doesn't mean diddly.
> The kernel is licensed under a license, that license is a contract that
> people enter into.  To the extent that it is enforceable, that license
> determines what happens, Linus can't retroactively decide to interpret
> the license a different way.  The license can't enforce things which
> the law doesn't allow.  In particular, the law understands a concept of
> a boundary.  And Linus' comments notwithstanding, modules are a pretty
> clear boundary.  Even the GPL acks this, it knows that anything which
> is clearly separable is not covered.

Oh, for fuck sake!  Larry, grep the damn tree for EXPORT_SYMBOL.  And
count them.  _IF_ it would be a relatively sane set of primitives - sure,
no arguments.  It's not.  Nowhere near that.

Conversions from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL are noise.  Why?
Because at any point any exported symbol can disappear.  Period.  For
some of them it's less likely, for some - more, but there was no promise
to preserve that set.  Ever.  Look at them and you will see why - if
we promise to keep all that pile present and working as it used to, we've
got a pitchfork stuck in the kernel guts.

Yes, it would be nice if there was something at least resembling an API.
Get the export list to shrink by 1.5 orders of magnitude and we might
have something to talk about.  That, and get the situation to the point
where additions to the export list would have to be defended - not granted
whenever somebody says "I wanna".  Until then there's no boundary at all.

Right now modules can call _anything_.  Look through the history and you'll
see patches that not only added an export but removed static at the same
chunk.  And you know what?  The guys who would like to pretend that there
is a boundary are the same guys who had destroyed it.  It used to be much
smaller list of exported objects.  Guess who had been pushing for its expansion
until it had lost any semblance of controlled interface?

When additions to interface start happening without any review and without
any percieved need to even explain why you need to add this, this and that -
it stops being an interface.  It's true for any project, not just the kernel.

And I'll bet you anything - if you try to get the damn thing back into shape,
authors of said modules will be out for blood.
