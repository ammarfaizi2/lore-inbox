Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWGWMJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWGWMJE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 08:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGWMJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 08:09:04 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:6865 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751023AbWGWMJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 08:09:02 -0400
Date: Sun, 23 Jul 2006 14:08:29 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060723120829.GA7776@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de> <20060722173649.952f909f.akpm@osdl.org> <20060723081604.GD27566@kiste.smurf.noris.de> <20060723044637.3857d428.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723044637.3857d428.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew Morton:
> - CPU0 and CPU1 share a TSC and CPU2 and CPU3 share another TSC.
> 
That mmakes sense, since they're one dual-core Xeon each.

> - Earlier kernels didn't use the TSC as a time source whereas this one
>   does, hence the problems which you're observing.
> 
Correct; see below.

> I assume that booting with clock=pit or clock=pmtmr fixes it?
> 
Testing... yes, both.

> It would be useful to check your 2.6.17 boot logs, see if we can work out
> what 2.6.17 was using for a clock source.
> 
That's easy:

2.6.17    -Using pmtmr for high-res timesource
2.6.18git +Time: tsc clocksource has been installed.

I missed those two lines, as in the boot logs they're not really
adjacent, so they got lost in the jumble of other differences.

Interestingly, CPU0/1 gets 6000 bogomips while CPU2/3 only reaches 5600 ..?
(That happens with both kernels.) I do wonder why, and whether this has any
bearing on the current problem.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
BEANS ARE NEITHER FRUIT NOR MUSICAL
		-- Bart Simpson on chalkboard in episode 1F22
