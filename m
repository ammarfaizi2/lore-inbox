Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUJHUp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUJHUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUJHUp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:45:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:35564 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264980AbUJHUpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:45:47 -0400
Date: Fri, 8 Oct 2004 13:49:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3: vm-thrashing-control-tuning
Message-Id: <20041008134943.0da743fa.akpm@osdl.org>
In-Reply-To: <41666CF9.4040207@sdl.hitachi.co.jp>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	<41666CF9.4040207@sdl.hitachi.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hideo AOKI <aoki@sdl.hitachi.co.jp> wrote:
>
> Since I made the patch for 2.6.9-rc3, the patch caused trouble 
> to sysctl code in -mm tree.
> 
> Attached patch fixes this issue.

Thanks.

Have you been doing any performance measurements on the thrash-control
code?

I went back to my original notes from when the patch was first being tested and
I had:

mem=256m, without, ./qsbench -p 4 -m 96

./qsbench -p 4 -m 96  27.50s user 3.92s system 9% cpu 5:34.26 total
./qsbench -p 4 -m 96  27.77s user 4.19s system 9% cpu 5:41.38 total
./qsbench -p 4 -m 96  27.22s user 4.17s system 9% cpu 5:16.75 total

with:

./qsbench -p 4 -m 96  27.40s user 2.08s system 35% cpu 1:23.67 total
./qsbench -p 4 -m 96  27.70s user 2.14s system 30% cpu 1:38.92 total
./qsbench -p 4 -m 96  27.03s user 1.79s system 39% cpu 1:13.16 total


But now I am unable to get anything remotely near the 1-2 minute runtimes
with this workload on current kernels.  Which means that either we broke it
again or I originally mismeasured it somehow.

I'm wondering if you've been able to notice any performance improvements
from the thrashing control and if so, how much and on what workload?
