Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKHFUe>; Fri, 8 Nov 2002 00:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261613AbSKHFUe>; Fri, 8 Nov 2002 00:20:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:11262 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261599AbSKHFUd>;
	Fri, 8 Nov 2002 00:20:33 -0500
Message-ID: <3DCB4B2C.989AA22@digeo.com>
Date: Thu, 07 Nov 2002 21:27:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.46: duplicate statistics being gathered
References: <200211080208.gA828nD24150@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 05:27:08.0582 (UTC) FILETIME=[7B68AC60:01C286E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> 
> In addition, this patch removes disk statistics from /proc/stat since
> they are now available via sysfs and there seems to have been a general
> preference in previous discussions to "clean up" /proc/stat.

We really should do this.  It's a question of timing and phasing.

The <unknown quantity of> applications out there which are reading
the disk info from /proc/stat need to be taught to go fishing in
/name-of-the-day-fs.

And that's hard.  /driverfs? /sys? /sysfs? /kernfs?  AFAIK we don't
even have a recommended mountpoint for the thing, do we?  One way
to resolve that is for the monitoring application to locate the
mountpoint by consulting /proc/mounts on startup.

So what do people think?  Do we just peremptorily nuke it and let
the world catch up, or is a more organised migration possible?

Rick, I believe you've hunted down some other apps which are using this
info. sysstat, sar, mpstat, various flavours of iostat.  Where do
we stand on getting those updated?

Thanks.
