Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWBGXFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWBGXFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWBGXFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:05:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60815 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030236AbWBGXFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:05:34 -0500
Date: Wed, 8 Feb 2006 00:05:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207230510.GF2753@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602071105.45688.nigel@suspend2.net> <200602071609.05676.rjw@sisk.pl> <200602080814.02894.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080814.02894.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > # cat /sys/power/disk_method
> > > swsusp uswsusp suspend2
> > > # echo uswsusp > /sys/power/disk_method
> > > # echo > /sys/power/state
> > > 
> > > Is there a big problem with that, which I've missed?
> > 
> > Userland suspend is driven by the suspending application which only calls
> > the kernel to do things it cannot do itself, like freezing (the other)
> > processes, snapshotting the system etc.  We use the /dev/snapshot
> > device and the ioctl()s in there, so no sysfs files are needed for that.
> > It's independent and can coexist with the existing sysfs interface
> > just fine.
> 
> Yes, but how are you going to get it started from (say) klaptop, which only 
> knows "echo disk > /sys/power/state" as the way of starting a suspend? I'm 
> suggesting that we create a means whereby the issue of how to start a 
> cycle could be separated from what implementation is used to do the work. 
> That is, a simple extension at the start of the disk specific code that 
> starts swsusp, uswsusp or suspend2 depending upon what you want. Maybe I 
> should just prepare a patch.

Please do not patch kernel for that.

Proper solution is probably creating s2disk program/script, and teach
kpowersave/klaptop/etc. to just use it. Then s2disk can detect best
method to use ... and then just do it. You already have suitable
script, but I'm not sure what its name is.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
