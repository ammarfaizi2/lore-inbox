Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTICAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 20:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTICAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 20:07:56 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17166
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S261396AbTICAHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 20:07:52 -0400
Date: Tue, 2 Sep 2003 16:52:13 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: James Clark <jimwclark@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model
In-Reply-To: <200309021943.15875.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.10.10309021555410.8229-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


## The unoffical insider's guide to thwart the gpl_only garbage       ##
## First how to finally become a total outcast from being in/near the ##
## inner circle to exile.                                             ##

The soul intent of "GPL_ONLY" is to prevent binary modules.
The soul intent of "tainting" is to ignore the people who want a choice.

Now two sides to the sword with the above:

Create a pre-loading module to wrapper all the needed "GPL_ONLY" symbols
which rightly belong to the unprotected API.

-------------------------------------------

/*
 * freed_symbols.h
 *
 * The Free Stolen Symbols module.
 * Licensed under GPL and source code is free.
 */

extern int freed_xxxxx ( ... );

-------------------------------------------

/*
 * freed_symbols.c
 *
 * The Free Stolen Symbols module.
 * Licensed under GPL and source code is free.
 */

... blah blah, standard kernel module stuff and setup ...

int freed_xxxxx ( ... )
{
	return xxxxx( ... );
}

EXPORT_SYMBOL(freed_xxxxx);

... blah blah, standard kernel module stuff and clean up ...

LICENSE("GPL");

-------------------------------------------

Now wash rinse repeat for all the symbols you need to create a pre-loader
module to return to usage all the symbols you need.

First you will get people complaining this violates intent, kindly give
them the middle finger, two fingers, fore arm, or whatever non verbal
expression you wish.  Second envite them to get a lawyer.  Third, when
they tell you to stop, ask if they are imposing restrictions on GPL for
terms of usage.  If they are notify them they are in violation of the
license.

If you are an embedded space widget.  Apply thumb to nose and wiggle
fingers.  Provided you ship the source code you modify in the kernel, and
I do mean all of it, use the short cut to clobber the issues in module.h.
When they scream and complain about, this violates intent, ask them are
they issuing a restriction on the usage of the GPL kernel?  If they do not
permit one to use it under GPL them the kernel itself is in violation.

The short version:  It is a game of politics, where people what it both
ways.  They want it to be open source and restict the usage.

Now back to "tainting", if the politics were such to cause all modules
which are not GPL to be rejected then the game is over.  Because the
kernel does not reject loading, it by default approves of closed source
binary modules.  One could use the means of taint-testing to accept or
reject, regardless of the original intent.  Many have and will make the
argument the kernel has the ability to reject closed source and it choose
to accept.

Well I have now alienated myself from the world of open source, but
someone has to show who intellectually dishonestity in the politics.

This goes even further in some folks in the embedded appliance who will
digitally sign binary kernels against their module suite to prevent one
from compiling an identical kernel but unsigned, and the modules will not
load.  This is a hot topic along with distos adding into their big dollar
distributions extra export_symbol hooks for things that do not exist in
the source tree shipped.

There is more, but you can discover all the left-right speak on your own.

Cheers,

Andre

PS: Did this earn my way back into exile again, damn the truth hurts!


On Tue, 2 Sep 2003, James Clark wrote:

> 1. Will the move to a more uniform driver model in 2.6 increase the chances of 
> a given binary driver working with a 2.6+ kernel. 
> 
> 2. Will the new model reduce the use/need for kernel modules. Would this be a 
> good thing if functionality could be implemented in a driver instead of a 
> module.
> 
> 3. Will the practice of deliberately breaking some binary only 'tainted' 
> modules prevent take up of Linux. Isn't this taking things too far?
> 
> James
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 1. Will the move to a more uniform driver model in 2.6 increase the chances of 
> a given binary driver working with a 2.6+ kernel. 
> 
> 2. Will the new model reduce the use/need for kernel modules. Would this be a 
> good thing if functionality could be implemented in a driver instead of a 
> module.
> 
> 3. Will the practice of deliberately breaking some binary only 'tainted' 
> modules prevent take up of Linux. Isn't this taking things too far?
> 
> James
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

