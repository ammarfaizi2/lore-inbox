Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUDSDtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 23:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUDSDtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 23:49:32 -0400
Received: from unthought.net ([212.97.129.88]:53157 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264272AbUDSDta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 23:49:30 -0400
Date: Mon, 19 Apr 2004 05:49:29 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Remi Colinet <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040419034928.GH30687@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Remi Colinet <remi.colinet@free.fr>, linux-kernel@vger.kernel.org
References: <4082819E.10106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4082819E.10106@free.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:24:46PM +0200, Remi Colinet wrote:
> Hi,
> 
> I have 2 questions about disk partitioning under linux 2.6.x :
> 
> 1/ Is it possible to alter a disk partition of a used disk and beeing 
> able to use the modified partition without having to reboot the box?

Not if you want to use DOS partition tables, no.  But read on.

> 2/ Is it possible to delete a disk partition without having the 
> partition numbers changed?

Yes. fdisk will do this.  But read on  :)


Look into LVM.

Really, it solves all the silly problems with partition tables like:
1) requiring reboot after changing table on root disk
2) partition fragmentation
3) partition number limiting
4) the inability to partition SW-RAID devices
5) etc...

And then it adds some real niceties; like being able to span a
"parition" (logical volume) over multiple physical disks, and very
easily adding extra storage (extra disks) into your "storage pool"
(volume group).

Currently, the various distro installers aren't particularly good at (or
even able to) install on LVM - this is changing (the next debian release
seems to be able to do this - dunno about others yet), but this is
currently the only problem that I've seen with LVM.

At home I have a small / on hda1, then I put hda2 (spanning the rest of
hda) into LVM. So, all other filesystems are created on LVM, and I never
need to mock around with the partition table. Works nicely.  This setup
(LVM on top of partition tables) saved me the trouble of figuring out
how to create an initrd properly, but I know others who mount / from LVM
so it's indeed possible.  But for an existing setup like yours, maybe
it's easier to keep / on the partition table and just put the "rest" in
LVM.

And it's not that hard to work with; there's an excellent HOWTO on the
topic. Once you figure out "physical volume", "volume group" and
"logical volume", you know enough to use it.


 / jakob

