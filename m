Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbTILLJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTILLJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:09:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:54484 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261225AbTILLJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:09:07 -0400
Date: Fri, 12 Sep 2003 13:09:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
Message-ID: <20030912110902.GF27368@fs.tum.de>
References: <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net> <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net> <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net> <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.44.0309111037050.19512-100000@serv> <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911230448.GA13672@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 04:04:48PM -0700, Tom Rini wrote:
> 
> Okay.  The following Kconfig illustrates what I claim to be a bug.
> config A
> 	bool "This is A"
> 	select B
> 	
> config B
> 	bool "This is B"
> 	# Or, depends C=y
> 	depends C
> 
> config C
> 	bool "This is C"
> 
> 
> Running oldconfig will give:
> This is A (A) [N/y] (NEW) y
> This is C (C) [N/y] (NEW) n
> ...
> And in .config:
> CONFIG_A=y
> CONFIG_B=y
> # CONFIG_C is not set
> 
> I claim that this should in fact be:
> CONFIG_A=y
> CONFIG_B=y
> CONFIG_C=y

The problem is that select ignores dependencies.


Unfortunately, your proposal wouldn't work easily, consider e.g.

config A
	bool "This is A"
	select B

config B
	bool
	depends C || D

config C
	bool "This is C"
	depends D=n

config D
	bool "This is D"


Do you want C or D to be selected?


> Tom Rini

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

