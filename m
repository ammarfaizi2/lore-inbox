Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318298AbSGWUrn>; Tue, 23 Jul 2002 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSGWUrn>; Tue, 23 Jul 2002 16:47:43 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:21755 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318298AbSGWUrE>; Tue, 23 Jul 2002 16:47:04 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 23 Jul 2002 14:48:33 -0600
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-critical ext3-fs errors?
Message-ID: <20020723204833.GR25899@clusterfs.com>
Mail-Followup-To: Ed Sweetman <safemode@speakeasy.net>,
	linux-kernel@vger.kernel.org
References: <1027456090.1982.28.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027456090.1982.28.camel@psuedomode>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 23, 2002  16:28 -0400, Ed Sweetman wrote:
> I notice these errors every now and then on my 100GB WD drive
> (partitioned into bits) and particularly on this partition that I
> compile everything on.   
> 
> EXT3-fs error (device ide0(3,7)): ext3_readdir: bad entry in directory
> #17821: directory entry across blocks - offset=24, inode=17822,
> rec_len=4076, name_len=3 

This is definitely a bad entry - offset + rec_len (4100) != blocksize (4096).
Strange.  You need to run e2fsck -f on this partition.  It sounds like
you are getting some corruption or bit flips happening.

> Now these errors dont cause the system to panic like other ext3 errors
> do, so i'm wondering what the significance of these errors are.

Well, this is an error, and the next time the computer is restarted it
should force a full fsck on the partition.  The other "panic" (oops)
situations are when things are totally shot and it is better to stop
doing anything than try and continue.  In this case, it is possible to
continue, but that doesn't mean things are OK.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

