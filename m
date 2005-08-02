Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVHBJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVHBJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVHBJ4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:56:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38564 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261449AbVHBJyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:54:13 -0400
Date: Tue, 2 Aug 2005 11:54:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050802095401.GB1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston> <20050801203728.2012f058.Ballarin.Marc@gmx.de> <1122926885.30257.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122926885.30257.4.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Why are we calling driver suspend routines in these ? This is _not_ a
> > > good idea ! On various machines, the mecanisms for shutting down are
> > > quite different from suspend/resume, and current drivers have too many
> > > bugs to make that safe. I keep getting all sort of reports of machines
> > > not shutting down anymore.
> > 
> > For example, my Centrino laptop will restart instead of power down with
> > -mm kernels.
> > 
> > To "fix" this I can either:
> > - unplug power. Shutdown works when on battery power.
> > - attach an external USB hard disk => power down always works.
> > - remove device_suspend(PMSG_SUSPEND) => power down always works.-
> 
> Yes, this is just one of the gazillion setup that got broken by this
> change. Drivers already have a shutdown() callback anyway, and if we
> want to re-use the suspend one, then we need to define some sane
> parameter, not "fake" a system suspend.

I'd like to get rid of shutdown callback. Having two copies of code
(one in callback, one in suspend) is ugly.
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
