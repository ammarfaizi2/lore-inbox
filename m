Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbSJQVva>; Thu, 17 Oct 2002 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262244AbSJQVva>; Thu, 17 Oct 2002 17:51:30 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:34286 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262240AbSJQVv2>; Thu, 17 Oct 2002 17:51:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 17 Oct 2002 15:55:05 -0600
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: statfs64 missing
Message-ID: <20021017215505.GB14989@clusterfs.com>
Mail-Followup-To: Steven French <sfrench@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <OF6D978045.B4B59726-ON87256C55.006F1ED5@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6D978045.B4B59726-ON87256C55.006F1ED5@boulder.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2002  15:28 -0500, Steven French wrote:
> With big SAN based arrays of disks running under some of the high end
> CIFS based server appliances from EMC, NetApp etc. it would not be
> surprising to me to see an overflow problem for the 32 bit statfs fields
> today (mapping from the values in the FILE_SYSTEM_INFO returned by the
> server to statfs struct on i386 clients) unless the local fs lies
> about the block size.   For the cifs vfs adding a statfs64 func would
> certainly be technically feasible from the protocol's perspective and
> pretty easy.

Yes, I hit this problem a month or two ago with Lustre - the 90TB
filesystem we are testing on wrapped and I thought it was a problem
in our code until I did some more digging.  However, lying about
the blocksize isn't a big loss, since we prefer 64kB vector page I/O
over the network anyways for performance reasons, even though the
backing stores actually use 4kB blocksize.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

