Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965633AbWIRKGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965633AbWIRKGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965634AbWIRKGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:06:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35714 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965633AbWIRKGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:06:09 -0400
Date: Mon, 18 Sep 2006 12:05:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
Message-ID: <20060918100548.GJ3746@elf.ucw.cz>
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505394F.6060806@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Thanks... I got it to work (on 2 the old tree, I was not able to
> >forward-port it), but power savings were not too big (~0.1W, maybe).
> >
> >I'm getting huge (~1W) savings by powering down SATA controller, as in
> >ahci_pci_device_suspend().
> 
> Yeah, it only turns off SATA PHY, so it doesn't result in huge saving. 
> IIRC, it was somewhere around 5 percent on my notebook w/ static 
> linksave mode (turning PHY off on empty port).  But link powersaving 
> introduces virtually no recognizable delay, so it's nice to have.

Yes, any powersavings without cost are a good idea. 

> Can you check if there is any difference between [D/H]IPS and static? 
> ICH6M on my notebook can't do DIPS/HIPS, so I couldn't compare them 
> against static.

What is D/HIPS? I could not find anything relevant..

> >It would be great to be able to power SATA
> >controller down, then power it back up when it is needed... I tried
> >following hack, but could not get it to work. Any ideas?
> 
> 1. One way to do it would be by dynamic power management.  It would be 
> nice to have wake-up mechanism at the block layer.  Idle timer can run 
> in the block layer or it can be implemented in the userland.
> 
> ATM, this implies that the attached devices are powered down too 
> (spindown).  As spinning up takes quite some time, we can implement 

For now, powering down controller when disks are spinned down would be
very nice first step.

When I forced disk to be spinned down (with power/state file)
controller actually survived power down/power up... unfortunately with
so long delay (~30 sec) that it is not usable in practice.

> So, I think option #1 is the way to go - implementing leveled dynamic 
> power management infrastructure and adding support in the block layer. 
> What do you think?

Would be nice :-).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
