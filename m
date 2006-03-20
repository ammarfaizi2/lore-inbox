Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWCTIaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCTIaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 03:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCTIaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 03:30:25 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33429 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932218AbWCTIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 03:30:17 -0500
Date: Mon, 20 Mar 2006 09:30:14 +0100
From: Sander <sander@humilis.net>
To: Dan Aloni <da-x@monatomic.org>
Cc: Sander <sander@humilis.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
Message-ID: <20060320083014.GA12067@favonius>
Reply-To: sander@humilis.net
References: <20060308194627.GA22346@localdomain> <20060316101630.GA14179@favonius> <20060316130400.GA20796@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316130400.GA20796@localdomain>
X-Uptime: 14:11:09 up 15 days, 18:21, 32 users,  load average: 4.47, 5.47, 6.56
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote (ao):
> On Thu, Mar 16, 2006 at 11:16:30AM +0100, Sander wrote:
> > Dan Aloni wrote (ao):
> > > With the patch below I've managed to stabilize the sata_mv driver
> > > running a Marvell 5081 SATA controller.
> > 
> > Your patch (applied to 2.6.16-rc6) seems to work on the MV88SX6081
> > too. I have two Maxtor disks connected and in a raid0 configuration.
> > The array is both fast and stable. I see no error messages in dmesg
> > and no data corruption.
> 
> I take it that without the patch this particular configuration didn't
> work?
 
No, that was raid5 only.

Now I tried to test as much of the configuration that did not work for
me. The current testsystem is a bit different from the original though,
as that was with Maxtor Pro 500 disks, and the current one Maxtor
MaxLine10 disks. Also the kernel was 2.6.16-rc3, and now is 2.6.16-rc6.

I do:

mdadm -C -l5 -n8 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 \
/dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1

mke2fs -j -m1 /dev/md0

mount -o data=writeback /dev/md0 /mnt

for i in `seq 10`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
done
md5sum bigfile.*
rm bigfile.*

With plain 2.6.16-rc6 the system crashes during one of the md5sums, most
of the time the first or the second file. I've lost the last line on
netconsole, but will reproduce with 2.6.16.

With 2.6.16-rc6 and your sata_mv patch the system also crashes during
one of the md5sums, most of the time the first or the second file. There
is no output on netconsole.

2.6.16-rc6-mm2 seems to work, which I did not expect..

-- 
Humilis IT Services and Solutions
http://www.humilis.net
