Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313084AbSC0TTM>; Wed, 27 Mar 2002 14:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313082AbSC0TSy>; Wed, 27 Mar 2002 14:18:54 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:39416 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313078AbSC0TSl>; Wed, 27 Mar 2002 14:18:41 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 27 Mar 2002 12:17:19 -0700
To: lkml <linux-kernel@vger.kernel.org>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [patch] speed up ext3 synchronous mounts
Message-ID: <20020327191718.GY21133@turbolinux.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>
In-Reply-To: <3C9E4A18.7DDC68AB@zip.com.au> <20020327190731.GA12677@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2002  20:07 +0100, Matthias Andree wrote:
> On Sun, 24 Mar 2002, Andrew Morton wrote:
> > Again, we don't need to sync indirects as we dirty them because
> > we run a commit if IS_SYNC(inode) prior to returning to the
> > caller of write(2).
> 
> Will this help synchronous NFS writes, at least a little? I have slow
> write performance on "sync" NFSv3 exports (ext3 underneath, you guessed
> it), kernel 2.4.19-pre3-ac4 (not really surprising, sync is slow ;-). Is
> it worth a try?

Are you mounting the ext3 filesystem with "data=journal" and have a
large journal?  This will help a lot.  You can also set up an external
journal device to speed things up.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

