Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTIXJKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 05:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTIXJKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 05:10:12 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:51725 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261403AbTIXJKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 05:10:06 -0400
Message-ID: <3F716177.6060607@aitel.hist.no>
Date: Wed, 24 Sep 2003 11:18:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4 boot crash
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test5-mm4 crashed during RAID-1 autodetection and setup.
It got as far as:
md: created md0
md: bind<hda1>
md: bind<hdb1>
md: running: <hdb1><hda1>

After this, I usually get this (from test5-mm3 dmesg):
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.

Instead, I got the dump at the end of this message.
I'm using devfs and Viro's compile fix for devfs in mm4.
The root fs is on raid-1, the raid-1 gets autodetected.

The kernel has no module support, and no initrd.

Here's the dump:

Unable to handle null pointer deref at virtual address 00000000
eip c02b7d1e  eip at md_probe
PREEMPT process swapper pid:1
Trace:
invalidate_inode_pages
do_md_run
printk
autorun_array
autorun_devices
mddev_put
autostart_arrays
igrab
md_ioctl
devfs_open
dentry_open
filp_open
blkdev_ioctl
sys_ioctl
md_run_setup
prepare_namespace
init
init
kernel_thread_helper

Attempted to kill init!

