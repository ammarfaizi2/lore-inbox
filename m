Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754549AbWKHMGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbWKHMGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbWKHMGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:06:43 -0500
Received: from styx.suse.cz ([82.119.242.94]:6799 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S965593AbWKHMGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:06:42 -0500
Date: Wed, 8 Nov 2006 13:04:44 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RPC] OLPC tablet input driver.
Message-ID: <20061108120444.GA7255@suse.cz>
References: <20060829073339.GA4181@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829073339.GA4181@aehallh.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 03:33:39AM -0400, Zephaniah E. Hull wrote:
 
> 4: Technical/policy: Buttons are currently sent to both of the input
> devices we generate, I don't see any way to avoid this that is not a
> policy decision on which buttons belong to which device, but I'm open to
> suggestions.

I would put them on the touchpad device. This way you create a regular
looking touchpad and a regular looking tablet, and the user experience
will probably be best.

If you report them both, the GUI will get doubled click events (either
through /dev/input/mice or through the event X drivers), which can
result in doubleclicks where there were none when the click event is
very short.

So reporting on both is a bad idea.

> 5: Technical: Min/max on absolute values are currently reported as the
> protocol limits (10 bits on GS X, GS Y, and PT Y.  11 bits on PT X.  7
> bits on GS pressure).  Until we get samples based on the newer design
> and do some testing to see how big the variations are, we just don't
> have any numbers to put here.

No big deal, they're informative only. However, they're defined as the
expected min/max of what the device will report, so updating them when
you get the actual hardware running makes sense.

> 6: Technical, maybe: The early samples I have that speak this protocol
> are doing some odd things with this driver.  Mostly in the realm of
> sample rate and pressure reporting.  I'm fairly sure that this is
> hardware related, but it's worth mentioning.

I would expect the sample rate to be somewhat limited by the fact that
the packets are very large and the serial communication will not be able
to keep up.

> +	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
> +	dev2->phys = priv->phys;
> +	dev2->name = "OLPC OLPC GlideSensor";

Why OLPC twice? Weren't you planning to say ALPS OLPC GlideSensor?

> +	dev2->id.bustype = BUS_I8042;
> +	dev2->id.vendor  = 0x0002;
> +	dev2->id.product = PSMOUSE_OLPC;
> +	dev2->id.version = 0x0000;



-- 
Vojtech Pavlik
Director SuSE Labs
