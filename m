Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUJGVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUJGVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJGVWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:22:25 -0400
Received: from gprs214-219.eurotel.cz ([160.218.214.219]:57985 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268293AbUJGVTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:19:35 -0400
Date: Thu, 7 Oct 2004 23:19:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: usbcore wakeup updates (3/4)
Message-ID: <20041007211921.GE1447@elf.ucw.cz>
References: <200410041407.47500.david-b@pacbell.net> <20041006105155.GE4723@openzaurus.ucw.cz> <200410070835.53261.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410070835.53261.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > There were already some hooks in usbcore, but they were only
> > > configurable for root hubs ... but not keyboards, mice, Ethernet
> > > adapters, or other devices.
> > 
> > That "when asked about D1 enter D3" bit worries me a bit, because
> > it is (ugly) workaround to core problems, but I can survive it.
> 
> I'm not sure what a better fix would be though ... I think WIndows
> doesn't bother entering a low power state at all in such cases.
> Which seems particularly pointless for the typical USB controller,
> which is probably idle at that point already, and which can't take
> all that much longer to resume from D3hot than from D1.

Hmm, perhaps it is wrong thing to tell the devices what state to enter
in the first place.

> Do you think adding those two bits to per-device PM state
> is basically a good way to introduce their wakeup capabilities
> to the PM core?  Suggestions on the next step?

It did not look overly ugly to me... so it is probably okay. Not sure
what the next step is -- you'll probably want some sysfs interface for
suspending single devices?

> > Introducing enums where PCI suspend level is stored in u32
> > would be welcome... 
> 
> I'm not averse to enums, especially once sparse does good things
> with them, but I still think that sort of change would just be nibbling
> around the edges of a larger problem.  (Which should be addressed
> by different patches making device power states/policies, like G0/D1
> or "idle yourself", be types that are fully distinct from system power
> states like G1/S3, and for which abuse creates compiler errors.)

I'm not sure we want to move to anything complicated than simple enum.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
