Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSHGDkS>; Tue, 6 Aug 2002 23:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHGDkS>; Tue, 6 Aug 2002 23:40:18 -0400
Received: from vic7-adsl-050.tpgi.com.au ([203.213.71.50]:15013 "EHLO
	coralshark.bluereef.com.au") by vger.kernel.org with ESMTP
	id <S316768AbSHGDkR>; Tue, 6 Aug 2002 23:40:17 -0400
Message-ID: <019501c23dc5$a01493f0$2b01010a@bluereef.local>
From: "Andrew" <temp01@bluereef.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.21 kernel with initrd not loading intermittently
Date: Wed, 7 Aug 2002 13:50:52 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem that I have been wrestling with now for a number of days
with no solution, and I'm hoping someone can help.

I have a stock 2.2.20 kernel with ramdisk and initrd support compiled in.
RAMdisk size is 64MB although I've also tried 32MB and 128MB.
I have tried kernel builds with module support and without (everything
compiled in)
I'm using the latest lilo I can find with the following config:

boot=/dev/hdc
disk=/dev/hdc
 bios=0x80
map=/map
install=/boot.b
backup=/boot.1600
prompt
linear
timeout=50
password=maintenance
restricted
image=/vmlinuz-2.2.20up
        label=test
        ramdisk=65536
        initrd=/rootfs.img
        root=/dev/ram

The server is a uni processor PIII server with 512MB of RAM

The sizes of my rootfs.img and kernel are:
 8713856 Aug  7 12:55 rootfs.img (this is an ext2 compressed image)
 787022 Aug  7 12:17 vmlinuz-2.2.20up (this is a monolithic bzImage kernel)

My problem is that when my kernel loads, sometimes lilo doesn't seem to load
the rootfs.img into RAM for the kernel to find. That is I don't get the
kernel message 'RAMDISK found at 0' message and thus Linux panics with
something like "root file system not found on dev 1:0".

Lilo when building doesn't report any errors in fact it says it successfully
maps the RAMdisk ok

The only trick that I have been able to use to get around it, is to
selectively remove some files OR selectively remove some kernel components
when compiling - but it's not consistent. It almost seems like there is some
finite size limit that my rootfs.img+kernel is greater than that stops the
RAMdisk being loaded or being found if it is infact being loaded.

I have not tried a 2.4 level kernel as I need this to work consistently with
2.2.

Any help much appreciated.

Andrew.


