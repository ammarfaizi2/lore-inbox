Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSFKJXu>; Tue, 11 Jun 2002 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFKJXt>; Tue, 11 Jun 2002 05:23:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316965AbSFKJXs>;
	Tue, 11 Jun 2002 05:23:48 -0400
Message-ID: <3D05C27D.186DC066@zip.com.au>
Date: Tue, 11 Jun 2002 02:27:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: Your message of "Tue, 11 Jun 2002 00:42:32 MST."
	             <3D05A9E8.FF0DA223@zip.com.au> <E17Hheq-0007r7-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> ...
> Let's not perpetuate the myth that everything in the kernel needs to
> be tuned to the last cycle at all costs, hm?

I was more concerned about the RAM use, actually.

This patch is an additional reason for CONFIG_NR_CPUS, but I've rather
gone cold on that idea because the "proper fix" is to make all those
huge per-cpu arrays dynamically allocated.   So you can run a 64p kernel
on 2p without losing hundreds of k of memory and kernel address space.

But it looks like all those dynamically-allocated structures would
have to be allocated out to NR_CPUS anyway, to support hotplug, yes?

In which case, CONFIG_NR_CPUS is the only way to get the memory
back...

-
