Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJWUIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTJWUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:18 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6343 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261777AbTJWUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:13 -0400
Date: Thu, 23 Oct 2003 10:17:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031023081750.GB854@openzaurus.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066866741.1114.71.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static int pit_resume(struct sys_device *dev)
> > +{
> > +	if (got_clock_diff) {	/* Must know time zone in order to set clock */
> > +		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
> > +		xtime.tv_nsec = 0; 
> > +	} 
> > +	return 0;
> > +}
> > +
...
> Forgive me, I'm not totally familiar w/ the sysfs/pm stuff, but normally
> you need to have the xtime_lock to safely manipulate xtime. Also,
> couldn't you just call settimeofday() instead?  The bit about manually
> setting the timezone also confuses me, as we don't normally do this at
> bootup in the kernel.  
> 

I took it straight from apm.c... But it is well possible that it needs
some locking. OTOH this runs with interrupts disabled, perhaps
thats enough?
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

