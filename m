Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbTIOOtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIOOtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:49:43 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:54974 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261445AbTIOOtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:49:40 -0400
Date: Mon, 15 Sep 2003 07:49:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030915144939.GA29517@ip68-0-152-218.tc.ph.cox.net>
References: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 05:22:16PM +0900, Norman Diamond wrote:

> Although I can't keep up with the mailing list, I saw this from Adrian Bunk:
> > On Thu, Sep 11, 2003 at 04:04:48PM -0700, Tom Rini wrote:
> > >
> > > Okay.  The following Kconfig illustrates what I claim to be a bug.
> > > config A
> > > bool "This is A"
> > > select B
> > > config B
> > > bool "This is B"
> > > # Or, depends C=y
> > > depends C
> > > config C
> > > bool "This is C"
> > >
> > > Running oldconfig will give:
> > > This is A (A) [N/y] (NEW) y
> > > This is C (C) [N/y] (NEW) n
> > > And in .config:
> > > CONFIG_A=y
> > > CONFIG_B=y
> > > # CONFIG_C is not set
> 
> This is a problem.  Proposed solution follows later.
> 
> > > I claim that this should in fact be:
> > > CONFIG_A=y
> > > CONFIG_B=y
> > > CONFIG_C=y
> 
> Even for this simple case, there are other possibilities.  When we add human
> logic to the specified sequence of events then we can say that your
> interpretation is most likely what the user wanted, but in ordinary logic
> there are other possibilities such as n, n, n.  Proposed solution follows.
> 
> > The problem is that select ignores dependencies.
> > Unfortunately, your proposal wouldn't work easily, consider e.g.
> > config A
> > bool "This is A"
> > select B
> > config B
> > bool
> > depends C || D
> > config C
> > bool "This is C"
> > depends D=n
> > config D
> > bool "This is D"
> > Do you want C or D to be selected?
> 
> If neither is selected, then the problem is essentially the same as the one
> which Mr. Rini pointed out.  And again there are other possible
> possibilities such as n, n, n, n.
> 
> Solution:  Surely plain "make" could start by checking dependencies.  Or
> maybe "make dep" could be reincarnated.  If there is any inconsistency, then
> the Makefile could issue an error and refuse to start compiling.
> 
> This has the added benefit that if the human has some reason to edit the
> .config file by hand instead of using a make [...]config command, plain
> "make" will have a chance of catching editing errors.
> 
> This doesn't automate a solution as thoroughly as either of you were hoping
> for; it honestly admits that it can't read the human's mind  :-)

Yes, even that would work quite nicely, perhaps while saying what the
specific problem is as well.  Roman, how hard would this be to do?

-- 
Tom Rini
http://gate.crashing.org/~trini/
