Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWDJKZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWDJKZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWDJKZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:25:14 -0400
Received: from alpha.polcom.net ([83.143.162.52]:2711 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751112AbWDJKZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:25:13 -0400
Date: Mon, 10 Apr 2006 12:25:07 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Slow swapon for big (12GB) swap
In-Reply-To: <20060410004030.5e48be79.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
 <20060410004030.5e48be79.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Andrew Morton wrote:
> Grzegorz Kulewski <kangur@polcom.net> wrote:
>>
>> I am using big swap here (as a backing for potentially huge tmpfs). And I
>>  wonder why swapon on such big (like 12GB) swap takes about 7 minutes
>>  (continuous disk IO).
>
> It's a bit quicker here:
>
> vmm:/usr/src/25# mkswap /dev/hda6
> Setting up swapspace version 1, size = 54031826 kB
> vmm:/usr/src/25# time swapon /dev/hda6
> swapon /dev/hda6  0.00s user 0.04s system 74% cpu 0.054 total
>
>
>> Is this expected?
>
> Nope.
>
>> Why it is like that?
>
> Are you using a swapfile or a swap partition?

Swap file.


> If it's a swapfile then perhaps the filesystem is being inefficient in its
> bmap() function.  Which filesystem is it?

Ext3.

The kernel is 2.6.16-rc3-git2-ck1. There is -ck patch in it but I strongly 
hope that swap prefetch is not *that* buggy to cause such things... I am 
considering testing vanilla. Con CC'd.

The system is Athlon XP 2000MHz with 1GB of RAM and Samsung 80GB IDE hard 
drive.

The second run of swapon is very fast (like 2 seconds). So it looks like 
it has cached something in RAM?...


Thanks,

Grzegorz Kulewski

