Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTIGDiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 23:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTIGDiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 23:38:12 -0400
Received: from play.smurf.noris.de ([192.109.102.42]:7062 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S262043AbTIGDiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 23:38:08 -0400
From: Matthias Urlichs <smurf@smurf.noris.de>
Organization: {M:U}
To: linux-kernel@vger.kernel.org
Subject: 2.6: Crash when calling "blockdev --rereadpt" on USB insert
Date: Sun, 7 Sep 2003 05:29:55 +0200
User-Agent: KMail/1.5.3
X-Face: xyzzy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309070529.55502@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this snippet in my /etc/hotplug/usb script to mount my USB disk
when I insert it:

    if [ "$PRODUCT" = "58f/9380/100" ]; then
       find /dev/scsi -name disc | while read a ; do
           /sbin/blockdev --rereadpt $a
       done
       if sudo -u smurf mount /mnt/key ; then
               echo "#!/bin/sh" > $REMOVER
               echo "umount -f /mnt/key" >> $REMOVER
               chmod +x $REMOVER
       fi
    fi

This works splendidly with 2.4, but 2.6.0.test4 (where it's arguably
unnecessary...) dies with this message:

Sep  7 05:18:38 linux kernel: Oops: kernel access of bad area, sig: 11 [#1]
Sep  7 05:18:38 linux kernel: NIP: C001407C LR: C0072830 SP: DD749DA0 REGS: dd749cf0 TRAP: 0301    Not tainted
Sep  7 05:18:38 linux kernel: MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
Sep  7 05:18:38 linux kernel: DAR: FFFFFFEF, DSISR: 40000000
Sep  7 05:18:38 linux kernel: TASK = caf46940[4768] 'blockdev' Last syscall: 54
Sep  7 05:18:38 linux kernel: GPR00: C0072830 DD749DA0 CAF46940 FFFFFFEF C0293B30 C00930F0 D56A4EFF DD748000
Sep  7 05:18:38 linux kernel: GPR08: C0940000 00000000 00000002 DD748000 82000228
Sep  7 05:18:38 linux kernel: Call trace:
Sep  7 05:18:38 linux kernel:  [c0072830] dput+0x2c/0x300
Sep  7 05:18:38 linux kernel:  [c00931f4] create_dir+0xd4/0xe8
Sep  7 05:18:38 linux kernel:  [c0093254] sysfs_create_dir+0x40/0xa4
Sep  7 05:18:38 linux kernel:  [c00c0480] create_dir+0x28/0x6c
Sep  7 05:18:38 linux kernel:  [c00c09f4] kobject_add+0xdc/0x194
Sep  7 05:18:38 linux kernel:  [c00c0ad8] kobject_register+0x2c/0x6c
Sep  7 05:18:38 linux kernel:  [c00907d8] add_partition+0xb8/0xdc
Sep  7 05:18:38 linux kernel:  [c0090aa8] rescan_partitions+0xf0/0x128
Sep  7 05:18:38 linux kernel:  [c00f0ca8] blkdev_reread_part+0x94/0xc4
Sep  7 05:18:38 linux kernel:  [c00f0f14] blkdev_ioctl+0x160/0x450
Sep  7 05:18:38 linux kernel:  [c006d548] sys_ioctl+0x144/0x364
Sep  7 05:18:38 linux kernel:  [c0007b8c] ret_from_syscall+0x0/0x4c

This doesn't look like it's PPC specific. I can probably reproduce on
i386 if that would be helpful to anybody.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
It is better to decide between our enemies than our friends; for one of our
friends will most likely become our enemy; but on the other hand, one of your
enemies will probably become your friend.
					-- Bias

