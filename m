Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbSJGT5Y>; Mon, 7 Oct 2002 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbSJGT5U>; Mon, 7 Oct 2002 15:57:20 -0400
Received: from dsl-213-023-021-129.arcor-ip.net ([213.23.21.129]:53419 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262693AbSJGT5P>;
	Mon, 7 Oct 2002 15:57:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Date: Mon, 7 Oct 2002 22:02:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0210071222340.10168-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0210071222340.10168-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ye5U-0003ul-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 October 2002 21:24, Linus Torvalds wrote:
> On Mon, 7 Oct 2002, Daniel Phillips wrote:
> > 
> > Devices have a few MB of readahead cache, the kernel can have thousands of
> > times as much.
> 
> I don't think that is in the least realistic.
> 
> There's _no_ way that the krenel could do physical readahead for more than
> a few tens or hundreds of kB

If that's a bet, I'll take you up on it.

> - the latency impact would just be too much
> to handle, and the VM impact is not likely insignificant either.

I did say difficult.  It really is, but there are big gains to be had.

This is easy to verify: say you have 100 MB of kernel source stored in, say,
50 different clumps on disk.  Complete with seeks, a perfectly prescient
readahead algorithm can read that into memory in about 5 seconds, even with
my lame scsi raid controller[1].  So two of those needs 10 seconds, and I
can diff those two trees in 2 seconds, in cache.  In practice it takes 90
seconds, so there is obviously a lot of room for improvement.

Note that if the disks really were capable of handling the readahead
themselves they would already give me the 12 second result, not the 90
seconds.  They simply can't, because they haven't got enough cache.

[1] If the controller wasn't lame it would read the 100 MB in less than a
second, with its (peak) total of 200 MB/s media bandwith, less 20% worth
of parity blocks.

-- 
Daniel
