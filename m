Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUK3G4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUK3G4B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 01:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbUK3G4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 01:56:00 -0500
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:8211 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S261984AbUK3Gzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 01:55:48 -0500
Date: Tue, 30 Nov 2004 07:55:55 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Kronos <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Message-ID: <20041130065555.GA20972@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20041128184606.GA2537@middle.of.nowhere> <20041129213510.GA9551@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129213510.GA9551@dreamland.darkstar.lan>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kronos <kronos@people.it>
Date: Mon, Nov 29, 2004 at 10:35:10PM +0100
> Il Sun, Nov 28, 2004 at 07:46:06PM +0100, Jurriaan ha scritto: 
> > The same radeonfb-setup works fine in every 2.6 kernel I can remember
> > (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> > in 2.4.29-pre1.
> > 
> > The card has 128 Mb of ram, and my system has 3 Mb of RAM.
> > 
> > Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?
> 
> Driver in 2.6 only ioremap()s the memory needed for the framebuffer,
> while the one in 2.4 ioremap()s all the VRAM (and fails).
> 
> > Is there any way to test 2.4 with my radeonfb and all of my memory?
> 
> I proposed the following patch some time ago (for 2.4.28-pre2 IIRC) as a
> quick fix:
> 
Thanks. I found that patch on google. Problem is: when I look through
the radeonfb in 2.6, I don't see any assignments to rinfo->video_ram
that indicate it maps less than the full amount.

> 
> Problem is that fix->smem_len is used both by FBIOGET_FSCREENINFO to
> report the amount of VRAM to userspace and by read/write/mmap on fb
> for bounds checking. So with my patch FBIOGET_FSCREENINFO reports mapped
> VRAM instead of physical VRAM.
> 
> smem_len should be splitted in (say) smem_mapped (for read/write/mmap)
> and smem_total_vram (for FBIOGET_FSCREENINFO). I'll code something
> tomorrow... -ENEEDSLEEP ;)
> 
Thanks,
Jurriaan
-- 
All wiyht. Rho sritched mg kegtops awound?
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load load 0.24
