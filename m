Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVCVLA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVCVLA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVCVLA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:00:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46789 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262617AbVCVLAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:00:23 -0500
Date: Tue, 22 Mar 2005 12:00:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322110008.GA1780@elf.ucw.cz>
References: <20050322013535.GA1421@elf.ucw.cz> <1111461253.18927.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111461253.18927.15.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, but it is needed. There are many drivers, and they look at
> > numerical value of PMSG_*. I'm proceeding in steps. I hopefully killed
> > all direct accesses to the constants, and will switch constants to
> > something else... But that is going to be tommorow (need some sleep).
> The patches are going to acquire correct PCI device sleep state for
> suspend/resume. We discussed the issue several months ago. My plan is we
> first introduce 'platform_pci_set_power_state', then merge the
> 'platform_pci_choose_state' patch after Pavel's pm_message_t conversion
> finished. Maybe Len mislead my comments. 
> 
> Anyway for the callback, my intend is platform_pci_choose_state accept
> the pm_message_t parameter, and it return an 'int', since platform
> method possibly failed and then pci_choose_state translate the return
> value to pci_power_t.

You can't just retype around like that. You may want it take
pci_power_t * as an argument, and then return 0/-ENODEV or something
like that. But you can't retype between int and pm_message_t...

Plus that function should have a documentation somewhere!

> > Could you just revert those two patches? First one is very
> > wrong. Second one might be fixed, but... See comments below.
> I think the platform_pci_set_power_state should be ok, did you see it
> causes oops?

No its just ugly and uses __force in "creative" way. That one can be
recovered.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
