Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbSAAUS7>; Tue, 1 Jan 2002 15:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbSAAUSu>; Tue, 1 Jan 2002 15:18:50 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:44787 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283783AbSAAUSh>;
	Tue, 1 Jan 2002 15:18:37 -0500
Date: Tue, 1 Jan 2002 13:18:17 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Clausen <clausen@gnu.org>
Cc: linux-kernel@vger.kernel.org, bug-parted@gnu.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] userspace discovery of partitions
Message-ID: <20020101131817.J12868@lynx.no>
Mail-Followup-To: Andrew Clausen <clausen@gnu.org>,
	linux-kernel@vger.kernel.org, bug-parted@gnu.org,
	evms-devel@lists.sourceforge.net
In-Reply-To: <20020102055735.C472@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020102055735.C472@gnu.org>; from clausen@gnu.org on Wed, Jan 02, 2002 at 05:57:35AM +1100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 02, 2002  05:57 +1100, Andrew Clausen wrote:
> As discussed a while ago (see thread starting at
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.2/0659.html), I
> wrote a frontend to libparted that does nothing but probe all
> block devices for partition tables, and tells the kernel what
> partitions it finds.  It optionally prints a short summary.

This would mesh nicely with the filesystem (and other content) probing
tool/lib that I wrote, blkid.  It probes filesystem types (and also
label, uuid, fs size for common fs types).

> The hope is to be able to remove partition table parsing from the
> kernel, and share partition table code with libparted.
> 
> It's called partprobe, and is distributed with Parted.  Get it from:
> 
> 	ftp.gnu.org/gnu/parted/devel/parted-1.5.6-pre2.tar.gz
> 
> When partprobe/libparted are compiled with --enable-discover-only
> --disable-nls etc (see README), it comes to about 73k (35k
> compressed), not including libc or libuuid.  Unfortunately, this is
> still quite large to be including in things like initramfs.  Is
> it worth paying this price?

Hmm, it does seem a bit large for what it is doing.  Any idea where
the bloat is coming from?

My blkid lib is 34kB (uncompressed) and supports 23 filesystem types
(all that the current mount(8) has), although only a handful have full
LABEL and UUID support.  The user tool is 6.5kB and I also use libuuid.so.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

