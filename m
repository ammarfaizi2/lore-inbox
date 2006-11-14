Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754793AbWKNLKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbWKNLKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbWKNLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:10:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25528 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1754793AbWKNLKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:10:12 -0500
Date: Tue, 14 Nov 2006 12:09:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>, Mikael Pettersson <mikpe@it.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061114110958.GB2242@elf.ucw.cz>
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu> <20061112235410.GB31624@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112235410.GB31624@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Nevertheless, I give you two options:
> > > 
> > > 1. Abort all IO do inserted floppy disk after resume.
> > > 2. Corrupt replaced floppy disk after resume.
> > > 
> > > You have to pick one and exactly one.  Which is inherently less risky 
> > > to the end user?
> > 
> > this isnt about in-flight IO (suspend doesnt succeed if IO is in flight 
> > anyway).
> 
> I wasn't talking about in-flight IO.  Take a moment to think about it.
> 
> - You have a floppy inserted and mounted.

Notice that Ingo is not talking about floppy being mounted.

> - You write a file to it, and then suspend the machine.
>   *** No IO was in progress when the suspend occurred.
> - You remove the floppy disk and insert a different disk
> - You resume
> - The kernel submits the dirty buffers for writing out to the disk.
> 
> That would lead to a corrupted floppy disk.

Suspending with mounted floppy is a user error. Write tarball to a
floppy, suspend, resume, write another tarball to a floppy is not, and
we want to fix that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
