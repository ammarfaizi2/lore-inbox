Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWAVIvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWAVIvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWAVIvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:51:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11164 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751265AbWAVIvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:51:15 -0500
Date: Sun, 22 Jan 2006 09:51:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
In-Reply-To: <43D3295E.8040702@comcast.net>
Message-ID: <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
References: <43D3295E.8040702@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
>USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
>Sure it could be done in 8 or 4 or so; or (in one of my file system
>designs) a static 16KiB block could reference dynamicly allocated
>journal space, allowing the system to sacrifice performance and shrink
>the journal when more space is needed.  Either way, slow media like
>floppies will suffer, HARD; and flash devices will see a lot of
>write/erase all over the journal area, causing wear on that spot.

 - Smallest reiserfs3 journal size is 513 blocks - some 2 megabytes,
   which would be ok with me for a 128meg drive.
   Most of the time you need vfat anyway for your flashstick to make
   useful use of it on Windows.

 - reiser4's journal is even smaller than reiser3's with a new fresh
   filesystem - same goes for jfs and xfs (below 1 megabyte IIRC)

 - I would not use a journalling filesystem at all on media that degrades
   faster as harddisks (flash drives, CD-RWs/DVD-RWs/RAMs).
   There are specially-crafted filesystems for that, mostly jffs and udf.

 - You really need a hell of a power fluctuation to get a disk crippled.
   Just powering off (and potentially on after a few milliseconds) did
   (in my cases) just stop a disk write whereever it happened to be,
   and that seemed easily correctable.


Jan Engelhardt
-- 
