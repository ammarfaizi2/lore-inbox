Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbTILOwX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 10:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTILOwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 10:52:14 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:32755 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261722AbTILOwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 10:52:08 -0400
Date: Fri, 12 Sep 2003 07:52:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030912145207.GC13672@ip68-0-152-218.tc.ph.cox.net>
References: <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net> <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net> <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0309111037050.19512-100000@serv> <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net> <20030912110902.GF27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912110902.GF27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 01:09:02PM +0200, Adrian Bunk wrote:
> On Thu, Sep 11, 2003 at 04:04:48PM -0700, Tom Rini wrote:
> > 
> > Okay.  The following Kconfig illustrates what I claim to be a bug.
> > config A
> > 	bool "This is A"
> > 	select B
> > 	
> > config B
> > 	bool "This is B"
> > 	# Or, depends C=y
> > 	depends C
> > 
> > config C
> > 	bool "This is C"
> > 
> > 
> > Running oldconfig will give:
> > This is A (A) [N/y] (NEW) y
> > This is C (C) [N/y] (NEW) n
> > ...
> > And in .config:
> > CONFIG_A=y
> > CONFIG_B=y
> > # CONFIG_C is not set
> > 
> > I claim that this should in fact be:
> > CONFIG_A=y
> > CONFIG_B=y
> > CONFIG_C=y
> 
> The problem is that select ignores dependencies.

Yeap.

> Unfortunately, your proposal wouldn't work easily, consider e.g.

I'm not really claiming a proposal, just that if B needs C=y, then C
should C=y.  I didn't say this would be an easy prolem, either :)

> config A
> 	bool "This is A"
> 	select B
> 
> config B
> 	bool
> 	depends C || D
> 
> config C
> 	bool "This is C"
> 	depends D=n
> 
> config D
> 	bool "This is D"
> 
> 
> Do you want C or D to be selected?

With 'oldconfig' / 'config', you could loop until the user selects one
of them.  Or, default to the first in the or series that can be
selected.

-- 
Tom Rini
http://gate.crashing.org/~trini/
