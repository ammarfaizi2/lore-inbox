Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWFIIjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWFIIjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWFIIjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:39:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36050 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751447AbWFIIjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:39:20 -0400
Date: Fri, 9 Jun 2006 10:38:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org,
       jeremy@goop.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060609083833.GD18084@elf.ucw.cz>
References: <20060528140238.2c25a805.dickson@permanentmail.com> <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk> <20060529145255.GB32274@redhat.com> <20060530152926.GA4103@ucw.cz> <20060603091133.GA24271@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603091133.GA24271@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > With the resume failure I'm seeing, we don't get back to userspace
> > > to run anything like this. It goes bang long before that.
> > > 
> > > The SATA fix Mark proposed also didn't improve the situation for me :-/
> > 
> > If setserial -a is needed.. it means that someone really needs to fix
> > suspend/resume support for serial... do it on working machine to
> > enable debugging of broken ones...
> 
> I've explained why this occurs in bugzilla - but for the sake of
> repeating repeating repeating myself at great length, let's repeat
> it again here.
> 
> The serial layer does _not_ have access to the "current" termios
> settings due to the layering by the tty subsystem.  If the serial
> port being used by serial console has been opened once by the user,
> but is closed at the moment when a suspend/resume cycle occurs,
> the serial layer and lower level drivers do not have access to the
> baud rate.

Could serial layer just cache "last baud rate" in some kind of
software shadow register? Yes, it is slightly ugly, but should do the trick.

> Hence, it is impossible for the serial layer to do a proper resume
> in this scenario.  Either always suspend with the console port open
> or never open the console port before suspend.  Alternatively, we
> need the tty layer to mature, so that there is some way for drivers
> to get the termios structures for the console from the upper layer.
> Or maybe we need the tty layer to be responsible for implementing
> suspend/resume support for tty devices.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
