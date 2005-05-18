Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVERUrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVERUrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVERUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:47:18 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:26259 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262360AbVERUqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:46:45 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 18 May 2005 13:46:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050518204604.GN27330@atomide.com>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <20050518185016.GD1952@elf.ucw.cz> <Pine.LNX.4.58.0505181213580.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505181213580.18337@ppc970.osdl.org>
User-Agent: mutt-ng 1.5.9i (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [050518 12:28]:
> 
> 
> On Wed, 18 May 2005, Pavel Machek wrote:
> > 
> > Please don't do this, CONFIG_NO_IDLE_HZ patches are better solution,
> > and they worked okay last time I tried them.
> 
> .. and they have nothing to do with this.
> 
> A number of people who want lower tick frequency are apparently _server_
> people. Not because it makes any difference to idle time, but because it
> can lessen the impact of the timer interrupt under load.
> 
> I don't know why, but I've actually gotten most of the complaints about
> the 1kHz timer from ia64 people, who use a 1024Hz timer. Somebody from
> Intel claimed a several percent reduction in performance between 1kHz and
> 100Hz under some load, apparently because of bad cache interaction.
> 
> At the same time, 100Hz really is too low for some desktop-like soft-RT
> stuff, where you want to delay until the next frame (and humans notice
> jitter at some fraction of a tenth of a second). With the 100Hz
> granularity, and the uncertainty on where the jiffy tick ends up being,
> you effectively have a ~50Hz clock you can depend on, which together with
> worries about synchronizing with the video refresh rate etc seems to make
> people unhappy.
> 
> So this thing has nothing to do with "idle". 

Yes, that's right. Setting HZ would just limit the max frequency
with dyn-tick patch when system is busy. On OMAP, we're using HZ=128
with dyn-tick.

> And the truly-variable-HZ stuff just makes me nervous, but regardless of 
> that, you actually do want a "limit HZ to some value" configuration option 
> anyway.

The dyn-tick patch skips ticks only during idle, and the system is
not doing anything at that point, so it should be safe. When the
system is under load, there is normal HZ tick and timer is not being
reprogrammed.

> Even with fully variable HZ, you need a limit just to say "this is the
> highest precision we'll ever use", because otherwise you'll just be
> wasting a lot of time on timers.

Yeah.

Tony
