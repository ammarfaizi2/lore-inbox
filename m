Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSGYHas>; Thu, 25 Jul 2002 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSGYHas>; Thu, 25 Jul 2002 03:30:48 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:41459 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317639AbSGYHaq>; Thu, 25 Jul 2002 03:30:46 -0400
Date: Thu, 25 Jul 2002 01:32:21 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Header files and the kernel ABI
Message-ID: <20020725073221.GP574@clusterfs.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <aho5ql$9ja$1@cesium.transmeta.com> <20020725065109.GO574@clusterfs.com> <3D3FA3B2.9090200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3FA3B2.9090200@zytor.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 2002  00:07 -0700, H. Peter Anvin wrote:
> Andreas Dilger wrote:
> >The kernel side would be something like <linux/scsi.h> includes
> ><linux/abi/scsi.h> or whatever, but in the future this can be included
> >directly as needed throughout the kernel.  The existing kernel
> ><linux/*.h> headers would also have extra kernel-specific data in them.
> >
> >The same could be done with the user-space headers, but I think that
> >is missing the point that the linux/abi/*.h headers should define _all_
> >of the abi, so we may as well just use that directly.
> 
> Except now the paths are gratuitously different between kernel 
> programming and non-kernel programming, and we create a much harder 
> migration problem.  I'd rather leave the linux/* namespace to the 
> user-space libc to do whatever backwards compatibility cruft they may 
> consider necessary, for example, <linux/io.h> might #include <sys/io.h> 
> since some user space apps bogusly included the former name.  Leaving 
> that namespace available for backwards compatibility hacks avoids those 
> kinds of problems.

OK, but essentially then <linux/io.h> will be mostly a hollow shell
which includes <linux/abi/io.h> and maybe a couple other files
(e.g. <linux/abi/types.h> or similar).  If so, then great.

That brings up the question - how do you tie a particular
<linux/abi/*.h> to a particular kernel?  Should there be a bunch of
directories <linux/abi-2.4/*.h> and/or <linux/abi-2.4.12/*.h> and/or
<linux/abi-`uname -r`/*.h> or what?  While there are efforts to keep
the ABI constant for major stable releases, this is not always true,
so abi-2.4 will certainly not be enough.  Maybe linux/abi is a symlink
to the abi directory of currently running kernel?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

