Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSGXAQq>; Tue, 23 Jul 2002 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSGXAQp>; Tue, 23 Jul 2002 20:16:45 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:34220 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315260AbSGXAQp>; Tue, 23 Jul 2002 20:16:45 -0400
Subject: Re: non-critical ext3-fs errors and IDE issues with 2.4.19-rc3
From: Ed Sweetman <safemode@speakeasy.net>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020723204833.GR25899@clusterfs.com>
References: <1027456090.1982.28.camel@psuedomode> 
	<20020723204833.GR25899@clusterfs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 23 Jul 2002 20:19:54 -0400
Message-Id: <1027469995.496.6.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 16:48, Andreas Dilger wrote:
> On Jul 23, 2002  16:28 -0400, Ed Sweetman wrote:
> > I notice these errors every now and then on my 100GB WD drive
> > (partitioned into bits) and particularly on this partition that I
> > compile everything on.   
> > 
> > EXT3-fs error (device ide0(3,7)): ext3_readdir: bad entry in directory
> > #17821: directory entry across blocks - offset=24, inode=17822,
> > rec_len=4076, name_len=3 
> 
> This is definitely a bad entry - offset + rec_len (4100) != blocksize (4096).
> Strange.  You need to run e2fsck -f on this partition.  It sounds like
> you are getting some corruption or bit flips happening.
> 
> > Now these errors dont cause the system to panic like other ext3 errors
> > do, so i'm wondering what the significance of these errors are.
> 
> Well, this is an error, and the next time the computer is restarted it
> should force a full fsck on the partition.  The other "panic" (oops)
> situations are when things are totally shot and it is better to stop
> doing anything than try and continue.  In this case, it is possible to
> continue, but that doesn't mean things are OK.
> 
> Cheers, Andreas

I rebooted after setting max mount count to 1 so it would force and
fsck, I got no error messages.  So, I dropped to shell in single mode
and attempted to unmount /usr (the partition with the issues) but umount
insisted /usr was busy.   I looked at ps, nothing executed from usr. I
looked at my shell, nothing executed on /usr.  I looked at lsof, nothing
showing /usr files being accessed.  It didn't make any sense at all but
then there are other surprises with 2.4.19-rc3 that come later.  I fsck
-f'd the partition again with dma disabled and still, no errors
reported.  Either it fixed them behind the scenes or didn't detect
them.    I then went and looked at my dmesg to notice this interesting
message 

PDC20262: chipset revision 1
ide: Skipping Promise RAID controller.

Now this is funny. I dont remember telling the kernel to skip my other
ide controller.  I double checked the config, nope, no ignoring or
skipping of the promise ide controller.  This did not occur in previous
kernels, it seems to be brand new in rc3.   I confess to having used jam
kernels with rc2 and rc1 though which had other ide patches in it.   So
what gives with this ?   Why is rc3 skipping the promise ide
controller?   And why is fsck not reporting any fixes to errors that
dmesg shows is being detected during use? 



