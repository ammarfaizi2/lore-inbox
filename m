Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUAHQ3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265519AbUAHQ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:29:41 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:33178 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S265481AbUAHQ2z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:28:55 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Thu, 8 Jan 2004 10:27:42 -0600 (CST)
Message-Id: <200401081627.i08GRgZ0000027670@mudpuddle.cs.wustl.edu>
To: gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
Subject: x86_64 + 2.6.1-rc3 panics on aic79xx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The default scsi driver for the adaptec 39320 (aic79xx) v 1.3.11
STILL causes panics and BUG halts when a drive decides to have troubles.
I have a 2.6.1-rc3 X86_64 kernel, with
ftp://ftp.x86-64.org/pub/linux/v2.6/x86_64-2.6.1rc2-1.bz2

applied. On the first scsi error, the kernel bughalts "BRKADRINT".
The 2.0.5 version of the aic79xx driver will not boot with the
x86-64 patch, regardless of the iommu=[off | nomerge | noforce] setting.

If I use a vanilla 2.6.1-rc3 kernel, and apply the 2.0.5 driver,
the system will not boot, stalling with a scsi0: Unexpected SEQINTCODE 26 (bad scb).
If I disable the iommu, (iommu=off), then the kernel will boot, but the
system does not work, as the TG3 Gig-E driver is 32 bit.

When the 2.6.1-rc3 + x86_64 patch ran, the I/O throughput on
raid0 was 50% of the 2.6.0 stock kernel (340-360 MB/Sec vs 670-880 MB/Sec).
The ioctl to change /dev/md0 read ahead parameter is being called.
There were some changes to the read ahead values (at least raid5) in
-rc3. Ouch!

	A pure stock 2.6.1-rc3 kernel also bug halts with sg corruption
on the first scsi retry. It seems that the iommu has serious issues
with all three variants of  current kernel patches.

berkley
