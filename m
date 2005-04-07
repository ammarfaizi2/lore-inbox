Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVDGGzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVDGGzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDGGzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:55:23 -0400
Received: from orb.pobox.com ([207.8.226.5]:8883 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261620AbVDGGzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:55:16 -0400
Date: Wed, 6 Apr 2005 23:55:09 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, mjg59@scrf.ucam.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050407065509.GA7888@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org> <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net> <20050406142749.6065b836.akpm@osdl.org> <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407030614.GA7583@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 08:06:14PM -0700, Barry K. Nathan wrote:
> > > BTW, there's another strange thing that's introduced by 2.6.11-rc2-mm1:
> > > With that kernel, suspend is also ridiculously slow (speed is comparable
> > > to the slow resume with the aforementioned patch). 2.6.11-rc2 does not
> > > have that problem.
> > 
> > Does reverting swsusp-enable-resume-from-initrd.patch fix this also?
> 
> No. Reverting it from 2.6.12-rc2-mm1 (oops, I got the version number
> wrong in my previous mail -- and that should also be 2.6.12-rc2 not
> 2.6.11-rc2) speeds up resume to the original speed, but suspend is still
> ridiculously slow. Time to narrow things down again, I presume...
> 
> > > Also, with 2.6.12-rc2-mm1, this computer happens to hit the bug where
> > > all the printk timestamps are 0000000.0000000 (don't take the # of
> > > digits too literally). Probably unrelated, but I may as well mention it.
> > > (System is an Athlon XP 2200+ with SiS chipset. I can't remember which
> > > model of SiS chipset.)
> > 
> > Yes, sorry.  Reverting
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
> > will fix that one.

Reverting
sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
fixed both the printk timestamps and the slow suspend. And it also fixed
a **major** interactivity problem (running kernel compiles made X almost
unusably slow) which I discovered since sending the previous e-mail. So,
something about this patch is seriously evil.

-Barry K. Nathan <barryn@pobox.com>
