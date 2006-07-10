Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422923AbWGJW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWGJW7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWGJW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:59:44 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7314 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1422923AbWGJW7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:59:43 -0400
Date: Tue, 11 Jul 2006 00:59:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Pavel Machek <pavel@ucw.cz>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: <1152571816.9062.29.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607110054180.12900@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> 
 <1152554328.5320.6.camel@localhost.localdomain>  <20060710180839.GA16503@elf.ucw.cz>
  <Pine.LNX.4.64.0607110035300.17704@scrub.home> <1152571816.9062.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jul 2006, john stultz wrote:

> > > APM can only keep interrupts disabled on non-IBM machines, presumably
> > > due to BIOS problems.
> > 
> > Is it possible to disable the timer interrupt before suspend and just 
> > reinit the timer afterwards?
> 
> The timer interrupt is re-enabled, via the timer_sysclass::resume hook,
> while the timekeeping code is re-enabled via the
> timekeeping_sysclass::resume hook. The issue being that I'm not sure
> there's a defined way to specify the .resume calling order.
> 
> The timekeeping_suspended flag is a bit heavy handed, but I think it
> might be the safest bet (assuming Mikael finds it works for him).

As temporary measure it's ok, but please add a comment, that it's there 
because of broken suspend/resume ordering.
That's another reason why I think that keeping interrupt handling and 
timekeeping separate is illusionary.

bye, Roman
