Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbSKFFjx>; Wed, 6 Nov 2002 00:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSKFFjx>; Wed, 6 Nov 2002 00:39:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:2734 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265599AbSKFFjw>;
	Wed, 6 Nov 2002 00:39:52 -0500
Message-ID: <3DC8ACAB.8C0DB37D@digeo.com>
Date: Tue, 05 Nov 2002 21:46:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 dirty ext2 mount error
References: <21293.1036560940@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 05:46:20.0235 (UTC) FILETIME=[D50579B0:01C28557]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> The root partition was originally ext3.  fstab now contains
> 
> /dev/sda1               /                       ext2    defaults        1 1
> 
> Booting 2.4.20-rc1 (ext3 as a module, not loaded yet) with a dirty / gets
> 
> EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
> Drop back to 2.4.18 and it works, automatically running fsck.ext2 -a /dev/sda1.
> 

You sure?  That would be a bug in 2.4.18...

ext2 does not know how to mount a needs-recovery ext3 filesystem.  It
is flagged as an incompatible feature (4 -> EXT3_FEATURE_INCOMPAT_RECOVER).

If you run journal replay by mounting it with ext3 or running fsck across
it, then ext2 can mount it.
