Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbREaIH0>; Thu, 31 May 2001 04:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263028AbREaIHR>; Thu, 31 May 2001 04:07:17 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:30849 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S263026AbREaIHM>;
	Thu, 31 May 2001 04:07:12 -0400
Date: Thu, 31 May 2001 10:06:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols
Message-ID: <20010531100654.A1759@suse.cz>
In-Reply-To: <20010531080845.A808@suse.cz> <16983.991295559@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <16983.991295559@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Thu, May 31, 2001 at 05:52:39PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 05:52:39PM +1000, Keith Owens wrote:

> On Thu, 31 May 2001 08:08:45 +0200, 
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Thu, May 31, 2001 at 11:29:06AM +1000, Keith Owens wrote:
> >> With your patch, if a user selects CONFIG_INPUT_GAMEPORT=m and
> >> CONFIG_SOUND_ES1370=y then the built in es1370 driver has unresolved
> >> references to gameport_register_port() which is in a module, vmlinux
> >> will not link.  That is why I derived CONFIG_INPUT_GAMEPORT based on
> >> the config options in two separate directories.
> >
> >Have you tried the patch? Because the gameport.h define has:
> >
> >#if defined(CONFIG_INPUT_GAMEPORT) || (defined(CONFIG_INPUT_GAMEPORT_MODULE) && defined(MODULE))
> >void gameport_register_port(struct gameport *gameport);
> >void gameport_unregister_port(struct gameport *gameport);
> >#else
> >void __inline__ gameport_register_port(struct gameport *gameport) { return; }
> >void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
> >#endif
> 
> When the user has gameport hardware compiled it as a module and they
> have es1371 bult into the kernel then es1371 silently ignores the
> gameport, even if the gameport modules has been loaded.  This violates
> the principle of least surprise, a user configuring both gameport and
> es1371 expects to use the gameport, kbuild should support that instead
> of silently ignoring the combination.

True. Is this worse than the ugliness in your patch?

-- 
Vojtech Pavlik
SuSE Labs
