Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbUK0Dw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbUK0Dw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUK0DwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:52:10 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262513AbUKZTdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:39 -0500
Date: Fri, 26 Nov 2004 01:08:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
Message-ID: <20041126000853.GL2711@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298112.5805.330.camel@desktop.cunninghams> <20041125233243.GB2909@elf.ucw.cz> <1101427035.27250.161.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101427035.27250.161.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You have your own abstraction on the top of /proc? That's no-no.
> 
> You'd prefer the same code repeated 20 times?

Rest of kernel is pretty happy with /proc as-is. Why can't suspend2
just play along?

How many options are really neccessary? activate is not. selecting of
reboot can already be done in /sys. Some percentages? There really
should not be 20 things to configure.

> > > +		say("BIG FAT WARNING!! %s\n\n", suspend_print_buf);
> > > +		if (can_erase_image) {
> > > +			say("If you want to use the current suspend image, reboot and try\n");
> > > +			say("again with the same kernel that you suspended from. If you want\n");
> > > +			say("to forget that image, continue and the image will be erased.\n");
> > > +		} else {
> > > +			say("If you continue booting, note that any image WILL NOT BE REMOVED.\n");
> > > +			say("Suspend is unable to do so because the appropriate modules aren't\n");
> > > +			say("loaded. You should manually remove the image to avoid any\n");
> > > +			say("possibility of corrupting your filesystem(s) later.\n");
> > > +		}
> > > +		say("Press SPACE to reboot or C to continue booting with this kernel\n");
> > 
> > Plus kernel now actually expects user interaction to solve problems
> > during boot. No, no.
> 
> You want your cake and to eat it too? :> We don't want to warn the user
> before they shoot themselves in the foot, but not loudly enough that
> they can't help notice and choose to do something before the damage is
> done?

Kernel boot is not expected to be interactive. I'd do

if (can_erase_image)
	printk("Incorrect kernel version, image killed\n");
else
	panic("Can't kill suspended image");

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
