Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVAGSgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVAGSgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAGSgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:36:50 -0500
Received: from web54501.mail.yahoo.com ([68.142.225.171]:50780 "HELO
	web54501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261372AbVAGSgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:36:46 -0500
Message-ID: <20050107183645.72411.qmail@web54501.mail.yahoo.com>
Date: Fri, 7 Jan 2005 10:36:45 -0800 (PST)
From: Shakthi Kannan <shakstux@yahoo.com>
Subject: mount PCI-express RAM memory as block device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I would like to know as to how we can mount a
filesystem for RAM memory on a PCI-express card.
System for development is x86 with 2.4.22 kernel.

I, initially wrote a ramdisk driver to read/write data
between buffer and RAM. Here, I have used:
device->data = vmalloc (device->size);
where:
- device is the device driver structure variable
- data = unsigned char *
- size = unsigned int

I am able to load the above block driver and mount a
filesystem using:
dd if=/dev/zero of=/dev/sbull bs=1k count=64
mkdir /mnt/mysbull
mke2fs -vm0 /dev/sbull 64
mount /dev/sbull /mnt/mysbull

For PCI device driver, I have modifed the above to
directly ioremap device->data as follows:
device->data = ioremap_nocache (BASE_ADDRESS,
BASE_SIZE);
Have successfully done:
dd if=/dev/zero of=/dev/sbull bs=1k count=64
mkdir /mnt/mysbull
mke2fs -vm0 /dev/sbull 64

But, when I proceed to mount a filesystem, it fails. 
mount /dev/sbull /mnt/mysbull

mount:error while guessing filesystem type
mount: you must specify the filesystem type

Also, if I give "fsck -v /dev/sbull", it returns with
improper filesystem super block. Even if I specify "-t
ext2" for mount, it fails. I even tried a
loopback device mount, but it fails too:
mount -o loop /dev/sbull /mnt/mysbull

FAT: bogus logical sector size 0
VFS: Can't find a valid FAT filesystem on dev FA:00

How can I map the RAM memory on the PCI card, even
though I don't allocate any memory (during ioremap)
and display that to the end user as a mounted
filesystem so that he/she can read/write files to it?

Any help/pointers to links is appreciated.

Thanks,

K Shakthi


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
