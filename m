Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVKTFyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVKTFyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 00:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVKTFyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 00:54:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:18593
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750859AbVKTFyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 00:54:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Quick and dirty miniconfig howto, with feature suggestions.
Date: Sat, 19 Nov 2005 23:54:18 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <Pine.LNX.4.61.0511192338300.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511192338300.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511192354.19108.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 November 2005 21:08, Roman Zippel wrote:
> Hi,
>
> On Thu, 17 Nov 2005, Rob Landley wrote:
> > 1) Add a "make miniconfig" which works like allnoconfig but A) takes
> > mini.config as its' default name, B) redirects stdout to /dev/null to
> > make it easier to spot typoed symbols, C) aborts (exits with an error,
> > does not write new .config) if mini.config isn't found or if it contains
> > an unrecognized symbol.
>
> I think I better make allnoconfig silent (unless with V=1 or something),
> which makes it your miniconfig already almost like allnoconfig.

That would be an improvement, but I think from a user interface perspective 
it's slightly confusing to overload allnoconfig.  (It's not a big issue 
either way, though.)

The output redirecton could actually be done trivially in the makefile without 
touching the config code, and the other changes I proposed are fairly small.    
I have a todo item to whip up a "make miniconfig" patch that adds a new 
target with all three of the small behavior changes.  I can submit that for 
consideration later this evening...

> I'm not quite sure about aborting there are other error possibilities
> (e.g. new dependencies), so you never quite can trust the error value
> anyway.

In theory, something based on allnoconfig shouldn't care about the previous 
state of the .config file, so how is a dependency "new"?  (Could you clarify 
what you mean?)

If the Kconfig tree has conflicting symbols in it (dependencies on something 
it can't find), then yeah it would exit with an error in that case.  But I'm 
not sure that's a down side, that's detecting a bug.

My use case is that I'm trying to run the build within a script, and if 
something goes wrong I want the build to abort then rather than have to 
backtrack later.  And when I'm testing it out from the command line, several 
times I've typoed "KCONFIG_ALLCONFIG=../path/to/miniconfig", and right now it 
happily does an allnoconfig that I have to examine to see if it's correct.  
For allnoconfig, there not being an allno.conf file is fine, but for 
miniconfig the action would be meaningless if the mini.conf isn't found, so 
it should error.

My take, anyway.  I'll come up with a patch...

Rob
