Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUAGNAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUAGNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:00:41 -0500
Received: from ns.suse.de ([195.135.220.2]:46269 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265315AbUAGNAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:00:38 -0500
Date: Wed, 7 Jan 2004 14:00:36 +0100
From: Olaf Hering <olh@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107130036.GA3186@suse.de>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk> <20040107101559.GA22770@suse.de> <20040107111832.GL4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040107111832.GL4176@parcelfarce.linux.theplanet.co.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 07, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Jan 07, 2004 at 11:15:59AM +0100, Olaf Hering wrote:
> > Now, thats just fine and it was always been that way.
> > What if I chroot into /foo, proc is mounted on /foo/proc,
> > and run fsck /dev/sda3 in that chroot? 
> > That silly app looks for /etc/mtab (oh my...) and start the work.
> > Fine. Now, /dev/root is in reality /dev/sda3. Bad for me.
> 
> Huh?

For short: noone knows that /dev/sda3 is busy/used.

> Note that you're not only adding ad-hackery (which filesystems get that
> major:minor printed and which do not?), you *STILL* hadn't solved your
> problem.  Why?  Because you still won't catch e.g. ext3 on /dev/sda5 with
> external journal on /dev/sda3.  And if you hack parsing ext3 lines in
> /proc/mounts, there's always reiserfs, jfs, etc., etc.  _And_ there's
> RAID with the same problems wrt. access to components.  Real funny
> when you have raid0 on md0, have md0 mounted and try to fsck one of
> components.

That makes sense. Is there a sane way to inform userland apps that some
stuff is used (mounted, part of a volume group or raid)? Sure, the raid
or lvm specific tools will tell you...

> Scanning /etc/mtab or /proc/mounts in such situations is wrong.  If fsck
> is doing that, it's broken.  The right way to fix it depends on what you
> really want and whatever the hell it is, putting new and new fs-specific
> code that would parse /proc/mounts lines into fsck(8) is not an answer.

Ok, it was mkfs.minix and an older distro. But still, is '/dev/root' or
'/dev/fred' really correct?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
