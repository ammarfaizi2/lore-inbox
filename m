Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVLONxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVLONxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVLONxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:53:44 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:40012 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932347AbVLONxn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:53:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I48Q0KVc5OdZCp5NrTT7D4dGAigiHGJ9hZTBn0ccY+8SeYKxVy31Cpsnfd6PefI83PUwGY8icP6yGmfxOWQqANawpkVVahxlZEdtNknM8MqzTWZOR265hNH2F403YOJpd+We3GVFMzKHVymycNQn8KltKylfzIli76T4b2dBlxU=
Message-ID: <64c763540512150553y65c62280uf83ce805399ea906@mail.gmail.com>
Date: Thu, 15 Dec 2005 19:23:42 +0530
From: Block Device <blockdevice@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bdev->bd_disk is NULL @ initrd time
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I have a problem running the following code snippet from a kernel module.

  struct block_device *bdev=bdget(MKDEV(3,10));

  if(!bdev){
	printk(KERN_ALERT "NULL bdev.!!!\n");
	return -1;
    }

    if(!bdev->bd_disk){
	printk(KERN_ALERT "NULL bdev bd_disk.!!!\n");
	return -1;
    }
    printk(KERN_ALERT "Diskname is %s.\n",bdev->bd_disk->disk_name);

When this module is inserted from initrd's init script ( after block
drivers are loaded ) bdev->bd_disk is always NULL. But when its
inserted after the system has booted it
works fine. Can someone please explain this behaviour ?.

I checked that the block devices are up by spawning a shell just after
this module is inserted from the init script. When I cat /proc/devices
the ide device shows up.

Thanks
-BD
