Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288760AbSAID0Z>; Tue, 8 Jan 2002 22:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288762AbSAID0G>; Tue, 8 Jan 2002 22:26:06 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:56235 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288761AbSAID0E>; Tue, 8 Jan 2002 22:26:04 -0500
Date: Tue, 8 Jan 2002 20:26:11 -0700
Message-Id: <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Kervin Pierre <kpierre@fit.edu>, linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
In-Reply-To: <20020108200705.S769@lynx.adilger.int>
In-Reply-To: <3C3BB082.8020204@fit.edu>
	<20020108200705.S769@lynx.adilger.int>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Jan 08, 2002  21:52 -0500, Kervin Pierre wrote:
> > I install and used 2.4.17 for about a week before my filesystem 
> > corrupted.  I've tried 'fsck -a' but it complains that there was no 
> > valid superblock found.
> 
> Try "e2fsck -B 4096 -b 32768 <device>" instead.
> 
> > Are there any tools or techniques that will recover data from the 
> > corrupted filesystem even if there isn't a valid superblock?  Or is 
> > there a way to write a temporary superblock so I can access the 
> > information on the disk?
> 
> The ext2 format (includes ext3) has backup superblocks for just this reason.
> 
> > Lastly, if all else fails I'm going to try sending the drive one of 
> > those 'file recovery companies'.  Does anyone have a recommendation for 
> > a particular company?  I'm guessing that there'll be a few that wouldn't 
> > know what to do with a ext3 partition.
> 
> Is the data really that valuable, and you don't have a backup?  It may
> cost you several thousand dollars to do a recovery from such a company.
> Yet, it isn't worth doing backups, it appears.

And these companies don't really do much that you can't do yourself. I
had a failing drive some years ago, where some sectors couldn't be
read. So I tried to dd the raw device to a file elsewhere. Of course,
dd will quit when it has an I/O error. So I wrote a recovery utility
that writes a zero sector if reading the input sector gives an I/O
error. Unfortunately, I couldn't mount the file (too much corruption),
but I was able to use debugfs on it. I got the most important data
back.

While I was waiting for 48 hours for the data to be pulled off (each
time a bad sector was encountered, the drive would retry several
times, with lots of clicking and rattling), I contacted one of these
recovery companies. I wanted to know if they could recover the bad
sectors. I was told no. After some probing, it turns out that all they
do is basically what I was doing. They just charge $2000 for it.

No doubt if you took your drive to your local CIA/KGB/MI6 offices,
they could recover some of those bad sectors. But I hear they charge
their customers quite a lot...

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
