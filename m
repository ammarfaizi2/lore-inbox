Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFBVwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTFBVwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:52:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:54795 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264088AbTFBVwG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:52:06 -0400
Date: Tue, 3 Jun 2003 00:09:36 +0200
To: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: RAID crash in 2.5.70-bk7
Message-ID: <20030602220936.GA10937@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The raid trouble in mm also exists in 2.5.70-bk7

I get several stack traces and a final oops
in interrupt when trying to boot.  Thanks to 
matroxfb and the 8x8 font, I now have a nice long trace.

This is not the first in the row, but not the last one either.
My reports about mm always were the last one.

After this came several messages about unregistering md1
(the raid-0 array) before the final oops.

I use raid-1, raid-0, preempt, smp & devfs, all fs'es
are ext2.  I don't use modules.

Here is the trace:
raid0_run
raid0_run
printk
blk_queue_make_request
do_md_run
printk
autorun_arrays
printk
md_fail_request
autorun_devices
printk
autostart_array
do_open
md_ioctl
blkdev_open
devfs_open
dentry_open
filp_open
sys_open
blkdev_ioctl
sys_ioctl
md_run_setup
prepare_namespace
init
init
kernel_thread_helper

Slab error in cache_free_debugcheck
cache `size-32' double free, or memory after object
overwritten

Helge Hafting
