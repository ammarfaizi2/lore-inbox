Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLOSNb>; Sun, 15 Dec 2002 13:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLOSNb>; Sun, 15 Dec 2002 13:13:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:6855 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261409AbSLOSNb>;
	Sun, 15 Dec 2002 13:13:31 -0500
Message-ID: <3DFCC815.3C0010F2@digeo.com>
Date: Sun, 15 Dec 2002 10:21:09 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Octave <oles@ovh.net>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: problem with Andrew's patch ext3
References: <20021215144050.GY12395@ovh.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2002 18:21:18.0598 (UTC) FILETIME=[C30F6260:01C2A466]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Octave wrote:
> 
> Hello Andrew,
> 
> I patched 2.4.20 with your patch found out on http://lwn.net/Articles/17447/
> and I have a big problem with:
> once server is booted on 2.4.20 with your patch, when I want to reboot
> with /sbin/reboot, server makes a Segmentation fault and it crashs.

It works OK here.  Could you please check that the kernel was fully
rebuilt?  Do a `make clean'?  If the kernel was not fully rebuilt
then things will go wrong because a structure size was changed.

There is a locking error in that patch, and it needs revision.  But
that wouldn't explain this crash.

And there is an unrelated use-after-free bug which could cause problems
if the fs runs out of space or inodes.

I'll get some fixes out later today.  It hasn't been a good week.
