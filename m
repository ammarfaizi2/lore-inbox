Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263567AbTCUJa7>; Fri, 21 Mar 2003 04:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263569AbTCUJa7>; Fri, 21 Mar 2003 04:30:59 -0500
Received: from h-64-105-35-91.SNVACAID.covad.net ([64.105.35.91]:54437 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263567AbTCUJa6>; Fri, 21 Mar 2003 04:30:58 -0500
Date: Fri, 21 Mar 2003 01:40:48 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net
Subject: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030321014048.A19537@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	There have been some devfs clean ups in the stock kernels
since 2.5.63, so here is a patch so that people have a version
that applies cleanly:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.65-v12.patch

	There is no change to the optional devfs_helper user level
agent, a reduced-functionality replacement for devfsd (devfsd is not
used under under this version of devfs), available here:

ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/devfs_helper-0.2.tar.gz

	I believe that the only change in this version of devfs is
moving the code to invoke the user level devfs_helper program to a
separate file, fs/devfs/notify.c.  This change will simplify a future
code shrink inspired by David Brownell's suggesting that I think about
unifying hotplug with devfs.  In the future I would like to lift
fs/devfs/notify.c out of devfs so that the code that currently invokes
user level helpers for hot plug events can be replaced with two calls
to a renamed devfs_event() on
/sys/bus/<bustype>/devices/<bus#>/<whatever>, one for insertion and
one for removal.

	This future change would not just be for aesthetics (although
I've worried about potential bugs arising from /sbin/hotplug's
pollution of environment variable name space).  This change would
result in a smaller kernel when both hotplug and devfs are configured,
and, hopefully, a kernel that is no larger when only one or neither
are configured (if neither are configured, the code would not be
compiled in).  It should also shrink the amount of user code need to
support the combination of hotplug and devfs and slightly reduce the
Linux-specific abstractions that system administrators have to track.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
