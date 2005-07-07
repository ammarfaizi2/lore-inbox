Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVGGTNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVGGTNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVGGTK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:10:56 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:4878 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262074AbVGGTKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:10:31 -0400
Message-ID: <42CD7E0C.3060101@tuxrocks.com>
Date: Thu, 07 Jul 2005 13:10:04 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: knobi@knobisoft.de
CC: abonilla@linuxwireless.org, "'Pekka Enberg'" <penberg@gmail.com>,
       linux-kernel@vger.kernel.org, axboe@suse.de,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       hdaps-devel@lists.sourceforge.net
Subject: Updating hard disk firmware (Was: Re: Head parking)
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
In-Reply-To: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin Knoblauch wrote:
>  Download is simple, just don't use the "IBM Download Manager". Main
> problem is that one needs a bootable floopy drive and "the other OS" to
> create a bootable floppy. It would be great if IBM could provide floppy
> images for use with "dd" for the poor Linux users.

You may be able to use this process to avoid using either a floppy drive
or "the other OS":

1) Download the appropriate firmware exe from
http://www-306.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-41008
(in my case, this looks like fwhd3313.exe)

2) Find a freedos disk image (I used one that came with biosdisk -
http://linux.dell.com/biosdisk/)

3) Create a disk image for the firmware executable:
cp /usr/share/biosdisk/dosdisk.img /tmp/fwdisk1.img
mount -oloop /tmp/fwtemp.img /mnt/tmp
cp fwhd3313.exe /mnt/tmp
umount /mnt/tmp

4) Create a blank disk image for the extracted contents:
dd if=/dev/zero of=/boot/fwdisk.img bs=1474560 count=1

5) Run qemu to extract files and write the disk image:
qemu -fda /tmp/fwtemp.img -fdb /boot/fwdisk.img
A:\>fwhd3313
...
exit qemu

6) Set up grub to boot the new disk image (requires memdisk from
syslinux - http://syslinux.zytor.com/):
$EDITOR /boot/grub/grub.conf
title IBM Hard Drive Firmware update
        kernel /memdisk
        initrd=/fwdisk.img floppy

7) Reboot and select the "IBM Hard Drive Firmware update" option


It allowed me to run the firmware update program, however it didn't
believe my drive needed updating, so I haven't even successfully tried
the entire process.  Please let me know if it works for you.

DISCLAIMER: I also provide no guarantees.   Hopefully your hard disk
won't fly off the spindle or anything else bad.  If it does, blame
someone else.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCzX4MaI0dwg4A47wRAnXUAKCEsQQSj4aHkwMr8vZLei23+DhUuwCfb1Mb
NTmyLHJDa602Iex/QAr/N2I=
=fexM
-----END PGP SIGNATURE-----
