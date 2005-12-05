Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVLESRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVLESRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLESRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:17:12 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:26090
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932491AbVLESRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:17:11 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Mon, 5 Dec 2005 11:58:06 -0600
User-Agent: KMail/1.8
Cc: Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe>
In-Reply-To: <1133800090.21641.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512051158.06882.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 10:28, Lee Revell wrote:
> >
> > Things like this are all too regular an occurance.
>
> The distro should have solved this problem by making sure that the
> kernel upgrade depends on a new wpa_supplicant package.  Don't they
> bother to test this stuff before they ship it?!?

I've broken stuff by upgrading glibc, upgrading X, upgrading KDE...

Upgrading the kernel is safer?  (Anybody remember 2.4.11-dontuse?)

Yay, modular component-based design.  We have standard interfaces so that 
stuff mostly works when you swap out different versions (or entire different 
components).  This is cool.

But if such interfaces were actually sufficient to specify all the 
functionality you actually want to use, why would you ever need to upgrade a 
component implementing that interface to a new version?

The real problem people are seeing is that the rate of change has increased.  
Linus used to be a hell of a bottleneck, and this stopped being the case when 
source control systems took over a lot of the patch tracking, ordering, 
batching, and integration burden.

Automating the patch flow allowed entire subsystems to be effectively 
delegated (and thus the "lieutenants" layer formed and was formalized), and 
each of _them_ is now doing as much work as Linus used to do.

And _that_ is why there is no longer any point in -devel forks, because Linus 
is now fielding as many patches in a month as he used to in a year.  That 
means in every 3 months the Linux kernel undergoes as much development (in 
terms of patches merged and lines of code changed) as an entire -devel series 
used to do.  (Somebody confirm the numbers, these are approximations.)

There's no point in launching a fork that's only expected to last three 
months.  Hence no -devel fork.

Also, forks are cheaper now.  The new source control tools (not just git but 
quilt and ketchup and so on) allow multiple parallel trees to be trivially 
integrated.  It used to take somebody like Alan Cox all his spare time to 
maintain a tree and merge with linus, and back then the -ac tree was very 
special.  Now Con Colivas can maintain a tree in his spare time with a day 
job as an anesthesiologist, and this is _normal_.  There are dozens of trees 
out there feeding into each other, and anybody who wants to can grab the 
relevant subsystem tree and try it out to make sure that the issue they care 
about is fixed, and be assured that it'll all flow in to Linus's tree.

What's special about Linus's tree is that it's the point to the wedge.  This 
is the farthest we've advanced, this is your best bet.  There's always 
something wrong with any piece of software, but half the complaints have 
always been that something is fixed but not merged yet.  (Orinoco scanning, 
ISDN, ALSA, examples are legion.)   That's getting way better.

Now the _new_ class of complaints is that the IPW2200 driver that first got 
merged was too old.  (I noticed this because that's the wireless card in my 
laptop.)  Stop and think about that for a bit.  People were used to IPW2200 
not being there at all, so they could easily add an external patch.  Then 
2.6.14 grew partial IPW2200 support, but with an older driver, and people 
were mad because the external patch they had to add support only applied when 
the driver wasn't there at all, and it didn't apply over the older version.  
They were mad that _insufficient_ support showed up.

This is being fixed in 2.6.15.  It didn't last long.

The new model is that if the kernel has half what you need, you need to come 
up with an incremental patch to get it the rest of the way, and submit that.  
And the up-side is that it'll go in pretty fast now.  Yes, the kernel is 
changing rapidly enough that external patches probably need to be fixed up 
with every new version.  (And if you're using the nvidia driver, this sucks 
rocks.  You were warned.)

The other thing people are complaining about is the deprecation schedule.  
Notice is posted prominently up to a YEAR before a feature gets yanked.  
Apparently, they want to upgrade to the new version when it comes out, but 
don't want to read the instructions for this version (X went away), or the 
warnings about upcoming versions...

Possibly if we had a CHANGES file at the root level of the source mentioning

A) What's new in this version.

B) What's slated for next version (DEPRECATION COMING).

C) What was new in the last version, in case you missed it.

A combination of Documentation/feature-removal-schedule.txt and 
http://wiki.kernelnewbies.org/LinuxChanges, with emphasis on userspace tools 
known to be impacted.

> Lee

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
