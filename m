Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWIKIJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIKIJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIKIJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:09:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59105 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751228AbWIKIJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:09:25 -0400
Date: Mon, 11 Sep 2006 10:09:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Theodore Tso <tytso@mit.edu>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060911080901.GC1898@elf.ucw.cz>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr> <20060906132623.GA15665@clipper.ens.fr> <20060909231805.GC24906@thunk.org> <20060910123631.GA4206@ucw.cz> <20060910232412.GE22892@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910232412.GE22892@thunk.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > absence of an explicit capability record.  Both of these should be
> > > overrideable by a mount option, but for convenience's sake it would be
> > > convenient to be able to set these values in the superblock.
> > 
> > Would per-system default capability masks be enough? ... .... okay,
> > probably not, because nosuid is per-mount, and this is similar.
> 
> Per system defaults would also be good, but I believe it would also be
> a good idea for their to be per-filesystem defaults.  Yes, not all
> filesystems would support per-filesystem defaults, since this requires
> extensions in their superblock; for those, they would only have the
> per-system defaults.

Aha, okay... David, doing global defaults should be very easy, as
should be doing ext3 example conversion...

> > > As far as negative capabilities, I feel rather strongly these should
> > > not be separated into separate capability masks.  They can use the
> > > same framework, sure, but I think the system will be much safer if
> > > they use a different set of masks.  Otherwise, there can be a whole
> > > class of mistakes caused by people and applications getting confused
> > 
> > Can we simply split them at kernel interface layer? Libc could do it,
> > preventing confusion...
> 
> But that means libc would need to know which bit positions were
> positive capabilities, and which were negative, and adding new
> capabilities would require a matching change with libc.  Not a good
> idea, I think....

Okay, I guess we could hardcode the mask (top 16 capabilities are
"normal") but yes, I see your point now. We probably want different
syscalls, even if underlying implementation shares the code...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
