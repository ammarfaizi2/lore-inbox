Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUHILWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUHILWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 07:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUHILWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 07:22:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15269 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266476AbUHILWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 07:22:05 -0400
Date: Mon, 9 Aug 2004 12:45:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] inode-lock-break.patch, 2.6.8-rc3-mm2
Message-ID: <20040809104533.GA13710@elte.hu>
References: <20040809102125.GA12391@elte.hu> <20040809032523.40250fe8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809032523.40250fe8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > tested on x86, the patch solves these particular latencies.
> 
> On uniprocessor only.  What are we going to do about SMP?

i believe we should 'ignore' SMP spinlock starvation for now: it will be
fixed in a natural way with the most-spinlocks-are-mutexes solution,
with that approach all preemption wishes of other CPUs are properly
expressed in terms of need_resched().

alternatively the 'release the lock every 128 iterations and do a
cpu_relax()' hack could be used - but i think that doesnt solve the SMP
issues in a sufficiant way.

	Ingo
