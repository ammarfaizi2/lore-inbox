Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbSJISHU>; Wed, 9 Oct 2002 14:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJISHU>; Wed, 9 Oct 2002 14:07:20 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:48911 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262037AbSJISHR>; Wed, 9 Oct 2002 14:07:17 -0400
Date: Wed, 9 Oct 2002 19:12:59 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com
Subject: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021009181259.GA25050@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5 port of device-mapper is available from:

   bk://device-mapper.bkbits.net/2.5-stable

There are 6 changesets in here that are summarised at the end of this
email.

If you wish to use it you will need to install libdevmapper:

   ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-latest.tgz

and then either use dmsetup, or the LVM tools:

   ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-latest.tgz

Initial testing has been successful, though it hasn't been exercised
nearly as much as the stable 2.4 releases.

There is a chunk of ~50 lines in dm.c, which I have clearly labelled,
this is stop gap block splitting code that will be replaced with the
correct use of queue->merge_bvec_fn etc.  However before I can make
this change there are a couple of other patches to the block layer
that I want to merge.

Since the feature freeze is looming I would appreciate it if this code
was merged now.  Allowing me to patch/argue to get the extra
performance at my leisure.  Good plan ?

Slightly more info available at: http://people.sistina.com/~thornber/

-  Joe Thornber




ChangeSet@1.709, 2002-10-09 17:06:21+01:00, thornber@sistina.com
  [mempool]
  Most people use mempools in conjunction with slabs, this defines 
  a couple of utility functions for allocing/freeing.

ChangeSet@1.710, 2002-10-09 17:09:58+01:00, thornber@sistina.com
  [vmalloc]
  Introduce vcalloc, I only really want it to automate the size overflow
  check when allocating arrays.

ChangeSet@1.711, 2002-10-09 17:28:44+01:00, thornber@sistina.com
  [Device mapper]
  The core of the device-mapper driver.  No interface or target types 
  included as yet.
ftp://ftp.sistina.com/pub/LVM2/tools/LVM
ChangeSet@1.712, 2002-10-09 17:33:00+01:00, thornber@sistina.com
  [Device mapper]
  The linear target maps a contigous range of logical sectors onto an
  contiguous range of physical sectors.

ChangeSet@1.713, 2002-10-09 17:36:55+01:00, thornber@sistina.com
  [Device mapper]
  The stripe target.  Maps a range of logical sectors across many
  physical volumes.

ChangeSet@1.714, 2002-10-09 17:41:10+01:00, thornber@sistina.com
  [Device mapper]
  Provide a traditional ioctl based interface to control device-mapper
  from userland.






