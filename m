Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRI0OeU>; Thu, 27 Sep 2001 10:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273109AbRI0OeK>; Thu, 27 Sep 2001 10:34:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26375 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273108AbRI0Odz>; Thu, 27 Sep 2001 10:33:55 -0400
Date: Thu, 27 Sep 2001 16:34:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
Message-ID: <20010927163421.C23647@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010926101914.A28339@atrey.karlin.mff.cuni.cz> <200109270302.f8R32pl12537@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109270302.f8R32pl12537@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Solution for the filesystem problems:
> >>
> >> 1. at suspend, basically unmount the filesystem (keep the mount tree)
> >> 2. at resume, re-validate open files
> >
> > Wrong solution. ;-).
> >
> > Solution to filesystem problems: at suspend, sync but don't do
> > anything more. At resume, don't try to mount anything (so that you
> > don't replay transactions or damage disk in any other way).
> 
> That is totally broken, because I may mount the disk in between
> the suspend and resume. I might even:
> 
> 1. boot kernel X
> 2. suspend kernel X
> 3. boot kernel Y
> 4. suspend kernel Y
> 5. resume kernel X
> 6. suspend kernel X
> 7. resume kernel Y
> 8. suspend kernel Y
> 9. goto #5
> 
> You really have to close the logs and mark the disks clean
> when you suspend. The problems here are similar the the ones

I can't do that: open deleted files.

> NFS faces. Between the suspend and resume, filesystems may be
> modified in arbitrary ways.

No, you don't want to do that. This is swsusp package, meant to
replace suspend-to-disk on your notebook. If you choose random
notebook, it will allow you to suspend to disk, but not to suspend,
boot X, poweron, boot Y, reboot, boot X.

If you do what you described, you'll corrupt your filesystem. It is
designed that way.
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
