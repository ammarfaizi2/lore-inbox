Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSKCV5A>; Sun, 3 Nov 2002 16:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSKCV5A>; Sun, 3 Nov 2002 16:57:00 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:37797 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263280AbSKCV4x>; Sun, 3 Nov 2002 16:56:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 3 Nov 2002 14:03:14 -0800
Message-Id: <200211032203.OAA08254@adam.yggdrasil.com>
To: joe@fib011235813.fsnet.co.uk
Subject: Re: Patch(2.5.45): move io_restrictions to blkdev.h
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, Nov 03, 2002 at 12:48:30AM -0800, Adam J. Richter wrote:
>> 	Great.  The only thing I was going to do that might depend
>> on this patch is try to port /dev/loop to device mapper, and I may
>> be able to eliminate the affected code anyhow.

>This makes me uneasy, do you mean you want to:

>i) make a 'loop' target, if so why ?

	I believe I can eliminate some block device initialization
code and also eliminate some ioctls that allow for a lot of number
configured states for a loop device and bloat loop.c with some
features nobody uses (for example, there is an unused facility to
"name" each loop device).  I would like to invent as little new API as
possible.  Also, of much less importance, adopting this change would
relinquish a major device number.

	I was going to have the map function always return 0 (i.e., it
will submit the IO itself).  Given device-mapper with linear mapping,
I don't think anyone will need to use loop just to map a device to a
device with no data transformation, so there is no need for loop
optimize for that case.

	If you want to point out specific technical problems with this
or have other advice, great.  Otherwise, I expect that just trying to
implement it will either show me some problem with it or will result
in a patch that should clarify what I am talking about for you.

	By the way, one change to DM that might be useful for other
targets as well as loop.c would be to move the map function from
target_type to dm_target.  This can potentially be used to eliminate
some branches in the IO path based on configuration options that were
passed to the constructor function.  For loop.c, I am thinking of
file backed versus device backed.  I could also imagine raid schemes
that might optimize their map functions differently for different
segment sizes.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
