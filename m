Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287375AbSACWBc>; Thu, 3 Jan 2002 17:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287368AbSACWBX>; Thu, 3 Jan 2002 17:01:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287394AbSACWBJ>; Thu, 3 Jan 2002 17:01:09 -0500
Date: Thu, 3 Jan 2002 17:01:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: The CURRENT macro
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020103165726.906A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Michael Zhu wrote:

> In Alessandro Rubini's book Linux Device Driver(Second
> Edition), Chatper 12, he said that "By accessing the
> fields in the request structure, usually by way of
> CURRENT" and "CURRENT is just a pointer into
> blk_dev[MAJOR_NR].request_queue". I know CURRENT is
> just a macro. Where can I find the definition of this
> macro?
> I just don't know how to get the struct request from
> the request_queue(a request_queue_t struct). CURRENT
> points to which field in the
> blk_dev[MAJOR_NR].request_queue? Thank you very much.
> 
> Michael

If symlinks are set up:

/usr/include/linux/blk.h

#ifndef _BLK_H
#define _BLK_H

[SNIPPED...]

#ifndef CURRENT
#define CURRENT blkdev_entry_next_request(&blk_dev[MAJOR_NR].request_queue.queue_head)
#endif

#endif /* _BLK_H */

Otherwise:

../linux-n.n.n/include/linux/blk.h


FYI. To find things in the future, do:
cd /usr/include/linux
grep WHAT_TO_FIND *.h | more
cd ../asm
grep WHAT_TO_FIND *.h | more


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


