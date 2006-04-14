Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWDNN7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWDNN7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 09:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDNN7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 09:59:09 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:44394 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964786AbWDNN7I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 09:59:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aHjmr7YLv8FaXoPBoMh5GTzzUkW3txx61ZZIR/m+Xj4do/uyEsoAqS6Z+Dx2LUcMXveSeOG5q04QKQGSopqkoMfo29xcD/+At1kdHsKmCr6udZJBY2Yr/OtrAcU5dASb4lsBxh+CXUo/D9yv8a6Sn5JYdsBdnkWlv0pLGRc2sdM=
Message-ID: <940be6070604140659q31c45599wf729a47ef25103ee@mail.gmail.com>
Date: Fri, 14 Apr 2006 15:59:07 +0200
From: "Gyorgy Szekely" <hoditohod@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ramdisk driver strange behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i'm trying to use a ramdisk driver (block/rd.c) and experienced some
very strnage behaviour. In brief:
If I set ramdisk_blocksize=512 on the kernel command line, the driver
operates oddly. I execute the following commands in a shell:

mkfs.ext2 /dev/ram0     ~runs fine, no errors
mount /dev/ram0 /mnt/disk    ~doesn't mount the filesystem, can't find
it on device
mkfs.ext2 /dev/ram0     ~runs fine, same as above
mount /dev/ram0 /mnt/disk    ~mounts fine

I have to make exactly this command sequence, to make the fs usable,
eg: mkfs.ext2 twice without trying to mount doesn't work. Once the
mount succeeds everything works fine, i can read/write files,
unmount/remount everything as expected.
I copied the ramdisk contents with dd into a file, and after the first
pass it's all zeros nothing else. Like the first mkfs didn't do
anything.

If I remove the ramdisk_blocksize option from the kernel command line
(defaults to 1024) then all is ok.

Test configs:
Linux 2.6.15.2 x86 (stock kernel.org kernel)
ramdisk config: 4 ramdisks of 1024k

ucLinux 2.6.14 ARM/nommu
ramdisk config: 4 ramdisks of 1024k

George

ps: i'm not subscribet to LKML, please CC me.
