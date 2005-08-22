Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVHVXHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVHVXHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVHVXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:07:47 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:21808 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932327AbVHVXHp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:07:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XdwKxQjGpvB1D7GTGpFgD1ijBCurAruibvqT5psLL+savdjsndt+lKZIwHFYa07mHqlsxyH9/766vwqUWnMb4g/YQBnt2GGQHf39UfEfS2TWA8KnP9HA3DGmNUhJXg1lf2c9aehz1W2pDI4LHoikozvW4rz1zaaG43BYU4BuHLo=
Message-ID: <21d7e9970508221607bb74cc7@mail.gmail.com>
Date: Tue, 23 Aug 2005 09:07:42 +1000
From: Dave Airlie <airlied@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: rc6 keeps hanging and blanking displays
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050822214453.GA31266@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050815221109.GA21279@aitel.hist.no>
	 <21d7e99705081516241197164a@mail.gmail.com>
	 <20050816165242.GA10024@aitel.hist.no>
	 <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>
	 <20050816211424.GA14367@aitel.hist.no>
	 <21d7e99705081616504d28cca5@mail.gmail.com>
	 <43031A12.8020301@aitel.hist.no>
	 <21d7e997050817040523a1bf46@mail.gmail.com>
	 <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>
	 <20050822214453.GA31266@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> I have found that the crash and the balnking may be different problems.
> It seems that any kernel with a _working_ drm sooner or later will cause
> a hang on the radeon display, possibly but not necessarily freezing the
> machine for a while or forever.  This happens more often if I actually
> stress drm, such as playing tuxracer. But it can happen with
> plain firefox/xterm/thunderbird work too.  (no opengl screensavers
> or animated window managers here.)

yes there are still some unknown issues in the r200 drivers even on my
own 9200, this isn't probably more of an issue with the userspace
driver (granted I think the DRM could have some race condition as
well...)

> 
> My rock solid 2.6.13-rc4-mm1 has drm compiled in, but drm fails when X
> starts, and therefore drm isn't used.  And therefore, a stable kernel.
> From Xorg.2.log:
> drmOpenDevice: open result is 6, (OK)
> drmOpenByBusid: drmOpenMinor returns 6
> drmOpenByBusid: drmGetBusid reports pci:0000:00:08.0
> (II) RADEON(0): [drm] DRM interface version 1.2
> (II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:00:08.0"
> (II) RADEON(0): [drm] added 8192 byte SAREA at 0xffffc20000147000
> (II) RADEON(0): [drm] drmMap failed
> (EE) RADEON(0): [dri] DRIScreenInit failed.  Disabling DRI.
> (II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)
> (II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
> (II) RADEON(0): Largest offscreen area available: 1280 x 7165
> (II) RADEON(0): Render acceleration enabled
> (II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
> drmMap failed for this kernel.
> 

Should be fixed in -mm now, this was a problem on x86-64

> 
> Seems like replacing the radeon is a good idea, it will probably never
> do stable 3D as even old kernels have this particular problem.  The
> performance is apalling too, the old g550 gets a 3x-5x better framerate...
> 
> The blank display problem is different.  That problem follows the
> bisect search, i.e. the "good" kernels never ever blanks the
> display for me, and the "bad" kernels always do so after a little while.
> Even if all I use is 2D stuff. (All with drm configured)
> 
> As for the patch to revert - it did fix things so an rc6 without drm
> came up.  I'm using that kernel now. I guess it'll be fine,
> with no drm. I'll keep it running tomorrow, for stability testing.
> 
> What is the next logical step?  rc6 with both drm and this patch reverted?
> Or is there any new development?

Linus,
Can we revert the PCI assign resources patch? this is 2-3 bug reports
with it and they all centre on the MGA G550 card, we need to be able
to do some sort of blacklisting perhaps so these cards don't get
touched until we can figure out why it is breaking X...

Dave.
