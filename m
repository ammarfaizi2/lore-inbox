Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUFYOot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUFYOot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUFYOot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:44:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266749AbUFYOop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:44:45 -0400
Date: Fri, 25 Jun 2004 10:44:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Ashley <dash@xdr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cache memory never gets released
In-Reply-To: <200406251424.i5PEO9UX000396@xdr.com>
Message-ID: <Pine.LNX.4.53.0406251034320.28537@chaos>
References: <200406251424.i5PEO9UX000396@xdr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, David Ashley wrote:

> Marcelo Tosatti wrote:
> >Cached memory can be easily reclaimed, take a look at /proc/meminfo "Inactive"
> >list.
>
> Here is /proc/meminfo from a box that has all but exhausted its free memory:
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  122064896 84348928 37715968        0   634880 74829824
> Swap:        0        0        0
> MemTotal:       119204 kB
> MemFree:         36832 kB
> MemShared:           0 kB
> Buffers:           620 kB
> Cached:          73076 kB
> SwapCached:          0 kB
> Active:          70380 kB
> Inactive:         7324 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       119204 kB
> LowFree:         36832 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB
>
> >Add more swap.
>
> Might as well suggest walking on water. The hardware is set in stone, this is
> a software issue :^).
>
> Something is preventing the cached memory to get reused, it's like it's gone
> for good.
>
> Is there any count of how often a cached block is accessed? If there is such
> a count, and the count has an effect on whether to allow the release of the
> cached block, that could explain this behaviour. Because it could turn out
> that the cached blocks are accessed thousands of times.
>
> Thanks--
> Dave

Are you sure you have a problem? If you do `ls -R /` on a file-system
and then look at the cached RAM, you see a lot. It's the dircache.
It is some of the first to be used when the system needs RAM. If you
compile the kernel with `make -j 20 bzImage` so you have a lot of
tasks, needing lots of RAM, the cached value goes way down. It
will eventually be "free" after the compile completes.

Basically, the only way to return cached RAM to the free-list
is to run programs requiring RAM. What is listed as "cached" really
means "RAM that was used, but wasn't freed because we don't need
it yet.... Freeing RAM is as expensive as acquiring it so if it's
used by a kernel buffer, it isn't freed until it's needed.

This is linux-2.4.26. If you are using an exprimental kernel,
memory-allocation might be broken but is probably not.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


