Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVIFRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVIFRsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVIFRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:48:22 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65417 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750727AbVIFRsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:48:22 -0400
Date: Tue, 6 Sep 2005 10:48:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: viro@ZenIV.linux.org.uk, "David S. Miller" <davem@davemloft.net>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (GEN_RTC dependencies)
Message-ID: <20050906174818.GB3966@smtp.west.cox.net>
References: <20050906005645.GQ5155@ZenIV.linux.org.uk> <20050905.185141.44096788.davem@davemloft.net> <20050906022423.GT5155@ZenIV.linux.org.uk> <Pine.LNX.4.61L.0509061109350.6760@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0509061109350.6760@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 03:40:47PM +0100, Maciej W. Rozycki wrote:
> On Tue, 6 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 
> > >From my reading of that code, GEN_RTC should've been called FAKE_RTC...
> 
>  Yep, it's an excuse for platform maintainers not to write proper drivers.

I talked with Al about this off list a bit, and pointed out it's
different than it appears.  GEN_RTC really is a mostly-generic RTC
driver.  There's some fakey stuff going on for UIE (all under
GEN_RTC_X), but the real meat of the driver is common export get/set
time and per-arch (which can abstract further, see ppc32) poke the
hardware for the time. There's 2 (afaik) problems, one being a lack of
alarm support, and the other being hardware access isn't (today)
abstracted out far enough for i2c stuff to work.

Russell King has both of these fixed in the ARM-specific but hardware
poking abstracted rtc driver.  I'd like to try and merge things at
somepoint...

-- 
Tom Rini
http://gate.crashing.org/~trini/
