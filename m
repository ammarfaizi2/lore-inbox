Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVBOMrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVBOMrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVBOMrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:47:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:47494 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261703AbVBOMrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:47:05 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent C Jones <vcjones@networkingunlimited.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mpm@selenic.com
In-Reply-To: <20050215031441.EFABE1DDFE@X31.nui.nul>
References: <20050215031441.EFABE1DDFE@X31.nui.nul>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 23:46:18 +1100
Message-Id: <1108471578.1905.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 22:14 -0500, Vincent C Jones wrote:
> In article <3xVku-kH-15@gated-at.bofh.it> you write:
> >On my Thinkpad T30 with a Radeon Mobility M7 LW, I get interesting
> >console video corruption if I start GDM, switch back to text mode,
> >then stop it again. X is Xfree86 from Debian/unstable or X.org 6.8.2.
> >
> >The corruption shows up whenever the console scrolls after X has been
> >shut down and manifests as horizontal lines spaced about 4 pixel rows
> >apart containing contents recognizable as the X display. Switch from
> >vt1 to vt2 and back or visual bell clears things back to normal, but
> >corruption will reappear on the next scroll.
> >
> >This has appeared in at least 2.6.11-rc3-mm2 and rc4.
> 
> On my Thinkpad X31 with a Radeon Mobility M6 LY I see a major
> regression going from 2.6.11-rc3 to rc4. With rc-4, the frame
> buffer console (using "video=radeonfb:1024x768-24@60") comes up as
> 640x480 expanded to 1024x768. The inability of ACPI suspend to turn
> off the backlight also returns. Using rc-3, frame buffer console
> works fine and suspend/resume appears to work reliably without
> needing radeontool to turn off the backlight (as long as I do it
> from X.org X).

Ok, so, about half of users are reporting an improvement, and half are
reporting a regression... this is getting nasty...

As far as the mode is concerned, can you send me a complete dmesg log
with the radeonfb debug output enabled in your .config ?

Now, regarding backlight and suspend, it's a more complicated problem.
So far, I managed to "isolate" the issue to the type of flat panel
connected to the chip. In some cases, it seems, the panel uses an
inverted signal to drive the backlight. So depending on the type of
panel, a given bit of code will work ... or not.

I'm in contact with ATI to try to figure out how to get some proper
infos about the backlight from the BIOS (if possible at all), and some
other folks are working on adapting my power management code to various
model of thinkpads.

Unfortunately, I can't promise a version of radeonfb that will fix
everything for everybody by 2.6.11... there are still a few "gray areas"
in there, that I'm trying to clear up, hopefully ATI will provide me
with the proper infos soon...

Ben.


