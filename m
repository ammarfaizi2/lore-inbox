Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUGDOeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUGDOeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 10:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUGDOeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 10:34:50 -0400
Received: from smtp06.web.de ([217.72.192.224]:10658 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S265697AbUGDOes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 10:34:48 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org, aebr@win.tue.nl
Content-Type: multipart/mixed; boundary="=-LYHOATzolPQl0LhCUgoh"
Date: Sun, 04 Jul 2004 14:34:55 +0000
Message-Id: <1088951695.596.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LYHOATzolPQl0LhCUgoh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > The recent changes in 2.6.7-bk15 broke FAT support. I am doing some
> > rescue backup systems here using tools like syslinux and mtools to
> > format a normal msdos disk (for el-torito). I figured out that after
> > creating and formating of these disks that it is impossible to mount
> > them with 'msdos' or 'vfat'.

> You may be able to check for yourself precisely which change caused
> trouble for you. The only very recent change is one that makes the
> kernel more permissive.

> Give details on what versions work for you, what versions don't.
> Give the exact error messages. Give the first few sectors of the
> filesystem that you cannot mount but can mount with an earlier kernel.

Ok after some further research I figured this out. My last working
version of the Linux Kernel was 2.6.7 which worked with my rescue
system. I now applied the bk* patches upwards to check which one caused
the issue and I figured that this happened between bk3 to bk4 (so the
problem occoured with the bk4 patch). The diskimage was created with
mtools 3.9.9 and worked perfectly before.

export MTOOLSRC=".mtools.conf"
echo "drive a: file=\"/tmp/bootflop.img\" mformat_only" > .mtools.conf
dd if=/dev/zero of=/tmp/bootflop.img count=5760 bs=512
mformat -t 80 -h 2 -s 36 A:
rm .mtools.conf

The diskimage was created that way for countless months without any
problems. You find the image as attachment. After bunzip'ing it you
receive a 2,88 mb file (don't worry about the tiny size now) with the
md5sum: dc27cfe332cf96238e80d148c9955b9e

--=-LYHOATzolPQl0LhCUgoh
Content-Disposition: attachment; filename=bootflop.img.bz2
Content-Type: application/x-bzip; name=bootflop.img.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWZaHrNQAWpv+//boGSBEITkkIweHABAEQAFAAAIQAHnAAkBAABhIHLAAubYpBpPU
9JgmhiYJ6ExMm1DNTwhFPSRjU9CaYhpgJpjQaamENMEUqnomCYmGgmBMTANBMBik8FWJ0FaAA9Qq
ACKRIoKCKZoTRAKIIp/bpcNUnhZi5HWbjJ35/VKciiCKPC1j2VDgPEQQIFENCgLah/RIRWLGRH+q
80B9U4JNzTl0SLSwg+fEhrDECM7IUo1UfVfDS8rNaBAXA1/UoiVr9l5AAEIgikvgmPYu5IpwoSEt
D1mo


--=-LYHOATzolPQl0LhCUgoh--

