Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUFAQDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUFAQDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUFAQDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:03:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43652 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265095AbUFAQCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:02:35 -0400
Date: Tue, 1 Jun 2004 18:02:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040601160234.GB1899@atrey.karlin.mff.cuni.cz>
References: <20040526203524.GF2057@devserv.devel.redhat.com> <20040530184031.GF997@openzaurus.ucw.cz> <20040531133834.GA5834@devserv.devel.redhat.com> <s5hllj7qt7g.wl@alsa2.suse.de> <1086102397.7500.2.camel@laptop.fenrus.com> <s5hbrk3qoxw.wl@alsa2.suse.de> <20040601153800.GA22986@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601153800.GA22986@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj!

> > > [1  <text/plain (quoted-printable)>]
> > > 
> > > > int xxx_resume(struct pci_dev *dev)
> > > > {
> > > > 	int err;
> > > > 	if ((err = pci_default_resume(dev)) < 0)
> > > > 		return err;
> > > > 	// ... do h/w specific
> > > > }
> > > 
> > > well define "h/w specific", just give me an example of a real (alsa?)
> > > driver that would use it (or point me to one) so that I can see if this
> > > is the best API, what the return value should be etc etc 
> > 
> > I'm afraid the ALSA drivers aren't be the best examples :)
> > It doesn't handle the error in suspend/resume at all.
> 
> hm it looks like all this would gain is that instead of 2 or 3 function calls
> you need to do one which then calls those 3. The *driver* already knows if
> it needs busmaster or not etc, so when I wrote this code I felt that the
> driver could do a better job really. But well if you think it's worth it to
> save those 3 lines into 1 ?

I'd prefer one line, same in all alsa drivers, than each driver trying
to be clever.

[It seems to me like ALSA can't easily put NULL into suspend/resume
fields, because they have additional layer of abstraction between them
and kernel.]
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
