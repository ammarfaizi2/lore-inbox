Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTILREQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTILREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:04:15 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:52232 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261774AbTILREK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:04:10 -0400
Date: Fri, 12 Sep 2003 18:57:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Tom Rini <trini@kernel.crashing.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
In-Reply-To: <20030912110902.GF27368@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0309121710410.19512-100000@serv>
References: <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net>
 <Pine.LNX.4.44.0309111037050.19512-100000@serv>
 <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net> <20030912110902.GF27368@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 12 Sep 2003, Adrian Bunk wrote:

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
> 
> 
> Unfortunately, your proposal wouldn't work easily,

Sometimes it's even impossible, e.g. if choice values are involved. It can 
get even more complex, as a config symbol can be defined multiple times 
and the dependencies belong to the prompt not to the symbol. Letting 
select look at all the dependencies, would let the complexity explode.
Right now the simplest solution is to either let A select everything or B 
uses select instead of depends.

bye, Roman

