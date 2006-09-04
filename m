Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWIDLA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWIDLA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWIDLAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:00:25 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:28140 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751312AbWIDLAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:00:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Date: Mon, 4 Sep 2006 13:03:25 +0200
User-Agent: KMail/1.9.1
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
References: <200608151509.06087.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl> <20060904090820.GA4500@suse.de>
In-Reply-To: <20060904090820.GA4500@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609041303.25817.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 4 September 2006 11:08, Stefan Seyfried wrote:
> Hi,
> 
> sorry, i am only slowly catching up after vacation.
> 
> On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
> > Change suspend_console() so that it waits for all consoles to flush the
> > remaining messages and make it possible to switch the console suspending
> > off with the help of a Kconfig option.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
> >  /**
> >   * suspend_console - suspend the console subsystem
> >   *
> > @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
> >   */
> >  void suspend_console(void)
> >  {
> > +	printk("Suspending console(s)\n");
> >  	acquire_console_sem();
> >  	console_suspended = 1;
> > +	/* This is needed so that all of the messages that have already been
> > +	 * written to all consoles can be actually transmitted (eg. over a
> > +	 * network) before we try to suspend the consoles' devices.
> > +	 */
> > +	ssleep(2);
> 
> Sorry, but no. Suspend and resume is already slow enough, no need to make
> both of them much slower.
> If we can condition this on the netconsole being used, ok, but not for the
> most common case of "console is on plain VGA".

Hm, it already is in -mm, but of course I can prepare a patch that removes
this ssleep().

Pavel, what do you think?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: H 4.55007e-15
