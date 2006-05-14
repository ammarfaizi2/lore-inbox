Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWENUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWENUHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWENUHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 16:07:51 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:41098 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750898AbWENUHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 16:07:51 -0400
Date: Sun, 14 May 2006 22:07:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org,
       Jochen =?iso-8859-1?Q?Sch=E4uble?= <psionic@psionic.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
Message-ID: <20060514200740.GB20556@wohnheim.fh-wedel.de>
References: <200605140107.18293.jesper.juhl@gmail.com> <1147604629.12379.4.camel@pmac.infradead.org> <20060514132126.GA20556@wohnheim.fh-wedel.de> <200605141837.17318.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200605141837.17318.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 May 2006 18:37:15 +0200, Ingo Oeser wrote:
> On Sunday, 14. May 2006 15:21, Jörn Engel wrote:
> > 
> > Moving the printk into leaf functions?  My plan still is to collect a
> > bunch of those and put somewhere in lib/.  So maybe that's a bad idea.
> 
> That has been done already. One is kstrdup() from <linux/string.h>
> implementation in mm/util.c . So duplication can go.

Good point.

> parse_num32 is implemented as memparse() from 
> <linux/kernel.h> already, code is in lib/cmdline.c
> 
> It only misses the SI prefix stuff (kiBi and such).
> 
> Maybe SI units could be added to memparse() in
> lib/cmdline.c and all those reimplementations ripped of drivers/mtd/*/* ?

Not quite as simple.  My version is does two things.  First, it
accepts "ki" and second, it does not accept "k".  The latter is
important, because "k" means 1000, not 1024.

There are existing users that still use the historical interpretation,
so I guess we need both variants.

> > The macro sucks. 
> Agreed stronly! It is also against Documentation/CodingStyle, Chapter 11
> 
> No worries, error handling always clutters up our nice code. 
> 
> The only accepted way around this in Linux is "goto error_label", 
> so we can see the algorithm and read up on error handling at the 
> end of a function, after the algorithm.

Doesn't work here.  Every single error gives a different message.  Oh
well, let's go for the longer function.

Jörn

-- 
You can't tell where a program is going to spend its time. Bottlenecks
occur in surprising places, so don't try to second guess and put in a
speed hack until you've proven that's where the bottleneck is.
-- Rob Pike
