Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTEYPGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 11:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTEYPGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 11:06:33 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:56537 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263163AbTEYPGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 11:06:32 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm9
Date: Sun, 25 May 2003 16:19:40 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200305251619.40137.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm9/
> 
> 
> . 2.5.69-mm9 is not for the timid.  It includes extensive changes to the
>   ext3 filesystem and the JBD layer.  It withstood an hour of testing on
>   my 4-way, but it probably has a couple of holes still.
> 
>   The locking has been finegrained and sleeping locks have been removed -
>   there are now no instances of lock_kernel(), lock_journal() or
>   sleep_on()
>   in JBD or ext3.  ext3 is much quicker on SMP machines.

Hi,

These changes don't even get to login for me. I changed the mm9 command line 
to include init=/bin/sh and got to a prompt. I was able to reproduce an 
enormous number of oopses by issuing:

mount -o remount,rw /

I tried to log it with klogd pointed to a different partition (vfat) but the 
problem segfaults klogd before it commits anything to disc. I'll probably try 
to do it via serial console this evening if nobody else can reproduce this.

Another oddity is that changing my / partition to ext2 in /etc/fstab and 
booting normally (i.e., without init=) doesn't make any difference. If these 
changes are ext3/jbd only, why is my ext3 volume mounted as ext2 still not 
mounting rw?

FWIW, all of my disc's partitions are ext3.

Cheers,
Alistair.
