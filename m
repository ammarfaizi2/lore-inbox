Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRANTna>; Sun, 14 Jan 2001 14:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRANTnU>; Sun, 14 Jan 2001 14:43:20 -0500
Received: from colorfullife.com ([216.156.138.34]:52488 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135268AbRANTnL>;
	Sun, 14 Jan 2001 14:43:11 -0500
Message-ID: <3A620146.1594EDDB@colorfullife.com>
Date: Sun, 14 Jan 2001 20:43:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: ajh@atri.curtin.edu.au, linux-kernel@vger.kernel.org
Subject: Re: Question regarding driver developement
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only way I have found so far is to write have two FIFO buffers in the
> driver (in and out) and use a daemon running in user space to manage the
> disk access. 

Have you thought about using mmap and raw-io?

* the kernel driver allocates a fifo (probably a ring?) buffer. The
driver implement mmap.
* the user space daemon mmaps the complete ring buffer.
* The user space daemon waits until the next block is written to the
ring, then it uses /dev/raw?? to write the data to the disk.

> This is quite inefficient however since it requires at least 5 memcopy
> operations before the data reaches the hard drive. 

0-memcopy, direct DSP DMA->main memory; main memory->SCSI DMA :-)

mmap is always possible, raw-io needs one dedicated partition and I'm
not sure if it's supported in stock 2.2.18 (but there are add-on patches
for 2.2)

> The Software running on the DSPs requires soft realtime
> response from the disk access.

You could also replace the user space daemon with a kernel_thread(), but
I doubt that this will be necessary.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
