Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129256AbRBBCC3>; Thu, 1 Feb 2001 21:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129288AbRBBCCU>; Thu, 1 Feb 2001 21:02:20 -0500
Received: from raven.toyota.com ([63.87.74.200]:34316 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129256AbRBBCCD>;
	Thu, 1 Feb 2001 21:02:03 -0500
Message-ID: <3A7A1519.E140A726@toyota.com>
Date: Thu, 01 Feb 2001 18:02:01 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: A buglet with LVM-0.9.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I discovered that lvm seems to have a problem
with compaq raid controllers - the partitions
don't have the normal names like /dev/sda1,
but instead names like /dev/ida/c0d0p1 -

lvm seems to works OK, but lvmdiskscan freaks...

lvmdiskscan works normally on other systems,
which have conventional disk controllers.

This is OK -
case: /tmp
(tty/dev/pts/1): bash: 623 > lvscan
lvscan -- ACTIVE           "/dev/lxlvm/lvm1" [3.12 GB]
lvscan -- 1 logical volumes with 3.12 GB total in 1 volume group
lvscan -- 1 active logical volumes

This is OK too -
case: /tmp
(tty/dev/pts/1): bash: 622 > df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ida/c0d0p1        1007928    220124    736604  24% /
/dev/ida/c0d0p8        2015904    251196   1662304  14% /home
/dev/ida/c0d0p7        1007928       240    956488   1% /opt
/dev/ida/c0d0p9        4031856   1660664   2166380  44% /usr
/dev/ida/c0d0p3        2015920     61768   1851744   4% /var
/dev/lxlvm/lvm1        3225352   1888308   1173204  62% /disks/backup

But this is not in agreement:
case: /tmp
(tty/dev/pts/1): bash: 625 > lvmdiskscan -v
lvmdiskscan -- reading all disks / partitions (this may take a while...)

lvmdiskscan -- filling directory cache...
lvmdiskscan -- walking through all found disks / partitions
lvmdiskscan -- /dev/ida/c0d0p1  [    1000.06 MB] free whole disk
lvmdiskscan -- no valid disks / partitions found
lvmdiskscan -- please check your disk device special files!

Hope this is of use -

jjs





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
