Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760556AbWLFMd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760556AbWLFMd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760555AbWLFMd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:33:56 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47167 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760556AbWLFMdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:33:55 -0500
Date: Wed, 6 Dec 2006 13:33:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061205203013.7073cb38.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612061312560.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home>
 <20061205203013.7073cb38.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Andrew Morton wrote:

> > IMO it least at needs one more iteration to address the comments that 
> > were made (not just mine), in the short term the less it touches 
> > unconditionally the less I care right now.
> 
> I don't have a clue which review comments remain unaddressed - do you recall?

Outside clockevents I'd like to see at least the flag handling fixed 
before it gets merged.
Inside clockevents I could poke around forever...

> > In the long term IMO this might need a major rework, the basic problem I 
> > have is that I don't see how this usable beyond dynticks/hrtimer, e.g. how 
> > to dynamically manage multiple timer.
> 
> I'm not sure I understand that.  Are you referring to multiple,
> concurrently-operating hardware clock sources?  <wonders how that could
> work> If so, that's more a clocksource thing than a dynticks/hrtimer thing,
> isn't it?

A rather simple example would be profiling, where a separate timer is 
useful to see stuff that runs from the main timer, which is currently 
invisible.
It's insofar a clocksource thing as clock source and clock events should 
form a union, currently it's separate and that's a big problem. It's not 
really problem to have multiple clock sources and they don't really have 
to be synchronized with each other, but events _are_ connected to the 
source they are coming from.
In the end we could even expose multiple clocks via the posix clock/timer 
interface, but with the current design I don't see how this is possible.

bye, Roman
