Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267311AbSKPRSA>; Sat, 16 Nov 2002 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267314AbSKPRSA>; Sat, 16 Nov 2002 12:18:00 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:14236 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267311AbSKPRR7> convert rfc822-to-8bit; Sat, 16 Nov 2002 12:17:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sat, 16 Nov 2002 18:23:26 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Con Kolivas <conman@kolivas.net>
References: <200211161657.51357.m.c.p@wolk-project.de> <20021116165956.GF31697@dualathlon.random>
In-Reply-To: <20021116165956.GF31697@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211161810.23039.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 17:59, Andrea Arcangeli wrote:

Hi Andrea,

> Your pausing problem have little to do with the pausing fix, the problem
> for you is the read latency, you're not triggering the race condition
> fixed by the pausing fix so it can't make differences. One of the
> foundamental obstacles to the read latency is the size of the I/O queue,
> factor that is workarounded by the read-latency patch that basically
> bypasses the size of the queue hiding the problem and in turn can't fix
> the write latency with O_SYNC and the read latency during true read aio
> etc...
ok, after some further tests, I think this is _somewhat_ FS dependent. I tried 
this with ext2, ext3 (no difference there) and also with ReiserFS and what 
must I say, those "Pausings" caused be the write latency doing it with 
ReiserFS are alot less than with ext2|ext3 but are still occuring.

There must went in something bullshitty into 2.4.19/2.4.20 that causes those 
ugly things because 2.4.18 does not have that problem. This is still why I 
don't use any kernels >2.4.18.

After changing elevator things like this:

root@codeman:[/] # elvtune /dev/hda

/dev/hda elevator ID            0
        read_latency:           2048
        write_latency:          1024
        max_bomb_segments:      0

those "pausings" are less worse than before but are still there.
NOTE: Write latency is lower than read latency (it's not a typo :)

ciao, Marc


