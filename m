Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVABUvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVABUvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVABUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:51:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31249 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261324AbVABUvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:51:52 -0500
Date: Sun, 2 Jan 2005 21:51:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@ucw.cz>, luto@myrealbox.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102205151.GE4183@stusta.de>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de> <200501022134.16338.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501022134.16338.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:34:16PM +0100, Oliver Neukum wrote:
> Am Sonntag, 2. Januar 2005 21:11 schrieb Adrian Bunk:
> > On Sun, Jan 02, 2005 at 08:37:24PM +0100, Pavel Machek wrote:
> > 
> > > Well, umount -l can be handy, but it does not allow you to get your CD
> > > back from the drive.
> > > 
> > > umount --kill that kills whoever is responsible for filesystem being
> > > busy would solve part of the problem (that can be done in userspace,
> > > today).
> > >...
> > 
> > What's wrong with
> > 
> >   fuser -k /mnt && umount /mnt
> 
> 1. Would need suid.

It needs suid only if you aren't root and you want to kill processes you 
don't own.

Yes, this might cause problems e.g. if users are allowed to mount their 
cdroms, but simply allowing them to kill processes of other users who 
access this device isn't a solution, too.

> 2. Is a mindless slaughter of important processes.

It's what Pavel wanted to get included in umount.

Usually, you'll let fuser give you the list of processes and inspect 
them manually.

> 3. Is a race condition.

Then put it into a while loop that executes until umount returns 0.

I still fail to see why I should implement half of fuser in umount. 
Either you are working at the command line and know about fuser or you 
are working through a GUI which can offer you a "kill all applications 
accessing this device" button that calls fuser.

> 	Regards
> 			Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

