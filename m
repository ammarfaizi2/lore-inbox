Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVL0Bj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVL0Bj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 20:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVL0Bj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 20:39:58 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:31901 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932188AbVL0Bj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 20:39:56 -0500
X-Sieve: CMU Sieve 2.2
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jules Villard <jvillard@ens-lyon.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20051227012053.GB9771@blatterie>
References: <20051226194527.GA3036@blatterie>
	 <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org>
	 <1135641618.4780.3.camel@localhost.localdomain>
	 <20051227012053.GB9771@blatterie>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 12:27:08 +1100
Message-Id: <1135646828.4780.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Also, does it work if you don't use radeonfb ? radeonfb shouldn't touch
> > MC_AGP_LOCATION and the DRM change only affects that, so I'm a bit
> > surprised.
> > 
> > Ben.
> > 
> 
> Do you still want me to try that now that reverting the two patches
> made the job?

Definitely, and we need to figure out why the patch cause a regression.
Those patches fixes a serious issues with a number of machines.

The problem is very nasty as all the various parties involved (radeonfb,
X radeon driver, radeon DRM, etc...) all try to reconfigure the card
memory map in differently bogus ways...

Can you add printk's to the kernel to check the values in
CONFIG_MEMSIZE, CONFIG_APER_SIZE, priv->fb_location and the values
calculated for gart_vm_start ? Then tell me what that printk gets on X
start and when switching consoles.

Thanks,
Ben.

