Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSHTVF6>; Tue, 20 Aug 2002 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHTVFy>; Tue, 20 Aug 2002 17:05:54 -0400
Received: from web13804.mail.yahoo.com ([216.136.175.14]:54532 "HELO
	web13804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317351AbSHTVFw>; Tue, 20 Aug 2002 17:05:52 -0400
Message-ID: <20020820210957.90917.qmail@web13804.mail.yahoo.com>
Date: Tue, 20 Aug 2002 14:09:57 -0700 (PDT)
From: "M.L.PrasannaK.R." <mlpkr@yahoo.com>
Subject: Odd size mke2fs
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   On my disk, I have an odd(not multiple of 4K)
   number of sectors. There are
   3104561 4K blocks or  12418245 1K blocks and
   24836490 sectors.
 
    mke2fs /dev/x 
    mount
    umount
    mke2fs /dev/x -b 1024
    fails with message
    "...resulted in short write at block 12418240.."

    When it tried to write 5120 bytes, only 4096 bytes
    are written.

    That is due to blksize_size[][] array.
    mount sets the field with 4096 and the last
    sector became inaccessible in mke2fs.
    When I tried after ioctl(.., BLKBSGSET, 1024),
    mke2fs did work properly.

    So should mke2fs use ioctl to set the block
    or use get last sector ioctl? 
    Or is setting that back in umount a proper fix?
 
    If anyone has faced this or is it well known,
    please let me know.
    

Thanks,
Prasanna.

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
