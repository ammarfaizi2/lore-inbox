Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVAGA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVAGA2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVAGA0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:26:09 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:15825 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261201AbVAGAXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:23:14 -0500
Subject: Re: 2.6.10-mm2: swsusp regression
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050106234829.GF28777@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501061848.11719.rjw@sisk.pl> <20050106225233.GD2766@elf.ucw.cz>
	 <200501070041.43023.rjw@sisk.pl>  <20050106234829.GF28777@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105057470.3254.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 07 Jan 2005 11:24:30 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

AMD64 doesn't have MTRRs, does it? If it does, I'd bet on an SMP hang.

Nigel

On Fri, 2005-01-07 at 10:48, Pavel Machek wrote:
> Hi!
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> > > > > 
> > > > > - Various minorish updates and fixes
> > > > 
> > > > There's an swsusp regression on my box (AMD64) wrt -mm1.  Namely, 
> > 2.6.10-mm2 
> > > > does not suspend, but hangs solid right after the critical section, 100% 
> > of 
> > > > the time.
> > > 
> > > can you comment out device_power_{down,up} from
> > > swsusp_{suspend,resume} and see what happens?
> > 
> > It works just fine.
> 
> Ok, problem is that device_power_{down,up} is right thing, and
> neccessary for many machines to work...
> 
> ...so... could you go through sysdev_register()s, one by one,
> commenting them to see which one causes the regression? That driver
> then needs to be fixed.
> 
> Go after mtrr and time in first places.
> 								Pavel
> PS: Probably drop andrew from reply; he probably gets enough mail
> anyway. I want this one to go to him so that he does not back up the
> patch, through.
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

