Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUG2SYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUG2SYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267513AbUG2SWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:22:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60618 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264526AbUG2SUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:20:15 -0400
Date: Thu, 29 Jul 2004 20:21:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scott@timesys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729182110.GA16419@elte.hu>
References: <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040722185308.GC4774@yoda.timesys> <20040722194513.GA32377@nietzsche.lynx.com> <20040728064547.GA16176@elte.hu> <20040728205211.GC6685@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728205211.GC6685@yoda.timesys>
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


* Scott Wood <scott@timesys.com> wrote:

> Those critical sections where lock-breaking has been done can be
> converted back into spinlocks.  Essentially, mutexes would be used for
> "untrusted" locks, as opposed to using spinlocks just where they're
> absolutely necessary.  Over time, the set of trusted locks would
> presumably go up, though we'd have to be careful to make sure people
> know that they need to be especially careful of latency issues when
> they touch code that uses such locks.
> 
> One of the main benefits is that it significantly increases the RT
> guarantees for those users for whom the RT portion of their app can be
> verified as only using a limited, testable/auditable subset of kernel
> paths. [...]

ok, i see - this makes 100% sense. I'm wondering how intrusive such an
all-preemptive patchset is? There are some problems with per-CPU data
structures on SMP. Right now holding a spinlock means one can use
smp_processor_id() and rely on it staying constant in the critical
section. With a mutex in the same place all such assumptions would
break. Is there some automatic way to deal with these issues (or to at
least detect them reliably?).

	Ingo
