Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVABU5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVABU5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVABU5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:57:24 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:13444 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261335AbVABU5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:57:12 -0500
Date: Sun, 2 Jan 2005 21:56:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Oliver Neukum <oliver@neukum.org>, luto@myrealbox.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102205650.GG18136@elf.ucw.cz>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de> <200501022134.16338.oliver@neukum.org> <20050102205151.GE4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102205151.GE4183@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > > Well, umount -l can be handy, but it does not allow you to get your CD
> > > > back from the drive.
> > > > 
> > > > umount --kill that kills whoever is responsible for filesystem being
> > > > busy would solve part of the problem (that can be done in userspace,
> > > > today).
> > > >...
> > > 
> > > What's wrong with
> > > 
> > >   fuser -k /mnt && umount /mnt
> > 
> > 1. Would need suid.
> 
> It needs suid only if you aren't root and you want to kill processes you 
> don't own.
> 
> Yes, this might cause problems e.g. if users are allowed to mount their 
> cdroms, but simply allowing them to kill processes of other users who 
> access this device isn't a solution, too.
> 
> > 2. Is a mindless slaughter of important processes.
> 
> It's what Pavel wanted to get included in umount.
> 
> Usually, you'll let fuser give you the list of processes and inspect 
> them manually.
> 
> > 3. Is a race condition.
> 
> Then put it into a while loop that executes until umount returns 0.
> 
> I still fail to see why I should implement half of fuser in umount. 
> Either you are working at the command line and know about fuser or you 
> are working through a GUI which can offer you a "kill all applications 
> accessing this device" button that calls fuser.

Okay, so the right solution is probably something more like

while umount /mnt; do
	fuser -km -TERM /mnt
	sleep 1
	fuser -km /mnt
done

Not sure how many command line users can do this... Perhaps including
fumount script doing this is good idea?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
