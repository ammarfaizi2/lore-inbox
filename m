Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVERTYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVERTYC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVERTYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:24:02 -0400
Received: from fire.osdl.org ([65.172.181.4]:37084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262295AbVERTXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:23:53 -0400
Date: Wed, 18 May 2005 12:25:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
In-Reply-To: <20050518185016.GD1952@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0505181213580.18337@ppc970.osdl.org>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
 <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net>
 <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net>
 <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <20050518185016.GD1952@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 May 2005, Pavel Machek wrote:
> 
> Please don't do this, CONFIG_NO_IDLE_HZ patches are better solution,
> and they worked okay last time I tried them.

.. and they have nothing to do with this.

A number of people who want lower tick frequency are apparently _server_
people. Not because it makes any difference to idle time, but because it
can lessen the impact of the timer interrupt under load.

I don't know why, but I've actually gotten most of the complaints about
the 1kHz timer from ia64 people, who use a 1024Hz timer. Somebody from
Intel claimed a several percent reduction in performance between 1kHz and
100Hz under some load, apparently because of bad cache interaction.

At the same time, 100Hz really is too low for some desktop-like soft-RT
stuff, where you want to delay until the next frame (and humans notice
jitter at some fraction of a tenth of a second). With the 100Hz
granularity, and the uncertainty on where the jiffy tick ends up being,
you effectively have a ~50Hz clock you can depend on, which together with
worries about synchronizing with the video refresh rate etc seems to make
people unhappy.

So this thing has nothing to do with "idle". 

And the truly-variable-HZ stuff just makes me nervous, but regardless of 
that, you actually do want a "limit HZ to some value" configuration option 
anyway.

Even with fully variable HZ, you need a limit just to say "this is the
highest precision we'll ever use", because otherwise you'll just be
wasting a lot of time on timers.

		Linus
