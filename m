Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbTIJWRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbTIJWRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:17:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13822 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265835AbTIJWR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:17:26 -0400
Date: Thu, 11 Sep 2003 00:17:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030910221710.GT27368@fs.tum.de>
References: <20030910110225.GC27368@fs.tum.de> <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net> <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net> <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net> <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 03:05:52PM -0700, Tom Rini wrote:
> > > 
> > > How so?  SERIO only selects SERIO_* bits, and INPUT only selects INPUT*
> > > (and, imho, keyboard is input :)) bits.
> > >...
> > 
> > Let's say you remove the X86 dependency in the select in INPUT_KEYBOARD. 
> 
> You mean:
> select KEYBOARD_ATKBD if STANDARD && X86
> becomes:
> select KEYBOARD_ATKBD if STANDARD
> ?

Yes.

> > If you select SERIO=m on !X86 (with EMBEDDED/STANDARD enabled) this will
> > select KEYBOARD_ATKBD=y...
> 
> How?  What you pick for SERIO does not select anything in INPUT.
> 
> select is 'stronger' than the {bool,tristate} "Foo" if ... usage, so if
> you have broken dependancies you get a different kind of failure (link,
> as opposed to a shot foot) but IMHO it's more correct for restraints
> that are of the form:
> "Don't let the user shoot themseleves in the foot, easily".

There's a dependency between SERIO and KEYBOARD_ATKBD that must be 
represented in the config rules.

Let me paraphrase the dependency the other way round (I'm not sure 
whether the syntax is 100% correct):

config KEYBOARD_ATKBD
	tristate "AT keyboard support" if EMBEDDED || !X86 
	default y
	depends on INPUT_KEYBOARD
	select SERIO=m
	select SERIO=y if KEYBOARD_ATKBD=y
	help
	  ...


> Tom Rini

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

