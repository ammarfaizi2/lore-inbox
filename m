Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUCSJt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCSJt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:49:56 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57251 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262079AbUCSJtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:49:55 -0500
Date: Fri, 19 Mar 2004 10:50:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
Message-ID: <20040319095047.GA6301@elte.hu>
References: <40525C1F.5030705@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40525C1F.5030705@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <piggin@cyberone.com.au> wrote:

> volanomark (MPS):
> This one starts getting huge mmap_sem contention at 150+ coming
> from futexes. Don't know what is taking the mmap_sem for writing.
> Maybe just brk or mmap.

are you sure it's down_write() contention? down_read() can create
contention just as much, simply due to the fact that hundreds of threads
and a dozen CPUs are pounding in on the same poor lock.

i do think there should be a rw-semaphore variant that is per-cpu for
the read path. (This would also fix the 4:4 threading overhead.)

	Ingo
