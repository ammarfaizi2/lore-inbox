Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWIDLC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWIDLC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWIDLCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:02:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43912 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932130AbWIDLCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:02:54 -0400
Date: Mon, 4 Sep 2006 13:02:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stefan Seyfried <seife@suse.de>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Message-ID: <20060904110229.GM9991@elf.ucw.cz>
References: <200608151509.06087.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl> <20060904090820.GA4500@suse.de> <200609041303.25817.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609041303.25817.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-09-04 13:03:25, Rafael J. Wysocki wrote:
> On Monday, 4 September 2006 11:08, Stefan Seyfried wrote:
> > Hi,
> > 
> > sorry, i am only slowly catching up after vacation.
> > 
> > On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
> > > Change suspend_console() so that it waits for all consoles to flush the
> > > remaining messages and make it possible to switch the console suspending
> > > off with the help of a Kconfig option.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > > +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
> > >  /**
> > >   * suspend_console - suspend the console subsystem
> > >   *
> > > @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
> > >   */
> > >  void suspend_console(void)
> > >  {
> > > +	printk("Suspending console(s)\n");
> > >  	acquire_console_sem();
> > >  	console_suspended = 1;
> > > +	/* This is needed so that all of the messages that have already been
> > > +	 * written to all consoles can be actually transmitted (eg. over a
> > > +	 * network) before we try to suspend the consoles' devices.
> > > +	 */
> > > +	ssleep(2);
> > 
> > Sorry, but no. Suspend and resume is already slow enough, no need to make
> > both of them much slower.
> > If we can condition this on the netconsole being used, ok, but not for the
> > most common case of "console is on plain VGA".
> 
> Hm, it already is in -mm, but of course I can prepare a patch that removes
> this ssleep().
> 
> Pavel, what do you think?

Well, in suspend-to-ram case, 2 seconds is quite a lot... like more
than rest of suspend, so stefan has some point...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: H 1.68641e-06
