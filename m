Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289958AbSAWShQ>; Wed, 23 Jan 2002 13:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289959AbSAWShE>; Wed, 23 Jan 2002 13:37:04 -0500
Received: from [24.64.71.161] ([24.64.71.161]:62961 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289958AbSAWSgy>;
	Wed, 23 Jan 2002 13:36:54 -0500
Date: Wed, 23 Jan 2002 11:36:44 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Chuck Campbell <campbell@neosoft.com>, linux-kernel@vger.kernel.org
Subject: Re: find a file containing a specific sector
Message-ID: <20020123113644.R960@lynx.adilger.int>
Mail-Followup-To: Chuck Campbell <campbell@neosoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020123120055.A14311@helium.inexs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020123120055.A14311@helium.inexs.com>; from campbell@neosoft.com on Wed, Jan 23, 2002 at 12:00:55PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 23, 2002  12:00 -0600, Chuck Campbell wrote:
> If I know the sector and lbasector, can I determine the inode and/or
> the actual file affected?
> 
> The error message is:
> 
> Jan 23 04:24:34 helium kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
> Jan 23 04:24:34 helium kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=4200315, sector=4200248 
> Jan 23 04:24:34 helium kernel: end_request: I/O error, dev 16:01 (hdc), sector 4200248 
> 
> as I said before, the sector number has never changed in months.

If you run 'badblocks /dev/hdc1' it will do a full (read-only by default)
surface scan of the disk and report the bad blocks.  This still doesn't
tell you the filename though.

You can use "debugfs /dev/hdc1" and then "icheck 525031" (assuming
you have a 4kB block ext2/ext3 filesystem on this drive) and then
"ncheck <inum>" for the inode number returned by icheck to find the
filename.

As someone else reported, running "e2fsck -c" will add this block to
the bad blocks list, and re-assign another block for the file in question.
It runs 'badblocks' in the background with the correct parameters (read
only check, correct blocksize for the filesystem).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

