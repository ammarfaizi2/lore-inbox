Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTIOML4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTIOML4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:11:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39694 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261300AbTIOMLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:11:55 -0400
Date: Mon, 15 Sep 2003 08:02:44 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Bradford <john@grabjohn.com>, zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
In-Reply-To: <1063611650.2674.1.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030915074939.19165C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Alan Cox wrote:

> On Llu, 2003-09-15 at 07:32, John Bradford wrote:
> > That's a non-issue.  300 bytes matters a lot on some systems.  The
> > fact that there are drivers that are bloated is nothing to do with
> > it.
> 
> Its kind of irrelevant when by saying "Athlon" you've added 128 byte
> alignment to all the cache friendly structure padding. There are systems
> where memory matters, but spending a week chasing 300 bytes when you can
> knock out 50K is a waste of everyones time. Do the 40K problems first

If we were talking about cleaning the kernel I would agree, and perhaps we
are in the long run. But what is being done here is to add a big chunk of
new code which only benefitts Athlon, and to resist putting ifdefs around
it so the rest of world doesn't have to waste bytes on it.

The config options to reduce kernel size by shedding features for embedded
and similar are new options (relatively). This seems to be the first big
chunk of totally machine dependent code being added after Linux took the
first step back toward being trim again.

No one has come up with any reason why this code can't have an ifdef
around it, other than one claim that distros would not be able to use it
(are there any vendors who can't do a config?) and Andi who would have to
set the config to build one kernel for all his machines.

I have an Athlon, three more on order, and an Athlon laptop in eval. I'm
hardly against them, I just don't want the extra code floating around my
non-Athlon machines. Why is there resistance to making this code
conditional, it's certainly not generally useful, it's a bugfix.

I still like the idea of a single config variable to remove all special
case code for non-configured CPUs, call it NO_BLOAT or MINIMALIST_KERNEL
or EMBEDDED_HELPER as you will. The embedded folks would then have a good
handle to do the work and identify sections to be so identified.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

