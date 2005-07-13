Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVGMI6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVGMI6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGMI6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:58:30 -0400
Received: from [213.211.174.11] ([213.211.174.11]:7875 "EHLO
	waterstof.hillenius.net") by vger.kernel.org with ESMTP
	id S261361AbVGMI6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:58:30 -0400
To: Frank Sorenson <frank@tuxrocks.com>
Cc: hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Updating hard disk firmware & parking hard disk
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com>
	<42CD7E0C.3060101@tuxrocks.com>
From: Gijs Hillenius <gijs@hillenius.net>
Organization: Responsible
X-Operating-System: Debian GNU/Linux Sid
X-GPGP-Fingerprint: 0D0B 9C67 0520 3B27 A91C  369B 7154 1B0A 04CF 3929
Date: Wed, 13 Jul 2005 10:58:19 +0200
In-Reply-To: <42CD7E0C.3060101@tuxrocks.com> (Frank Sorenson's message of "Thu, 07 Jul 2005 13:10:04 -0600")
Message-ID: <878y0bozf8.fsf@hillenius.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Frank Sorenson writes:

     > Martin Knoblauch wrote:
    >> Download is simple, just don't use the "IBM Download
    >> Manager". Main problem is that one needs a bootable floopy
    >> drive and "the other OS" to create a bootable floppy. It would
    >> be great if IBM could provide floppy images for use with "dd"
    >> for the poor Linux users.

     > You may be able to use this process to avoid using either a
     > floppy drive or "the other OS":

     > 1) Download the appropriate firmware exe from
     > http://www-306.ibm.com/pc/support/site.wss/document.do?lndocid=MIGR-41008
     > (in my case, this looks like fwhd3313.exe)

     > 2) Find a freedos disk image (I used one that came with
     > biosdisk - http://linux.dell.com/biosdisk/)

     > 3) Create a disk image for the firmware executable: cp
     > /usr/share/biosdisk/dosdisk.img /tmp/fwdisk1.img mount -oloop
     > /tmp/fwtemp.img /mnt/tmp cp fwhd3313.exe /mnt/tmp umount
     > /mnt/tmp

     > 4) Create a blank disk image for the extracted contents: dd
     > if=/dev/zero of=/boot/fwdisk.img bs=1474560 count=1

     > 5) Run qemu to extract files and write the disk image: qemu
     > -fda /tmp/fwtemp.img -fdb /boot/fwdisk.img A:\>fwhd3313 ...
     > exit qemu

     > 6) Set up grub to boot the new disk image (requires memdisk
     > from syslinux - http://syslinux.zytor.com/): $EDITOR
     > /boot/grub/grub.conf title IBM Hard Drive Firmware update
     > kernel /memdisk initrd=/fwdisk.img floppy

     > 7) Reboot and select the "IBM Hard Drive Firmware update"
     > option


     > It allowed me to run the firmware update program, however it
     > didn't believe my drive needed updating, so I haven't even
     > successfully tried the entire process.  Please let me know if
     > it works for you.

     > DISCLAIMER: I also provide no guarantees.  Hopefully your hard
     > disk won't fly off the spindle or anything else bad.  If it
     > does, blame someone else.

Hi Frank,

FYI I succesfully used your above method to update the firmware
for the IC25N040ATMR04-0 hard disk that came with my Thinkpad R51. 

Before the update hdparm -i /dev/hda
Model=IC25N040ATMR04-0, FwRev=MO2OAD4A

and after the update
Model=IC25N040ATMR04-0, FwRev=MO2OADEA

So, thanks!

however, the firmware update did not solve the 'head not park'
issue. :-(

sudo ./park /dev/hda
head not parked 4c


Regards

Gijs

-- 
Is it weird in here, or is it just me?
		-- Steven Wright
