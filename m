Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbTAJS20>; Fri, 10 Jan 2003 13:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265800AbTAJS1o>; Fri, 10 Jan 2003 13:27:44 -0500
Received: from [193.158.237.250] ([193.158.237.250]:23432 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265787AbTAJS0d>; Fri, 10 Jan 2003 13:26:33 -0500
Date: Fri, 10 Jan 2003 19:34:46 +0100
Message-Id: <200301101834.h0AIYkT04104@mail.intergenia.de>
To: William Lee Irwin III <wli@holomorphy.com>
From: Brian Tinsley <btinsley@emageon.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>We're straying from the subject here.
>
Sorry

>Please describe your machine,
>in terms of how many cpus it has and how much highmem it has, and
>your workload, so I can better determine the issue. Perhaps we can
>cooperatively devise something that works well for you.
>
IBM x360
Pentium 4 Xeon MP processors

2 processor system has 4GB RAM
4 processor system has 8GB RAM

1 IBM ServeRAID controller
2 Intel PRO/1000MT NICs
2 QLogic 2340 Fibre Channel HBAs

>Or perhaps the kernel version is not up-to-date. Please also provide
>the precise kernel version (and included patches). And workload too.
>
The kernel version is stock 2.4.20 with Chris Mason's data logging and 
journal relocation patches for ReiserFS (neither of which are actually 
in use for any mounted filesystems). It is compiled for 64GB highmem 
support. And just to refresh, I have seen this exact behavior on stock 
2.4.19 and stock 2.4.17 (no patches on either of these) also compiled 
with 64GB highmem support.

Workload:
When the live-lock occurs, the system is performing intensive network 
I/O and intensive disk reads from the fibre channel storage (i.e., the 
backup program is reading files from disk and transferring them to the 
backup server). I posted a snapshot of sar data collection earlier today 
showing selected stats leading up to and just after the live-lock occurs 
(which is noted by a ~2 minute gap in sar logging). After the live-lock 
is released, the only thing that stands out is an unusual increase in 
runtime for kswapd (as reported by ps).

The various Java programs mentioned in prior postings are *mostly* idle 
at this point in time as it is after hours for our clients.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

