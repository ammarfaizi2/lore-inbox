Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVBGCsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVBGCsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 21:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBGCsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 21:48:20 -0500
Received: from zeus.bragatel.pt ([217.70.64.253]:8412 "HELO mail.bragatel.pt")
	by vger.kernel.org with SMTP id S261329AbVBGCsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 21:48:15 -0500
Date: Mon, 7 Feb 2005 02:48:00 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207024800.GA18010@hobbes.itsari.int>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu> <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk> <20050207004218.GA12541@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; Format=Flowed; DelSp=Yes; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050207004218.GA12541@ojjektum.uhulinux.hu> (from pozsy@uhulinux.hu on Mon, Feb 07, 2005 at 00:42:18 +0000)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005.02.07 00:42, Pozsár Balázs wrote:
> On Mon, Feb 07, 2005 at 12:36:10AM +0000, Al Viro wrote:
> > On Mon, Feb 07, 2005 at 12:21:08AM +0100, Pozsar Balazs wrote:
> > > On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
> > > > filesystem detection isn't handled at the kerne level.
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> 
> IIRC currently if both msdos and vfat are compiled in (not modules),  
> and
> 
> you try to mount a vfat filesystem without explicitly specifying the fs
> type, it will be mounted with the msdos type. With the, it will mounted
> vfat.
>


But since filesystem detection isn't handled in the kernel, changing the  
link order is pointless. Please fix your /etc/filesystems instead.

~# grep camera /etc/fstab
/dev/sda1 /mnt/camera auto users,noauto 0 0
~# strace -o mount.trace mount /mnt/camera
~# grep filesystems mount.trace
open("/etc/filesystems", O_RDONLY|O_LARGEFILE) = 3
~# cat /etc/filesystems
ext2
ext3
nodev proc
nodev devpts
iso9660
reiserfs
vfat
udf

Also check man 8 mount, specifically option -t:

[...] Creating a  file /etc/filesystems can be useful to change the probe  
order (e.g., to try vfat before msdos) ...

This is from man-pages 1.66, btw.


Regards,


		Nuno
