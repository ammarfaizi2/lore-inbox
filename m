Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265124AbSJPP5O>; Wed, 16 Oct 2002 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbSJPP5O>; Wed, 16 Oct 2002 11:57:14 -0400
Received: from ns0.cobite.com ([208.222.80.10]:2827 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S265124AbSJPP5N>;
	Wed, 16 Oct 2002 11:57:13 -0400
Date: Wed, 16 Oct 2002 12:02:29 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: raid subsystem broken in 2.5.43... blockdev changes?
Message-ID: <Pine.LNX.4.44.0210161153420.2876-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al, list,

I think the latest blockdev (maybe the do_open) changes broke the raid
subsystem.  In order to 'activate' a raid device, the userland tools open
the device node (e.g. /dev/md0) to perform ioctls against it, even though
that device isn't up and running yet.  In 2.5.43 it returns ENXIO.

In 2.5.42 we used to get through to bdev->bd_op->open() without a 
'gendisk' structure, but now we bail with ENXIO.  Is this the pertinent 
difference?

David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

