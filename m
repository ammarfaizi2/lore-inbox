Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRKMOFB>; Tue, 13 Nov 2001 09:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281627AbRKMOEu>; Tue, 13 Nov 2001 09:04:50 -0500
Received: from mw3.texas.net ([206.127.30.13]:35583 "EHLO mw3.texas.net")
	by vger.kernel.org with ESMTP id <S279548AbRKMOEk>;
	Tue, 13 Nov 2001 09:04:40 -0500
Message-ID: <3BF12860.1050302@btech.com>
Date: Tue, 13 Nov 2001 08:04:16 -0600
From: "Malcolm H. Teas" <mhteas@btech.com>
Organization: Blaze Technology, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ramdisk ioctl bug fix, kernel 2.4.14
In-Reply-To: <200111130916.fAD9Gvi32288@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

With respect, I'd make the argument that if one makes a ram disk 1024 blocks in 
size, and the max size is set to the default of 4096, the ioctl should return 
the actual current size of 1024.  To do otherwise would lead people and userland 
tools to think the ram disk is larger than it actually is.

 From this point of view, the fact that it's done this in the past is a bug.

I've been typically using the commands:

dd if=/dev/zero of=/dev/ram1 bs=1k count=1720 (or whatever size is appropriate)
mkfs -t ext2 /dev/ram1

In this case, the ioctl reports 1720 blocks for the /dev/ram1 and zero for the 
other ram disks not yet used.  This is more useful than having all ram disks - 
used or not - always report 4096.  It's also a good double check on the actual 
configuration one's using for their ram disks.

Most disk devices can't change their size with a few commands as a ram disk can 
as it's a physical constant.  Ram disks are virtual so their size is whatever 
the user specifies, with a kernel configured upper limit.  I argue that the size 
is the allocated amount, not the upper limit.

Thanks,
-Malcolm


Alan Cox wrote:

>>The patch below makes the ramdisk return the actual size that is currently 
>>allocated instead of returning the max size we can possibly allocate.  Affects 
>>system calls ioctl(filedes, BLKGETSIZE) and ioctl(filedes, BLKGETSIZE64) for 
>>ramdisk devices.
>>
> 
> That seems to be the opposite of what its always done, and also of what
> disk devices do.
> 
> 
> 


-- 
Malcolm H. Teas, http://www.btech.com/
Blaze Technology, Inc.  Austin TX
Remember 9/11/2001

