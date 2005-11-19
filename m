Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVKTVWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKTVWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKTVWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:22:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60133 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750754AbVKTVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:22:46 -0500
Date: Sat, 19 Nov 2005 23:48:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: Pavel Machek <pavel@ucw.cz>, Bj?rn Mork <bjorn@mork.no>,
       linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051119234850.GC1952@spitz.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <d120d5000511171357g4d7a8d54hcc1c1d1cffa8856e@mail.gmail.com> <20051118114032.GD15825@elf.ucw.cz> <87psoytbtt.fsf@obelix.mork.no> <20051118183126.GA20793@elf.ucw.cz> <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000511181532g69107c76x56a269425056a700@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >> Bjorn, does it help if you change TIMEOUT in kernel/power/process.c to 30 * HZ?
> > > >
> > > > Funny, I thought that 6 seconds is way too much. Bjorn, please let us
> > > > know if 30 seconds timeout helps.
> > >
> > > It does.
> >
> > Ouch, yes, that's clear. It is stopping tasks during *resume*... So I
> > guess it gets wrong timing by design. Question is what to do with
> > that. Could we make keyboard driver pause the boot until it is done
> > resetting hardware? Or we can increase the timeout... would 10 seconds
> > be enough?
> 
> Well, I think 10 seconds when suspending is a nice and resonable
> number. For resume though I think we should wait much longer, maybe
> even indefinitely - the only thing that timeout achieves is makes
> people fsck because the system can't recover from that state.

I see your point, but it does not seem we need that changes this far. Your
patch is better, because we *could* hit that during suspend, just after 
keyboard hotplug... right? And it will make resume faster for affected people.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

