Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSGSQho>; Fri, 19 Jul 2002 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSGSQho>; Fri, 19 Jul 2002 12:37:44 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25340 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315631AbSGSQhn>; Fri, 19 Jul 2002 12:37:43 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 19 Jul 2002 10:39:07 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020719163907.GD10315@clusterfs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr> <20020716194542.GD22053@merlin.emma.line.org> <20020716150422.A6254@q.mn.rr.com> <20020716161158.A461@shookay.newview.com> <20020716152231.B6254@q.mn.rr.com> <20020717114501.GB28284@merlin.emma.line.org> <20020717190259.GA31503@clusterfs.com> <20020719102906.A5131@krusty.dt.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719102906.A5131@krusty.dt.e-technik.uni-dortmund.de>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 19, 2002  10:29 +0200, Matthias Andree wrote:
> What kernel version is necessary to achieve this on production kernels
> (i. e. 2.4)?
> 
> Does "consistent" mean "fsck proof"?
> 
> Here's what I tried, on Linux-2.4.19-pre10-ac3 (IIRC) (ext3fs):
> 
> (from memory, history not available, different machine):
> lvcreate --snapshot snap /dev/vg0/home
> e2fsck -f /dev/vg0/snap
> dump -0 ...
> 
> It reported zero dtime for one file and two bitmap differences.

That is because one critical piece is missing from 2.4, the VFS lock
patch.  It is part of the LVM sources at sistina.com.  Chris Mason has
been trying to get it in, but it is delayed until 2.4.19 is out.

> dump did not complain however, and given what e2fsck had to complain,
> I'd happily force mount such a file system when just a deletion has not
> completed.

You cannot mount a dirty ext3 filesystem from read-only media.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

