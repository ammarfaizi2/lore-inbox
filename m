Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTDZQQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbTDZQQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:16:54 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:41110 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261849AbTDZQQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:16:46 -0400
Date: Sat, 26 Apr 2003 12:12:34 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426161233.GE2774@phunnypharm.org>
References: <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr> <20030426143445.GC2774@phunnypharm.org> <20030426161009.GC18917@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426161009.GC18917@vitel.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 06:10:09PM +0200, Stelian Pop wrote:
> On Sat, Apr 26, 2003 at 10:34:45AM -0400, Ben Collins wrote:
> 
> > > And guess what ? The new patch broke (again) my setup. When I plug
> > > in my iPod, the scsi layer does not see it anymore.
> > 
> > Good lord would you calm down.
> 
> No. You did broke the subsystem in several occasions, you do this
> at the bad moment, and now you introduced a change in behaviour
> in a stable kernel release, between -rc1 and -rc2, without any
> warning. I think I have enough reasons to be angry.

IEEE-1394 is marked "EXPERIMENTAL" for a reason. It's not stable. Just
because it exists in a stable kernel doesn't mean the tree adheres to
the same principals. Fixing a crash at the cost of making you run a
simple script for an interim is a likely thing in an EXPERIMENTAL
subsystem. If you would rather hotplug work, at the cost of your system
crashing after two or three reconnects...then maybe you need to be
running some more unstable code.

> > Run the rescan-scan-scsi.sh script floating around. Out own website
> > describes having to use this for 2.4 kernels.
> [...]
> 
> The FAQ on linux1394 site was indeed updated 2 days ago. I'm sorry
> I didn't think to look there.

The rescan-scsi-bus.sh info has been there since sbp2 was introduced
over a year ago.

> > It was either leave sbp2
> > oopsing, or rewrite the load logic so that there was no way for left
> > over scsi cruft. The side affect is that the only hot-plug situation
> > ieee1394 had in 2.4 is gone.
> 
> Strange, usb-storage seems to work quite fine with respect to the
> scsi layer and hotplug...

USB also allocates a template/host for each device. Sorry, but I'm not
about to go that far. Not to mention the callback system in USB is
different than IEEE1394. So the same logic doesn't transfer.

> > Before, loading sbp2 before loading ohci1394 gave the same affect. Now,
> > loading sbp2 before ohci1394 also requires running rescan-scan-scsi.sh.
> > Blame the scsi layer, not me.
> 
> BTW: hotplug removing is still half broken: the hotplug remove event
> is send only when the device is physically disconnected. If I remove
> the sbp2 module with rmmod, I'll get nothing.
> 
> This means that if you do
> 	rmmod sbp2
> 	modprobe sbp2
> your SCSI device will be lost and you'll have to call 'rescan-scsi-bus'
> by hand...

That's what /sbin/hotplug et al are for. If you want dork-free hotplug
in scsi/ieee1394, use 2.5.x.

Look, I'm not going to get pulled into this argument anymore. If you
want to control how ieee1394 is developed, join the list and put up, or
just shut up.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
