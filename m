Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274819AbTHFFWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274820AbTHFFWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:22:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:9696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274819AbTHFFWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:22:14 -0400
Date: Tue, 5 Aug 2003 22:23:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Cliff White <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
Message-Id: <20030805222354.66dbdb8d.akpm@osdl.org>
In-Reply-To: <200308041607.h74G7fT20187@es175.pdx.osdl.net>
References: <200308041607.h74G7fT20187@es175.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> 
> I see 2.6.0-test2-mm4 is already in our queue, so this may be
> Old News. ( serves me right for taking a weekend off )
> Performance of -mm3 falls off on the 4-cpu machines. 
> 
> 2-cpu ssytems
> Kernel 			JPM 
> 2.6.0-test2-mm3		1313.53
> linux-2.6.0-test2	1320.68 (0.54 % +)
> 
> 4-cpu systems
> 2.6.0-test2-mm3		4824.96
> linux-2.6.0-test2	5381.20 ( 11.53 % + )
> 
> Full details at
> http://developer.osdl.org/cliffw/reaim/index.html
> code at 
> bk://developer.osdl.org/osdl-aim-7
> 

OK, I can reproduce this on 4way.

Binary searching (insert gratuitous rant about benchmarks that take more
than two minutes to complete) reveals that the slowdown is due to
sched-2.6.0-test2-mm2-A3.

So mm4 with everthing up to but not including sched-2.6.0-test2-mm2-A3:

	Max Jobs per Minute 1467.06
	Max Jobs per Minute 1478.82
	Max Jobs per Minute 1473.36

	3853.55s user 264.31s system 370% cpu 18:31.95 total

After adding sched-2.6.0-test2-mm2-A3:

        Max Jobs per Minute 1375.63
        Max Jobs per Minute 1278.40
        Max Jobs per Minute 1293.11

        4416.70s user 275.61s system 374% cpu 20:53.58 total

A 10% regression there, mainly user time.


The test is:

- build bk://developer.osdl.org/osdl-aim-7

- cd src

- time ./reaim -s4 -q -t -i4 -f./workfile.new_dbase -r3 -b -l./reaim.config



