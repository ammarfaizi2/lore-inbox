Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTG1TqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270501AbTG1TqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:46:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:17389 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270489AbTG1TqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:46:04 -0400
Date: Mon, 28 Jul 2003 12:45:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1000] New: file corruption using cryptoloop on ext2/ext3/other file systems 
Message-ID: <3899210000.1059421547@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1000

           Summary: file corruption using cryptoloop on ext2/ext3/other file
                    systems
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: kernel@gozer.org


Distribution: unstable debian (util-linux 2.12)
Hardware Environment: AMD K7
Software Environment:
Problem Description:

Using cryptoloop, any files copied to ext2/ext3, and from what I hear anything
other than msdos/vfat (vfat verified), leaves files corrupted.

# this talks about files larger than system memory, but I see this with files
# of any size.
http://marc.theaimsgroup.com/?l=linux-kernel&m=105932373007928&w=2

http://marc.theaimsgroup.com/?l=linux-kernel&m=105873721209176&w=2

Steps to reproduce:

losetup /dev/loop0 /dev/hdX -e aes
mkfs -t ext3 /dev/loop0
mount /dev/loop0 /mnt
cp /tmp/some.mp3 /mnt
umount /mnt
losetup -d /dev/loop0

md5sum /tmp/some.mp3

losetup /dev/loop0 /dev/hdX -e aes
mount /dev/loop0 /mnt
md5sum /mnt/some.mp3

While the fs is mounted, everything checks out ok, but as soon as you unmount
and remount, it's all messed up.

I created a 10MB test file, and instead of using a drive/partition as above, I
used the file. ext2 on there worked ok, so I don't know if it's something over a
certain size or what.


