Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTDWPWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbTDWPWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:22:06 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:42169 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264077AbTDWPWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:22:02 -0400
Date: Wed, 23 Apr 2003 17:32:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030423153227.GC3035@elf.ucw.cz>
References: <1050314423.5574.65.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050314423.5574.65.camel@zion.wanadoo.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - On any machine, with suspend to disk, the slot is powered off (along
> with the entire host machine). But the machine will be rebooted and the
> device put back to "idle" state some way by the loader kernel, so this
> ends up a bit like the above case.

Actually as swsusp gets better it should power the device off then
on... OTOH that is very hard for video cards.

> So basically, the "state" parameter should encore not only what state
> we want to go to, but rather, what will happen to the slot:
> 
> - Nothing (it's entirely up to the driver to do it's own power
> management, that happens for some devices inside Apple ASIC), though in
> this case at least, those driver have control over the chip power, reset
> lines, etc...
> - Slot will be unclocked (it's up to the driver, it the chip supports
> static mode, to go to D2 or D3 if the driver can deal with it, though
> the system will do nothing to help the driver)
> - Slot will be powered off. This case should be broken up (via an
> additional flag passed to the driver ?) into 1) the system _will_
> re-POST the card before resume (BIOS/ACPI support, swsusp) or the
> system will NOT re-POST the card, the driver shall fail the sleep
> request if it can't do it by itself.

This is also possibility. Yes, this is probably good idea for at least
short term. Then we should make sure that "will re-post" is used less
and less and that it finally disappears.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
