Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbTIJWeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbTIJWdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:33:19 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:2229 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S265888AbTIJW31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:29:27 -0400
Date: Wed, 10 Sep 2003 15:29:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net>
References: <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net> <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net> <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net> <20030910221710.GT27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910221710.GT27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 12:17:11AM +0200, Adrian Bunk wrote:
> On Wed, Sep 10, 2003 at 03:05:52PM -0700, Tom Rini wrote:
> > > > 
> > > > How so?  SERIO only selects SERIO_* bits, and INPUT only selects INPUT*
> > > > (and, imho, keyboard is input :)) bits.
> > > >...
> > > 
> > > Let's say you remove the X86 dependency in the select in INPUT_KEYBOARD. 
> > 
> > You mean:
> > select KEYBOARD_ATKBD if STANDARD && X86
> > becomes:
> > select KEYBOARD_ATKBD if STANDARD
> > ?
> 
> Yes.

That would, well break things.  We're only forcing ATKBD on X86 right
now, thankfully.

> > > If you select SERIO=m on !X86 (with EMBEDDED/STANDARD enabled) this will
> > > select KEYBOARD_ATKBD=y...
> > 
> > How?  What you pick for SERIO does not select anything in INPUT.
> > 
> > select is 'stronger' than the {bool,tristate} "Foo" if ... usage, so if
> > you have broken dependancies you get a different kind of failure (link,
> > as opposed to a shot foot) but IMHO it's more correct for restraints
> > that are of the form:
> > "Don't let the user shoot themseleves in the foot, easily".
> 
> There's a dependency between SERIO and KEYBOARD_ATKBD that must be 
> represented in the config rules.
> 
> Let me paraphrase the dependency the other way round (I'm not sure 
> whether the syntax is 100% correct):
> 
> config KEYBOARD_ATKBD
> 	tristate "AT keyboard support" if EMBEDDED || !X86 
> 	default y
> 	depends on INPUT_KEYBOARD
> 	select SERIO=m
> 	select SERIO=y if KEYBOARD_ATKBD=y
> 	help
> 	  ...

Ah yes.

This is similar (the same, even?) to the test3 problem.  Roman, can we
get select to somehow pay attention to depend as well?  I do believe
it's possible to have A select B, have C depend on Z and end up with:
A=y
B=y
C=n

-- 
Tom Rini
http://gate.crashing.org/~trini/
