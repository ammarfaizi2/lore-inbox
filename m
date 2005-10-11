Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVJKRpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVJKRpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 13:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVJKRpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 13:45:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51799 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932073AbVJKRpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 13:45:31 -0400
Date: Tue, 11 Oct 2005 19:46:13 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, linux-btrace@vger.kernel.org
Subject: [PATCH] Block device io tracing
Message-ID: <20051011174612.GK3533@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a semi-formal announce of version 0.99 of the blktrace/blkparse
tools for block queue io tracing. In case you just want to play with it,
you can pull it from the following git repo:

git://brick.kernel.dk/data/git/blktrace.git

or find tar balls here:

http://brick.kernel.dk/snaps

So what does it do? Well it can tell you anything that is going on at
the queue level for a block device. It will show you io being queued,
merged, dispatched, and completed - when that happened and on what CPU.
It will show you if io is being split or bounced, requeue actions,
sleeping waiting for requests, plugging/unplugging etc. At the end of a
trace, it can give you stats on a per-process basis and more.

That is the file system side of things. It can also show you SCSI
commands issued through SG_IO - the CDB sent and what the drive
completes.

It should be helpful in debugging application problems (eg cdrecord not
working properly, see what it sent to the drive and where it barfed) or
generel performance problems in the io stack. Or it can help you find
out if the io scheduler is doing what you think it is doing.

The package contains three major components:

- A kernel patch for 2.6.14-rc4. It's fairly small, about 20kb. You need
  to select RELAYFS_FS in the fs section of the config and IO_TRACE in
  the block layer section.

- blktrace. This is the program responsible for collecting data from a
  device.

- blkparse. This is the program that will show you what happened.

There are two ways to run this - in live tracing mode, basically piping
data from blktrace to blkparse. There's a script for this, btrace. For a
feel for how it works, just run btrace /dev/xxx. Or you can run blktrace
and collect the data you want and have blkparse process it afterwards.

For more info, see the included README for some simple examples on what
you can do. For more in depth info, run make docs in the dir and get a
blktrace.pdf file that contains a lot more info.

As you may have noticed in the mail headers, there's a linux-btrace list
hosted at vger for this project.

-- 
Jens Axboe

