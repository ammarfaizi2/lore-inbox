Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWJWSGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWJWSGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWJWSGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:06:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51601 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964981AbWJWSGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:06:48 -0400
Date: Mon, 23 Oct 2006 20:06:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061023180638.GB3766@elf.ucw.cz>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org> <20061023171450.GA3766@elf.ucw.cz> <20061023105022.8b1dc75d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023105022.8b1dc75d.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > I'm trying to prepare the patches to make swsusp into suspend2.
> > > > 
> > > > Oh, I see.  Please don't do that.
> > > 
> > > Why not?
> > 
> > Last time I checked, suspend2 was 15000 lines of code, including its
> > own plugin system and special user-kernel protocol for drawing
> > progress bar (netlink based). It also did parts of user interface from
> 
> That's different.
> 
> I don't know where these patches are leading, but thus far they look like
> reasonable cleanups and generalisations.  So I suggest we just take them
> one at a time.

Well, some do look okay, but for example this one complicates
freezing... and gains nothing now. It would allow some badly-designed
parts of suspend2 to be merged in future, but I doubt we want them.

> > OTOH, that was half a year ago, but given that uswsusp can now do most
> > of the stuff suspend2 does (and without that 15000 lines of code), I
> > do not think we want to do complete rewrite of swsusp now.
> 
> uswsusp seems like a bad idea to me.  We'd be better off concentrating on a
> simple, clean in-kernel thing which *works*.  Right now the main problems
> with swsusp are that it's slow and that there are driver problems. 
> 
> Fiddling with the top-level interfaces doesn't address either of these core
> problems.

No ammount of changes in kernel/power will fix driver problems, that's right.

> Apparently uswsusp has gained support for S3 while the in-kernel driver
> does not support S3.  That's disappointing.

Well, uswsusp also gained support for compression, splash screen and
RSA-encryption. While S3 support for (kernel) swsusp would be
reasonably easy/non-intrusive, is there a point? I'd really prefer
people wanting to do swsusp+S3 to use uswsusp.

My goal is to keep in-kernel swsusp simple and reliable. fast would be
nice, too. But having all the features is not the goal.

[swsusp+S3 would need some userland support, anyway, because userland
is needed for video card re-initialization. So you'd need utility
similar to s2ram...]
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
