Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTIKXEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 19:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbTIKXEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 19:04:55 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:50399 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261606AbTIKXEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 19:04:50 -0400
Date: Thu, 11 Sep 2003 16:04:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net>
References: <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net> <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net> <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net> <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0309111037050.19512-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309111037050.19512-100000@serv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 10:38:58AM +0200, Roman Zippel wrote:

> Hi,
> 
> On Wed, 10 Sep 2003, Tom Rini wrote:
> 
> > > Let me paraphrase the dependency the other way round (I'm not sure 
> > > whether the syntax is 100% correct):
> > > 
> > > config KEYBOARD_ATKBD
> > > 	tristate "AT keyboard support" if EMBEDDED || !X86 
> > > 	default y
> > > 	depends on INPUT_KEYBOARD
> > > 	select SERIO=m
> > > 	select SERIO=y if KEYBOARD_ATKBD=y
> > > 	help
> > > 	  ...
> > 
> > Ah yes.
> > 
> > This is similar (the same, even?) to the test3 problem.  Roman, can we
> > get select to somehow pay attention to depend as well?  I do believe
> > it's possible to have A select B, have C depend on Z and end up with:
> > A=y
> > B=y
> > C=n
> 
> Could you give me a complete example, I don't understand yet, what it's 
> exactly supposed to do.

Okay.  The following Kconfig illustrates what I claim to be a bug.
config A
	bool "This is A"
	select B
	
config B
	bool "This is B"
	# Or, depends C=y
	depends C

config C
	bool "This is C"


Running oldconfig will give:
This is A (A) [N/y] (NEW) y
This is C (C) [N/y] (NEW) n
...
And in .config:
CONFIG_A=y
CONFIG_B=y
# CONFIG_C is not set

I claim that this should in fact be:
CONFIG_A=y
CONFIG_B=y
CONFIG_C=y

-- 
Tom Rini
http://gate.crashing.org/~trini/
