Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbTAQJhF>; Fri, 17 Jan 2003 04:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbTAQJhF>; Fri, 17 Jan 2003 04:37:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:34536 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267285AbTAQJhF>;
	Fri, 17 Jan 2003 04:37:05 -0500
Date: Fri, 17 Jan 2003 01:47:11 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, rml@tech9.net, mingo@elte.hu
Subject: Re: [PATCH][2.5] per-CPU task runqueues
Message-Id: <20030117014711.6ba112e9.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301170415000.24250-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0301170415000.24250-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 09:45:56.0872 (UTC) FILETIME=[3BE83080:01C2BE0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> wrote:
>
> This patch simply switches over to per-CPU runqueues as defined by the new 
> per cpu api.
> ...
> +static DEFINE_PER_CPU(struct runqueue, runqueues);

These must be initialised to something.  gcc-2.91/92 bug.  There is a
build-time check for this, but it only detects the mistake if you're using a
compiler which has the bug.


Your patch works here, but I was never able to get this working when the
per-cpu areas were allocated as the CPU's come online, which is something we
kinda should work towards.  This patch would need to be reverted if we try to
do that again.  Which is a shame, because appreciable amounts of memory would
be saved if nr_cpus < NR_CPUS.   scheduler startup is fragile..

I don't think it buys us a lot, really.  These structures are so humongous
that we don't get much per-cpuness in accessing them.

