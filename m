Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130228AbRB1Pmw>; Wed, 28 Feb 2001 10:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbRB1Pmm>; Wed, 28 Feb 2001 10:42:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17936 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130242AbRB1Pmb>;
	Wed, 28 Feb 2001 10:42:31 -0500
Date: Wed, 28 Feb 2001 16:41:51 +0100
From: Jens Axboe <axboe@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Holluby István <holluby@interware.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs /dev/loop0
Message-ID: <20010228164151.H21518@suse.de>
In-Reply-To: <Pine.LNX.4.33.0102281545120.1836-100000@cica.khb.hu> <Pine.LNX.3.95.1010228102221.4469A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010228102221.4469A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Feb 28, 2001 at 10:31:35AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28 2001, Richard B. Johnson wrote:
> `mke2fs /dev/loop0`  requires an additional parameter (file size to
> create). Otherwise, it will try to use all the RAM in your system, plus...
> 
> If it worked before, it was because of luck. FYI, this is not the
> way to create a ramdisk. Normally you use the loop device to mount
> a file as a file-system, i.e., `mount -o loop filename /mnt`.
> So, I don't know what you are trying to do except crash your system.

This could not be more wrong. mke2fs will query the size of the
loop device, and make the correct size file system regardless
of whether it's file or block device backed. And it will not
try to use all RAM in the system?! This is loop, not a ramdisk.
Dirty buffers will be flushed to loop like any other block
device in the system, if that doesn't work then we have a mm
bug.

The previous answer was right -- loop has been broken for quite
some time, but use -ac latest on top of 2.4.2 and it should work
flawlessly for you.

-- 
Jens Axboe

