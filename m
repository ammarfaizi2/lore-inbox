Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbTBDKbn>; Tue, 4 Feb 2003 05:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbTBDKbn>; Tue, 4 Feb 2003 05:31:43 -0500
Received: from gate.perex.cz ([194.212.165.105]:24325 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267209AbTBDKbm>;
	Tue, 4 Feb 2003 05:31:42 -0500
Date: Tue, 4 Feb 2003 11:40:45 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PnP model
In-Reply-To: <20030203204325.GA7425@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302041122031.1278-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Adam Belay wrote:

> On Mon, Feb 03, 2003 at 02:55:37PM +0100, Jaroslav Kysela wrote:
> > Hi all,
> >
> > 	I think that we need to discuss deeply the right PnP model. The
> 
> I'm confident this is the right pnp model.
> 
> > actual changes proposed by Adam are going to be more and more complex
> > without allowing the user interactions inside the "auto" steps. The
> > auto-configuration might be good and bad as we all know, but having an
> > method to skip it is necessary.
> 
> In many cases, Auto configuration can be better then manual configuration.

Autoconfiguration is better in perfect world... There are always troubles 
with some hardware incompatibilities.

> 1.) The auto configuration engine in my patch is able to resolve almost any
> resource conflict and provides the greatest chance for all devices to have
> resources allocated.
> 2.) Certainly some driver developers would like to manually set resources
> but many may prefer the option to auto config.
> 3.) Drivers under the existing system are not aware of many forms of
> resource conflicts and could set resources incorrectly.
> 4.) Some users do not want to worry about manual configuration and would
> welcome an auto configuration system that makes intelligent choices
> without user input.  This autoconfiguration system monitors many variables
> that a user would have a hard time keeping track of and never overlooks any
> potential conflicts in its analysis.
> 
> The above stated reasons are why I introduced these auto configuration
> (Resource Management) improvements.
> 
> I feel that one solution is to support both manual and auto configuration so
> the user can use what he or she prefers, however, I am confident that in most
> cases the auto configuration will be the best option.

But do we have to enable the auto configuration at boot implicitly?
I don't think so. Again, it's better if driver decides if auto or manual 
configuration will be used. The step by step configuration makes the 
implemenation more rebust (user will know which driver fails). Also, 
having legacy devices in the system, you cannot determine which resources 
are required for them before appropriate driver detects and initializes 
the device. I don't think that this algorithm will be worse than your 
proposed one. There are usually no resource conflicts for PnP devices so 
it will work at least on the same number of machines like implicit 
autoconfiguration at boot.

Also, imagine that PnP driver is build into the kernel: you'll no chance
select the right configuration over sysfs, but there are __setup() macros
allowing to pass the right resources to a driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


