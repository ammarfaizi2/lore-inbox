Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSJDR5G>; Fri, 4 Oct 2002 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262927AbSJDR5G>; Fri, 4 Oct 2002 13:57:06 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:4366 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S262924AbSJDR5F>; Fri, 4 Oct 2002 13:57:05 -0400
Subject: Re: FAT/VFAT and the sync flag
From: Scott Bronson <bronson@rinspin.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <87d6qq1an5.fsf@devron.myhome.or.jp>
References: <Pine.LNX.4.33L2.0210032215020.18964-100000@dragon.pdx.osdl.net> 
	<87d6qq1an5.fsf@devron.myhome.or.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Oct 2002 10:57:51 -0700
Message-Id: <1033754272.5296.338.camel@emma>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 08:33, OGAWA Hirofumi wrote:
> You are right. The fatfs just ignore the sync flag.

"Randy.Dunlap" <rddunlap@osdl.org> writes:
> What advantage would implementing sync have for FAT-fs?
> When you unmount a device (before removing it), the filesystem
> is automatically sync-ed (with some possible delay time here to
> perform I/O).  That could provide a quicker unmount, at the
> expense of spreading the device (filesystem) I/O out across
> all device reads/writes over time.  (did that make sense?) ...
> Is there some usage scenario that you are interested in that I am
> just missing?

That made perfect sense.  However, I'm happy with the unmount times. 
I'm worried about ham-fisted users.

When you unplug a VFAT-mounted device from FireWire or USB without
remembering to unmount it first, you get instant file system
corruption.  I've done it a few times myself even though I know better! 
I'm in a hurry, I grab the device, poof!  It's now broken until I can
run fsck.vfat on it and restore missing files.  It's not fun.

If VFAT supported the sync flag, then neglecting to unmount it would not
be so catastrophic.  Well, unless you unplug it in the middle of disk
activity, in which case you're asking for it.  :)

I'd just like Linux to try to avoid dying catastrophically if someone
makes a simple mistake.  Any idea how much effort it would take to add
sync support to VFAT?  Thanks,

    - Scott


