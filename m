Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRKYWSa>; Sun, 25 Nov 2001 17:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281159AbRKYWSV>; Sun, 25 Nov 2001 17:18:21 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:16891 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281157AbRKYWSL>;
	Sun, 25 Nov 2001 17:18:11 -0500
Date: Sun, 25 Nov 2001 15:17:56 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16-pre1 : e2fsck, File size limit exceeded (core dumped)
Message-ID: <20011125151756.C712@lynx.no>
Mail-Followup-To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C00EEA0.F43E95AA@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C00EEA0.F43E95AA@wanadoo.fr>; from jean-luc.coulon@wanadoo.fr on Sun, Nov 25, 2001 at 02:14:08PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2001  14:14 +0100, Jean-Luc Coulon wrote:
> I've two partitions. /dev/hda1 where I can boot 2.2.20 or 2.4.16-pre1,
> /dev/hda3 with only 2.4.16-pre1.
> 
> Now, if I boot 2.4.16-pre1, I have the following :
> 
> e2fsck 1.25 (20-Sep-2001)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/hda3: 79176/250368 files (1.5% non-contiguous), 277317/500023
> blocks
> File size limit exceeded (core dumped)

This is a kernel bug.  It can be avoided by running as a user with no
filesystem limits.  Note that _any_ call to "ulimit" is currently
broken, especially "ulimit -f unlimited", which will actually impose
a 2GB file limit on the block device.  Remove any "ulimit" statements
from the system startup or root .bash* scripts, and you should be OK.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

