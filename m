Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNN2Z>; Wed, 14 Feb 2001 08:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132185AbRBNN2H>; Wed, 14 Feb 2001 08:28:07 -0500
Received: from ausxc08.us.dell.com ([143.166.99.216]:7857 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S132051AbRBNN1t>; Wed, 14 Feb 2001 08:27:49 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9D0A@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: manfred@colorfullife.com, Michael_E_Brown@Dell.com
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: RE: block ioctl to read/write last sector
Date: Wed, 14 Feb 2001 07:26:47 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have one additional user space only idea:
> have you tried raw-io? bind a raw device to the partition, IIRC raw-io
> is always in 512 byte units.

Steven Tweedie responded to my question about that:

> Raw IO is subject to the same limits as other IO, because
> ultimately it uses the same route through the kernel
> to get to the low-level disk IO drivers.

This was confirmed by my testing.  Reading/writing via /dev/raw/rawX fails
exactly the same way as for /dev/[sh]dX.

> Accessing /dev/sg ought to work fine, but of course it
> places much more load on the application programmer
> and removes a ton of kernel safety-nets.

I believe using ide-scsi would work, but you must pass "hdc=ide-scsi" at
boot time, which isn't a big deal for accessing CD-ROMs, but to be used for
arbitrary disks, makes life much more difficult.  Now all your IDE disks
need to think they're SCSI disks, at least for the boot in which you want to
change the partition table.  I wouldn't want to suggest to customers that
they run this additional layer of abstraction all the time just in case they
want to examine and/or change the partition table of just one disk at some
time.

Thanks,
Matt

-- 
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


