Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319770AbSIMUHB>; Fri, 13 Sep 2002 16:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319771AbSIMUHA>; Fri, 13 Sep 2002 16:07:00 -0400
Received: from packet.digeo.com ([12.110.80.53]:55269 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319770AbSIMUG7>;
	Fri, 13 Sep 2002 16:06:59 -0400
Message-ID: <3D824634.480EFA32@digeo.com>
Date: Fri, 13 Sep 2002 13:10:28 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: System response benchmarks in performance patches
References: <1031933335.3d820d97a13c6@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 20:10:33.0503 (UTC) FILETIME=[9DABC2F0:01C25B61]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> I came up with a very simple way of measuring responsiveness that gives me
> numbers that are meaningful to me. What I've done is the old faithful kernel
> compile and measured it under different loads to simulate the pc's ability to
> perform under various loads. I have so far benchmarked 2.4.19 versus 2.4.19-ck7,
>  2.4.19-ck7-rmap and 2.4.18-6mdk(mandrake's kernel in 8.2). 2.5.34 has a dead
> keyboard for me so I'm unable to test it as yet.

Yes, this is a wonderful test.  Very real-world, easy to do and it
tickles a few fairly serious performance problems which we have.

> ...
> The loads were taken from BMatthew's iman found here:
> http://people.redhat.com/bmatthews/irman/

I have issues with irman (I think - didn't read the code really
closely).

It appears to always perform file overwrites - seeking over files,
rewriting them.

This tends to cause best-case behaviour in the VM.  The affected pages
are tucked up out of the way on the active list and we do quite well.

If instead the background application is writing _new_ files then
everything falls apart.

I'd suggest that you stick with the kernel compile as the workload,
and vary the background activity a bit.  Try tiobench.
 
(oh, and try turning on everything in the `input' menu; that might
get the keyboard working again in 2.5)
