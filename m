Return-Path: <linux-kernel-owner+w=401wt.eu-S932669AbXAATXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbXAATXP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbXAATXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:23:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42254 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbXAATXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:23:14 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC] HZ free ntp
Date: Mon, 1 Jan 2007 17:27:45 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612132125450.1867@scrub.home> <1166578357.5594.3.camel@localhost>
In-Reply-To: <1166578357.5594.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011727.46944.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 20 December 2006 02:32, john stultz wrote:

> > I know and all you have to change in the ntp and some related code is to
> > replace HZ there with a variable, thus make it changable, so you can
> > increase the update interval (i.e. it becomes 1s/hz instead of 1s/HZ).
>
> Untested patch below. Does this vibe better with you are suggesting?

Yes, thanks.
tick_nsec doesn't require special treatment, in the middle term it's obsolete 
anyway, it could be replaced with (current_tick_length() >> 
TICK_LENGTH_SHIFT) and current_tick_length() being inlined.
NTP_INTERVAL_FREQ could be a real variable (so it can be initialized at 
runtime), it's already gone from all important paths.
In the short term I'd prefered a clock would store its frequency instead of 
using NTP_INTERVAL_LENGTH in clocksource_calculate_interval(), so it doesn't 
has to be derived there.

bye, Roman
