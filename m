Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWFIIqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWFIIqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWFIIqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:46:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32952 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964872AbWFIIqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:46:49 -0400
Date: Fri, 9 Jun 2006 10:46:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org,
       jeremy@goop.org
Subject: fixing serial console over suspend [was Re: Bisects that are neither good nor bad]
Message-ID: <20060609084600.GF18084@elf.ucw.cz>
References: <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk> <20060529145255.GB32274@redhat.com> <20060530152926.GA4103@ucw.cz> <20060603091133.GA24271@flint.arm.linux.org.uk> <20060609083833.GD18084@elf.ucw.cz> <20060609084234.GA25497@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060609084234.GA25497@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 09-06-06 09:42:34, Russell King wrote:
> On Fri, Jun 09, 2006 at 10:38:33AM +0200, Pavel Machek wrote:
> > > The serial layer does _not_ have access to the "current" termios
> > > settings due to the layering by the tty subsystem.  If the serial
> > > port being used by serial console has been opened once by the user,
> > > but is closed at the moment when a suspend/resume cycle occurs,
> > > the serial layer and lower level drivers do not have access to the
> > > baud rate.
> > 
> > Could serial layer just cache "last baud rate" in some kind of
> > software shadow register? Yes, it is slightly ugly, but should do the trick.
> 
> That's not a new suggestion.  How do you deal with the case where
> you have console on two or more different serial ports?  That's
> the problem with this approach.

Well, each of serial ports has hardware baud_rate register. I'll need
software baud_rate_shadow for every serial port, setting
baud_rate_shadow each time baud_rate is set. During resume, I restore
baud_rate from baud_rate_shadow for each serial port.

What am I missing?

> The only sane solution is for the tty layer to be adjusted to allow
> suspend/resume support for consoles.

Well, solution above is likely to be ugly, but even ugly patch would
help people debug s-to-RAM.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
