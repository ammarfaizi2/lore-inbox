Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264634AbRFPR7w>; Sat, 16 Jun 2001 13:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264637AbRFPR7m>; Sat, 16 Jun 2001 13:59:42 -0400
Received: from po.sakura.ne.jp ([210.155.3.194]:32015 "EHLO po.sakura.ne.jp")
	by vger.kernel.org with ESMTP id <S264634AbRFPR7c>;
	Sat, 16 Jun 2001 13:59:32 -0400
Date: Sun, 17 Jun 2001 02:58:41 +0900
From: Susumu Takuwa <susumu-t@po.sakura.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: max size of initrd image files
Message-Id: <20010617023346.3E4A.SUSUMU-T@po.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have problem about booting Linux by using initrd which
I made originally.I have made original two initrd images,
that have *same* contents, but they have different size. ie,

first, creating image file.
$ dd if=/dev/zero of=/tmp/ramdisk1 bs=1024k count=48
$ dd if=/dev/zero of=/tmp/ramdisk2 bs=1024k count=64

second, copying files of initrd.img which is contained some
distro.
$ gzip -dc /boot/initrd.img > /tmp/initrd
$ losetup /dev/loop1 initrd
$ losetup /dev/loop0 ramdisk(1|2)
$ mount /dev/loop0 /loop0
$ mount /dev/loop1 /loop1
$ cp -a /loop1/* /loop0/

$ losetup -d ...
$ umount ...

$ gzip -c9 ramdisk(1|2) > /boot/ramdisk(1|2).img

third, booting kernel with initrd image under setting kernel
parameter ``ramdisk=131072''. My Linux Box have 384MB RAM
and 2.2.17 kernel.

Well, when I used ramdisk1.img, I could boot kernel with no
problem. But when I used ramdsisk2.img , I could not boot
kernel with following error message.

	RAMDISK: could not determine device size

Is the 64MB initrd image compressed by gzip too big? Can I
solve the problem?


	Susumu Takuwa



