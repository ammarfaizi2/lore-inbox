Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbWGJWuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbWGJWuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWGJWuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:50:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:11904 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965305AbWGJWuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:50:18 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607110035300.17704@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
	 <Pine.LNX.4.64.0607110035300.17704@scrub.home>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 15:50:16 -0700
Message-Id: <1152571816.9062.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 00:37 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 10 Jul 2006, Pavel Machek wrote:
> 
> > APM can only keep interrupts disabled on non-IBM machines, presumably
> > due to BIOS problems.
> 
> Is it possible to disable the timer interrupt before suspend and just 
> reinit the timer afterwards?

The timer interrupt is re-enabled, via the timer_sysclass::resume hook,
while the timekeeping code is re-enabled via the
timekeeping_sysclass::resume hook. The issue being that I'm not sure
there's a defined way to specify the .resume calling order.

The timekeeping_suspended flag is a bit heavy handed, but I think it
might be the safest bet (assuming Mikael finds it works for him).

thanks
-john




