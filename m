Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJZVqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJZVqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 16:46:17 -0500
Received: from gozer.dminteractive.com ([66.18.16.178]:27828 "EHLO
	gozer.dminteractive.com") by vger.kernel.org with ESMTP
	id S262540AbTJZVqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 16:46:15 -0500
Date: Sun, 26 Oct 2003 15:46:13 -0600
From: Mike <logan@dct.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 cryptoloop+cdrom
Message-ID: <20031026214613.GA28254@gozer.dminteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heyas,

Has anyone been able to create encrypted cdroms with cryptoloop in 2.6? Since the initial patches for 2.5.x were released, I've been trying without success.

dd if=/dev/urandom of=test bs=1MB count=50
losetup /dev/loop0 test -e blowfish
mkfs -t ext2 -b 2048 /dev/loop0
mount /dev/loop0 /mnt
# copy some files
umount /mnt ; losetup -d /dev/loop0

cdrecord -v speed=12 dev=/dev/cdrom test

losetup /dev/loop0 /dev/cdrom -e blowfish ; mount /dev/loop0 /mnt

mount: block device /dev/loop0 is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/loop0,
       or too many mounted file systems

dmesg shows:
   hdc: cdrom_read_intr: data underrun (4 blocks)
   end_request: I/O error, dev hdc, sector 2
   EXT2-fs: unable to read superblock

With the loop device setup, I can cat /dev/loop0 > /tmp/test, then mount the file.

Most of the docs I've read have been for 2.4, but I'm able to use partitions and obviously files, so I don't think anything is missing... Tried various block sizes (1024-4096), various file systems (ext2, ext3, vfat), ide-scsi enabled or disabled and other ciphers like aes.

I'm using debian/testing. mount/util-linux have both been put on hold and stock util-linux 2.12 installed.

Any info would be appreciated, but please cc me as I'm not on the list.

Thanks,

Mike
