Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314289AbSEMQ5r>; Mon, 13 May 2002 12:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314290AbSEMQ5q>; Mon, 13 May 2002 12:57:46 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:59841 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S314289AbSEMQ5n>; Mon, 13 May 2002 12:57:43 -0400
From: <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Date: Mon, 13 May 2002 18:52:18 +0100
Message-Id: <20020513175218.8550@mailhost.mipsys.com>
In-Reply-To: <20020513153802.GB17509@suse.de>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So I think we should have per channel locks on this level
>> right? This is anyway our unit for serialization.
>> (I'm just surprised that blk_init_queue() doesn't
>> provide queue specific locking and relies on exported
>> locks from the drivers...)
>
>Sure go ahead and fine grain it, I had no time to go that much into
>detail when ripping out io_request_lock. A drive->lock passed to
>blk_init_queue would do nicely.
>
>But beware that ide locking is a lot nastier than you think. I saw other
>irq changes earlier, I just want to make sure that you are _absolutely_
>certain that these changes are safe??

You'll probably need a per-host lock (but that one can be safely
hidden in the host controller driver I beleive) since some hosts
share some registers for their 2 channels (timings can be bitfields
in a single register controlling 2 channels, I'm not too sure about
legacy DMA).

Ben.



