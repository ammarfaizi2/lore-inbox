Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269805AbUJMUKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269805AbUJMUKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269806AbUJMUKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:10:22 -0400
Received: from danga.com ([66.150.15.140]:45189 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S269789AbUJMUJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:09:48 -0400
Date: Wed, 13 Oct 2004 13:09:47 -0700 (PDT)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
In-Reply-To: <416D8999.7080102@pobox.com>
Message-ID: <Pine.LNX.4.58.0410131302190.31327@danga.com>
References: <Pine.LNX.4.58.0410131204580.31327@danga.com> <416D8999.7080102@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Jeff Garzik wrote:

> Brad Fitzpatrick wrote:
> > I'm reporting an oops.  Details follow.
> >
> > I have two of these machines.  I will happily be anybody's guinea pig
> > to debug this.  (more details, access to machine, try patches, kernels...)
> > Machines aren't in production.
> >
> > - Brad
> >
> >
> > Kernel:  2.6.9-rc4 vanilla (.config below)
> >
> > Hardware:  IBM eServer 325, Dual Opteron 8GB ram (more info below)
> >
> > Pre-crash and crash:
> >
> > a1:~# mke2fs /dev/mapper/raid10-data
> > mke2fs 1.35 (28-Feb-2004)
> > Filesystem label=
> > OS type: Linux
> > Block size=4096 (log=2)
> > Fragment size=4096 (log=2)
> > 25608192 inodes, 51200000 blocks
> > 2560000 blocks (5.00%) reserved for the super user
> > First data block=0
> > 1563 block groups
> > 32768 blocks per group, 32768 fragments per group
> > 16384 inodes per group
> > Superblock backups stored on blocks:
> >         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> >         4096000, 7962624, 11239424, 20480000, 23887872
> >
> > Writing inode tables: 1091/1563
> > Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
> > localhost kernel: Oops: 0000 [1] SMP
> >
> > Message from syslogd@localhost at Wed Oct 13 11:46:01 2004 ...
> > localhost kernel: CR2: 0000000000001770
>
>
> What's your block device configuration?  What block devices are sitting
> on top of what other block devices?

/dev/mapper/raid10-data is a LV taking 200GB of a 280GB VG ("raid10") with
a single PV in it:  /dev/sdb1 -- ips driver, IBM ServeRAID 6M card,
representing a RAID 10 atop 8 SCSI disks.

I just made a new kernel without NUMA and made a filesystem on /dev/sdb1
directly instead of using LVM and it worked fine, if not a little slowly.

Now that I know it /can/ work, I'll try and narrow down whose fault it is:
NUMA or LVM.

- Brad
