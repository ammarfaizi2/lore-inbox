Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSEWBLn>; Wed, 22 May 2002 21:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSEWBLn>; Wed, 22 May 2002 21:11:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:19723
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315481AbSEWBLm>; Wed, 22 May 2002 21:11:42 -0400
Date: Wed, 22 May 2002 18:11:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jon Hedlund <JH_ML@invtools.com>
Cc: sct@redhat.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel - Ext3 & Raid patches
Message-ID: <20020523011144.GA4006@matchmail.com>
Mail-Followup-To: Jon Hedlund <JH_ML@invtools.com>, sct@redhat.com,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <3CEA7866.23557.390B7FFC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 04:40:06PM -0500, Jon Hedlund wrote:
> Last September Stephan told someone on the linux-kernel list that 
> Ext3 and Raid 1 didn't work together on the 2.2 kernel.

I believe that was me.

> Has this been fixed or have I just been lucky?  I've been using ext3 
> on a Raid 1 array of two IBM 75GB ide drives with kernel 2.2.19.  
> Three times in the last 9 months one of the drives reported errors 
> and dropped offline, each time I have fdisked the bad drive, 
> formatted it, fsck'ed it and found no problems, fdisked it again, and 
> raidhotadd'ed it back in and it restored the array without problems.

That test probably won't find the hard drive error, if there is one.

Take the drive offline, run a badblocks write test (the -w option -- danger
it will destroy the data on the disk, but you have a copy on the other RAID
mirror so only run it one one drive directly, not your /dev/md device file)

I doubt that it would be a remapping problem because the drive usually only
reports errors after all of the extra blocks are used up.  

Badblocks does a linear write four times.  If you hear the drive seeking
during those writes there is a good chance that it has remapped some blocks
and the drive will fail sooner than later.

> Two questions:
> 1. Besides the faulty drive, is my data in danger from this software 
> configuration and I've just been lucky or would this configuration not 
> trigger the problems Stephan was warning about?

Yes, avoid this configuration.

> 2. What is the "proper" fix for the patch collision between the raid
> patch and the ext3 patch in /include/linux/fs.h? 

Use 2.4.

> around line 198, it's been working but I don't know enough about the
> code to know if that might mess something else up or not work 
> under some conditions.

If I were you, I'd just test a 2.4 kernel on the configuration you want.
Unless there is some binary driver that use that doesn't support 2.4 there
isn't much use staying with 2.2.

This configuration is unsafe for 2.2, and I've used raid1 and raid5 with
ext3 without any trouble, even on degraded arrays (for as short a period as
possible of course).
