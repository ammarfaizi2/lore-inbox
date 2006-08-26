Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWHZNYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWHZNYR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 09:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHZNYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 09:24:17 -0400
Received: from soundwarez.org ([217.160.171.123]:19595 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751142AbWHZNYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 09:24:16 -0400
Subject: Re: Status of driver core struct device changes?
From: Kay Sievers <kay.sievers@vrfy.org>
To: Louis Garcia II <louisg00@bellsouth.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1156550000.3120.2.camel@soncomputer>
References: <1155332969.2652.8.camel@soncomputer>
	 <20060812005959.GA25689@kroah.com> <1155357283.19292.3.camel@soncomputer>
	 <20060812161414.GA14182@kroah.com>  <1156550000.3120.2.camel@soncomputer>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 15:24:46 +0200
Message-Id: <1156598686.3597.218.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 19:53 -0400, Louis Garcia II wrote:
> On Sat, 2006-08-12 at 09:14 -0700, Greg KH wrote:
> > On Sat, Aug 12, 2006 at 12:34:43AM -0400, Louis Garcia II wrote:
> > > On Fri, 2006-08-11 at 17:59 -0700, Greg KH wrote:
> > > > On Fri, Aug 11, 2006 at 05:49:29PM -0400, Louis Garcia II wrote:
> > > > > A couple of months ago greg kh started work toward allowing everything
> > > > > to be a struct device in the sysfs device tree. How is this progressing?
> > > > 
> > > > Quite well.  But next time you might want to CC: me as I almost missed
> > > > this message.
> > > > 
> > > > > Any time frame when we will have a simplified driver core api?
> > > > 
> > > > It's getting there.  If you look in -mm there are a lot of subsystems
> > > > already converted over, along with a lot of patches from andrew that
> > > > revert these changes due to udev issues.
> > > > 
> > > > I'm working on fixing up the udev issues so that the kernel work is not
> > > > held up.  That's a bit slower going as it requires me to install a lot
> > > > of different distros...
 
> > > How about block devices? Will it be moved to /sys/class or is that abi
> > > set in stone?
> > 
> > Yes, those will also move, but that's a bit lower on my list of things
> > to do.  Patches to help this out are always welcome.

> With the new code will their be much difference between /sys/class/
> and /sys/devices/? Can one of these go away, preferably /sys/class/?

No, that doesn't make sense. They are two different things and both will
stay.

/sys/device is the kernel device tree, modeled by the stacking of
drivers and subsystems inside the kernel. It expresses the hierarchy and
dependency of devices, but no classification.

/sys/class is the classification/grouping of devices, it will not
express any hierarchy.

In the end, after the transition of directories in /sys/class to
symlinks, /sys/class will only be flat lists of symlinks grouped by
subsytems. The symlinks will point to the actual device locations in
the /sys/devices tree.

Kay

