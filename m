Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSAGViM>; Mon, 7 Jan 2002 16:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287156AbSAGViD>; Mon, 7 Jan 2002 16:38:03 -0500
Received: from web14911.mail.yahoo.com ([216.136.225.249]:59659 "HELO
	web14911.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287171AbSAGVhu>; Mon, 7 Jan 2002 16:37:50 -0500
Message-ID: <20020107213749.18573.qmail@web14911.mail.yahoo.com>
Date: Mon, 7 Jan 2002 16:37:49 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: About the request queue of block device
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, I have a question about the request
queue of block device.

I intercept the request function of floppy disk device
by changing the pointer, 
 "blk_dev[2].request_queue.request_fn", in my kernel
module. The following is the source code.

original_request_fn_proc =
blk_dev[2].request_queue.request_fn;
blk_dev[2].request_queue.request_fn =
my_request_fn_proc;

In my own my_request_fn_proc() I use the "req =
blkdev_entry_next_request(&rq->queue_head)" function
to get the pointer of the request structure. When
req->cmd is WRITE I encrypt all the b_data buffer of
the buffer header. Then I call the
original_request_fn_proc(). And it works. The data on
the floppy disk is some kind of cipher data. The
trouble is when the req->cmd is READ. I don't know
whether the b_data buffer contains the data read from
the floppy disk after I call the
original_request_fn_proc() function. When read a block
from the block device, where is the data is placed?

In my module I use the blkdev_next_request() function
to get the next request. When I want to do the same
thing to this next request, the Linux kernel
deadlocked. I must reboot the OS. What is wrong?

Any idea will be appreciated. Thanks in advance.

Michael


______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
