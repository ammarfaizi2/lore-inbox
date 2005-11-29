Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVK2BAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVK2BAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVK2BAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:00:39 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46269 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932306AbVK2BAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:00:38 -0500
Date: Tue, 29 Nov 2005 02:00:26 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511271859.20735.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511290139150.1609@scrub.home>
References: <200511170629.42389.rob@landley.net> <200511251512.20330.rob@landley.net>
 <Pine.LNX.4.61.0511271841320.1610@scrub.home> <200511271859.20735.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 27 Nov 2005, Rob Landley wrote:

> The current miniconfig.sh is based on a very simple (and slow) procedure, and 
> even then I still haven't figured out why miniconfig.sh run on a straight 
> allnoconfig insists that CONFIG_PM should be set.  (It correctly eliminates 
> everything else...)

It seems because ACPI takes itself too important and sets the default to y 
and this selects PM and prevents it from setting to n, until ACPI is 
reset. default and select is a really bad combination. :-(

> > I think it can even be done in a single pass over all the symbols, where
> > boolean/tristate symbols are checked if they are already at the minimum
> > value and string/hex/int values are compared with their default values.
> 
> Minimum value?

This is actually documented. :)
n - 0, m - 1, y - 2

> > Next step could be to add a variation of allnoconfig with better error
> > checking (e.g. checking that all requested symbols have been set),
> 
> Um, I thought my patch did that.  If any unrecognized symbols were 
> encountered, my miniconfig patch would report it and exit with an error by 
> the simple expedient of making the warning count a global and checking it 
> afterwards.  (I did a sort of -Werror for kconfig.)  If it attempts to set an 
> unrecognized symbol, it would already generate a warning, and if the warning 
> count is nonzero it bails out with an error at the end.  Seemed to work quite 
> well, for me anyway...
> 
> What cases would that not catch?

Symbols can be hidden by new dependencies.

> Good point, but the existing format is 90% of the gain for 10% of the effort.  
> Going from .config to miniconfig for my laptop's kernel, for example, goes 
> from 1370 lines to 138 lines, almost exactly a 10x reduction.  And that can 
> be done (admittedly badly) today, with the patch I posted.
> 
> Dropping that 138 down to 120, or even to 100, is a polishing step in 
> comparison.  Do you think there are another 30 lines that could be trimmed 
> out of that 138?  (Attached.)

Yes, some symbols are hidden behind a lot of dependencies, if a user wants 
to enable a new option, he only adds one new option and kconfig can try to 
figure out the missing options.

bye, Roman
