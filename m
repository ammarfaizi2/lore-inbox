Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288513AbSADGqa>; Fri, 4 Jan 2002 01:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSADGqU>; Fri, 4 Jan 2002 01:46:20 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:506 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288513AbSADGqI>;
	Fri, 4 Jan 2002 01:46:08 -0500
Date: Thu, 3 Jan 2002 23:45:58 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: farmer dude <farmerduderl@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dd failure odd sectors, block addressing of 1024 question
Message-ID: <20020103234558.K12868@lynx.no>
Mail-Followup-To: farmer dude <farmerduderl@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020104054648.77014.qmail@web14311.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020104054648.77014.qmail@web14311.mail.yahoo.com>; from farmerduderl@yahoo.com on Thu, Jan 03, 2002 at 09:46:48PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 03, 2002  21:46 -0800, farmer dude wrote:
> I have a question regarding the use gnufileutils 'dd'
> wherein it fails to image completely in certain
> circumstances.  I've tossed this around a bit, and so
> far the best answer seems to be not a DD problem, but
> rather block addressing within the kernel itself
> (currently it is 1024bytes???).  Someone has suggested
> I post to this list to see a) if this is a known issue
> and/or b) what is being done to correct it (say,
> changing to 512bytes for example)?

Yes, this is a long standing and well known issue with Linux.  As you
mention later in your email, this does not affect Linux directly, because
it never uses the last sector of odd-sized disks or partitions.  The only
place it has been noticed is with the Linux NTFS driver (which is unable
to store the MFT backup in the last sector of the partition) and the NT
LDM driver which breaks when odd-sized volumes are concatenated together
(one sector is missing out of the middle of the volume).

> Also, why would *BSD not puke on this same scenario?

Because BSD != Linux, they do not really have any code in common.

> Source disk setup:	Windows 2000 with NTFS & Fat32
> Disk: E4 N   Start LBA Length    Start C/H/S End C/H/S
>   boot Partition type  1 P 000000063 006152832
> 0000/001/01 0382/254/63 Boot 0B Fat32  2 X 008193150
> 009735390 0510/000/01 1023/254/63      0F extended  4
> x 002056320 001237005 0638/000/01 0714/254/63      05
> extended  5 S 000000063 001236942 0638/001/01
> 0714/254/63      07 NTFS  6 x 005349645 001638630
> 0843/000/01 0944/254/63      05 extended  7 S
> 000000063 001638567 0843/001/01 0944/254/63      17
> other  8 x 008498385 001237005 1023/000/01 1023/254/63
>      05 extended  9 S 000000063 001236942 1023/001/01
> 1023/254/63      1B other  	

You may want to use an email program which doesn't screw up the
formatting so badly, not that it really matters in this case.

In the end, this has been discussed several times on l-k, and while
people have expressed a desire to fix it, it has never been done.
This is probably because anyone who knows enough about Linux to fix
it uses Linux all the time, and at that point they don't need to fix
it anymore...

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

