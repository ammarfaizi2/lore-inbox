Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUAYP2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUAYP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 10:28:36 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:6528 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S264359AbUAYP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 10:28:34 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16403.57499.905471.768545@jik.kamens.brookline.ma.us>
Date: Sun, 25 Jan 2004 10:28:27 -0500
To: linux-kernel@vger.kernel.org
Subject: MD Oops on boot with 2.6.2-rc1-mm3
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get an Oops on boot with 2.6.2-rc1-mm3, trying to boot from a RAID1
MD root partition with two disks in the array; the Oops apparently
causes the raid array not to be assembled, so the boot stops.
Unfortunately, I don't have a serial console so I can't capture the
complete Oops and run ksymoops on it, but here's the information I was
able to gather:

* I have raid=noautodetect turned on, so detection happens from within
  linuxrc in my initrd.  If I get rid of raid=noautodetect, then the
  initial autodetect works fine, but I still get an Oops in the
  autodect run within linuxrc; its call trace looks slightly
  different.

* The kernel was able to successfully start one of my other RAID
  partitions immediately before the Oops which caused md0 to fail to
  start: "raid1: raid set md1 active with 2 out of 2 mirrors".

Here's what I was able to transcribe (I couldn't write down all the
hex numbers that ksymoops would have been able to interpret, but
perhaps what I was able to capture will be helpful):

Unable to handle kernel NULL pointer dereference at virtual address 00000008
EIP is at blkdev_reread_part+0x15/0x90
Call Trace:

  iget5_locked
  blkdev_ioctl
  wake_up_inode
  ioctl_by_bdev
  do_md_run
  printk
  bdevname
  autorun_array
  printk
  bdevname
  autorun_devices
  printk
  autostart_arrays
  exact_lock
  kobj_lookup
  md_ioctl
  get_gendisk
  md_open
  do_open
  blkdev_open
  dentry_open
  blkdev_ioctl
  sys_ioctl
  sys_open
  sysenter_part_esp

I can duplicate this Oops, so if there's any other information from it
which I can provide to help debug it, please let me know.

  jik
