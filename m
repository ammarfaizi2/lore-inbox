Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVAUD6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVAUD6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 22:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVAUD6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 22:58:13 -0500
Received: from waste.org ([216.27.176.166]:47505 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262261AbVAUD6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 22:58:08 -0500
Date: Thu, 20 Jan 2005 19:57:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
Message-ID: <20050121035758.GH12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120160123.14f13ca6.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 04:01:23PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> > 
> > FB_RADEON.
> 
> Ah, OK.  Likely culprits are
> 
> radeonfb-massive-update-of-pm-code.patch
> radeonfb-build-fix.patch

Ok, learned a few things.

Here are the symptoms:

mm2: corruption of Tux logo at boot, corruption of display at
powerdown, lockup and LCD blooming on next warm boot when radeonfb
starts. Ben suggested I try some radeonfb options, but none seemed to
have any effect.

mm1: no observed problems

mm2 - above patches: corruption still occurs but no lockup on next
warm boot.

I think I have a lead on the logo and shutdown corruption:

If I do a reboot(8) from inside X, I get switched to vt 0, but the
shutdown messages come out on vt 7, where X was running. As I'm
sitting on vt 0 during shutdown, I see character cells changed to
something like "_" (last two scanlines filled) slowly marching down
the screen corresponding to the shutdown messages.

So the logo corruption is probably getty popping up on the
other vts at the end of init. The timing and the screen placement seem
to agree.

Photos for the curious (be sure to see "executioner Tux" glitch):
http://selenic.com/radeon

-- 
Mathematics is the supreme nostalgia of our time.
