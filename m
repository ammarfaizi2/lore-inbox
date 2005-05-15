Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVEOKgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVEOKgu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVEOKgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:36:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15573 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261599AbVEOKgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:36:48 -0400
Date: Sun, 15 May 2005 12:36:46 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <ak@suse.de>, Alexander Nyberg <alexn@telia.com>,
       Jan Beulich <JBeulich@novell.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] adjust x86-64 watchdog tick calculation
Message-ID: <20050515103646.GF26242@wotan.suse.de>
References: <s2832159.057@emea1-mh.id2.novell.com> <1115892008.918.7.camel@localhost.localdomain> <20050512142920.GA7079@openzaurus.ucw.cz> <20050513113023.GD15755@wotan.suse.de> <20050513195215.GC3135@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513195215.GC3135@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:52:15PM +0200, Pavel Machek wrote:
> On P? 13-05-05 13:30:23, Andi Kleen wrote:
> > > Because it kills machine when interrupt latency gets too high?
> > > Like reading battery status using i2c...
> > 
> > That's a bug in the I2C reader then. Don't shot the messenger for bad news.
> 
> Disagreed.
> 
> Linux is not real time OS. Perhaps some real-time constraints "may not
> spend > 100msec with interrupts disabled" would be healthy, but it
> certainly needs more discussion than "lets enable NMI
> watchdog.". It needs to be written somewhere in big bold letters, too.

While linux is not a real time OS it has been always known that
turning off interrupts for a long time is extremly rude.

If you really want you can use touch_nmi_watchdog in the delay
loop then.  But note you have to compile it in, because touch_nmi_watchdog
is not exported (Linus vetoed that for good reasons).

But again do you really need to disable interrupts during this
i2c access? Can't you just use a schedule_timeout() and a semaphore?
Why would other interrupts cause a problem during such a long delay?

-Andi
