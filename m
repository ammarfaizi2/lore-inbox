Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUI3Xt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUI3Xt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269624AbUI3Xt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:49:58 -0400
Received: from [193.29.205.125] ([193.29.205.125]:20657 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S269623AbUI3Xth convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:49:37 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Windows Logical Disk Manager error
Date: Fri, 1 Oct 2004 01:49:18 +0200
User-Agent: KMail/1.7
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <200409231254.12287@senat> <1096287833.8148.53.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1096287833.8148.53.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410010149.19951@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Volume3 is a simple one partition volume which is the second LDM
> partition on your other harddisk.  You can just mount that with the vfat
> driver.

Yep, it's working.

> Volume6 is a two partition concatenated volume mad up of partitions sda4
> (109GiB) and sda2 (32kiB!) (in this order!) on the disk you sent me the
> ldm dump from.  You should assemble this as described for Volume2 and
> then mount the created MD device with the ntfs driver.

Maybe I should explain what is my disc layout...
Volume2 is one partition, and Volume6 is mounted as one of its directories, 
something like:

D:\  <- Volume2
D:\download <- Volume6

Volume6 works fine without using software raid though.  Volume2 does not.

> Let me know how it goes.  Both success and failures are interesting to
> me as I do not remember anyone actually having had spanned ldm volumes
> before so it would be nice to know it all works...

I've tried the following:

# mdadm --build /dev/md1 -l linear -n 2 /dev/sda1 /dev/sda3
mdadm: array /dev/md1 built and started.
# mount /dev/md1 /mnt/d
# ls /mnt/d
ls: reading directory /mnt/d: Input/output error

dmesg output:
NTFS volume version 3.1.
NTFS-fs error (device md1): ntfs_readdir(): Actual VCN (0x6e68dc76fa7923) of 
index buffer is different from expected VCN (0x4). Directory inode 0x5 is 
corrupt or driver bug.

-- 
mg
