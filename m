Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSDQSee>; Wed, 17 Apr 2002 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSDQSed>; Wed, 17 Apr 2002 14:34:33 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:22011 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312410AbSDQSed>; Wed, 17 Apr 2002 14:34:33 -0400
Date: Wed, 17 Apr 2002 12:33:01 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Marc-Christian Petersen <m.c.p@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
Message-ID: <20020417183301.GP20464@turbolinux.com>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020417170758.8070026884@smtp.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2002  19:31 +0200, Marc-Christian Petersen wrote:
> your patch does not work:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=balloc  -c -o 
> balloc.o balloc.c
> balloc.c: In function `ext2_new_block':
> balloc.c:524: warning: long unsigned int format, unsigned int arg (arg 4)

OK, minor error there - "tmp" is an int in ext2_new_block, while "block"
is a long in ext2_free_blocks (I had changed it to a long in my tree and
didn't see the warning when it compiled).  I should probably submit a
patch at some point, but for now 32 bits is enough.

> balloc.c:397: label `io_error' used but not defined
> balloc.c:383: label `out' used but not defined

??? My patch doesn't touch nor use these labels.

> gcc: Internal compiler error: program cc1 got fatal signal 11

??? This is pretty bad - usually signal 11 from GCC means RAM problems.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

