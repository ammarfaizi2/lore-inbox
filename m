Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUALWkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUALWkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:40:18 -0500
Received: from gprs214-71.eurotel.cz ([160.218.214.71]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263491AbUALWkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:40:12 -0500
Date: Mon, 12 Jan 2004 23:39:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume support for PIT (time.c)
Message-ID: <20040112223915.GA204@elf.ucw.cz>
References: <20040110200332.GA1327@elf.ucw.cz> <1073932405.28098.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073932405.28098.43.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Sat, 2004-01-10 at 12:03, Pavel Machek wrote:
> > +static int pit_suspend(struct sys_device *dev, u32 state)
> [snip]
> > +static int pit_resume(struct sys_device *dev)
> > +{
> > +	write_seqlock_irq(&xtime_lock);
> > +	xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
> > +	xtime.tv_nsec = 0; 
> > +	write_sequnlock_irq(&xtime_lock);
> > +	return 0;
> > +}
> [snip]
> >  static struct sysdev_class pit_sysclass = {
> > +	.resume = pit_resume,
> > +	.suspend = pit_suspend,
> >  	set_kset_name("pit"),
> >  };
> 
> As none of this really has anything to do w/ the PIT, and to avoid
> confusion w/ the PIT timesource code, could we rename this to
> "time_suspend" and "time_resume"?

Applied, altrough I'll not try to push it for a while. (I'm not sure
if Andrew applied previous patches and do not want to clash).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
