Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVBFMPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVBFMPC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVBFMPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:15:02 -0500
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:20119 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261189AbVBFMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:14:34 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org> <m3d5vengs2.fsf@telia.com>
	<1107686024.30303.52.camel@gaston>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Feb 2005 13:14:20 +0100
In-Reply-To: <1107686024.30303.52.camel@gaston>
Message-ID: <m3acqhnaw3.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2005-02-06 at 11:07 +0100, Peter Osterlund wrote:
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/
> > 
> > It gives me a kernel panic at boot if I have CONFIG_FB_RADEON
> > enabled. If I also have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get this
> > output:
> > 
> >         Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >         ...
> >         PREEMPT
> >         ...
> >         EIP is a strncpy_from_user+0x33/0x47
> >         ...
> >         Call Trace:
> >          getname+0x69/0xa5
> >          sys_open+0x12/0xc6
> >          sysenter_past_esp+0x52/0x75
> >         ...
> >         Kernel panic - not syncing: Attempted to kill init!
> > 
> > If I don't have CONFIG_FRAMEBUFFER_CONSOLE enabled, I get a screen
> > with random junk and some blinking colored boxes, and the machine
> > hangs.
> 
> That's very strange... I don't see what in radeonfb could cause this.
> Just in case, can you try commenting out the call to radeon_pm_init() in
> radeon_base.c, see if it makes any difference (though I don't think so).

No, it didn't make any difference. I added a printk to do_getname()
and I see that it is called with filename==0.

I disabled the framebuffer so I could boot the kernel, then wrote a
small test program that does open(0, O_RDONLY). This also calls
do_getname() with filename==0, but does not generate an oops. Maybe
there is something wrong with exception handling that early in the
boot sequence.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
