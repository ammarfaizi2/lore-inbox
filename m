Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTLIFEg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 00:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLIFEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 00:04:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59337
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262848AbTLIFEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 00:04:34 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Date: Mon, 8 Dec 2003 23:04:33 -0600
User-Agent: KMail/1.5
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <200312081559.04771.andrew@walrond.org>
In-Reply-To: <200312081559.04771.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312082304.33891.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 09:59, Andrew Walrond wrote:
> On Monday 08 Dec 2003 3:42 pm, William Lee Irwin III wrote:
> > I would say it's deprecated at the very least. sysfs and udev are
> > supposed to provide equivalent functionality, albeit by a somewhat
> > different mechanism.
>
> Thanks for the pointer.
>
> So how good is the device coverage offered by sysfs/udev ? Do they provide
> a viable/complete MAKEDEV replacement yet?

My understanding is that udev takes the information exported by sysfs about 
what devices exist in the system, and creates device nodes in /dev (which can 
be a ramfs mount or part of a persistent filesystem, udev itself doesn't 
care).  I'm guessing it traverses sysfs to see what the system's got on 
startup (some variant of "find /sys -name device", perhaps) and then receives 
hotplug events when new devices are added later.  On the whole, this is 
generally cool, hotplug friendly, and small and simple.  _and_ the result 
looks like a recognizable /dev directory, so end-user applications don't have 
to be "devfs aware" (which was a bad sign from day 1 if you ask me).

Unfortunately, sysfs doesn't yet export device node information for everything 
in the system yet.  (There aren't any under /sys/cdev, /sys/devices/legacy, 
or /sys/devices/system, for example).  There are pending patches to add more, 
but they're not considered bug fixes, so Linus won't take them before 2.6.0 
and we'll have to wait until after 2.6.0 for development on this subsystem to 
finish.

Probably somewhere in the 2.6.4 to 2.6.6 timeframe, sysfs will have all the 
device exports udev needs.  (Or at least all the ones anybody's complained 
about yet.)  Until then...  dunno.  Maybe you can use a /dev directory on a 
persistent filesystem that you mknod any extra devices you need into 
yourself?)

Rob
