Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVC3JGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVC3JGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 04:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVC3JGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 04:06:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32187 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261816AbVC3JGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 04:06:36 -0500
Date: Wed, 30 Mar 2005 11:06:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jim Carter <jimc@math.ucla.edu>
Cc: linux-kernel@vger.kernel.org, hare@suse.de, seife@suse.de
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <20050330090624.GA572@elf.ucw.cz>
References: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us> <20050325081438.GA17245@elf.ucw.cz> <Pine.LNX.4.61.0503271623150.5513@xena.cft.ca.us> <20050328221922.GD1389@elf.ucw.cz> <Pine.LNX.4.61.0503291724030.7677@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503291724030.7677@xena.cft.ca.us>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You insmod driver for your swap device, then you echo device numbers
> > to /sys... then initiate resume.
> 
> So you're saying, let the machine come all the way up, log in as root, 
> "echo 8:5 > /sys/power/resume" (I think that was the name), then "echo 
> resume > /sys/power/state"?  Hmm, you would have to bypass "swapon -a",
> e.g. boot with the -b kernel parameter.  

Well, basically yes, but do that without any writing to filesystem, or
it is "bye bye data".

> Or I'll bet one could do something equivalent in the initrd -- much more 
> user friendly.  But the friendliest of all would be if the swsusp resume 
> call were not a late_initcall but rather were called just before the root 
> was mounted, after the initrd (if any) had loaded whatever modules.  I 
> think you're confirming that that approach would not blow up the kernel -- 
> if it will work with the root mounted and user space in full roar (well, 
> skimpy roar with the -b switch), then it's got to be OK at the earlier 
> time.

You do not want to mount journaling filesystems; they tend to write to
disks even during read-only mounts... But doing it from initrd should
be okay. ext2 and init=/bin/bash should do the trick, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
