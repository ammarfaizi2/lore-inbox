Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbUKPW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbUKPW1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKPW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:27:34 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8634 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261841AbUKPW1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:27:33 -0500
Date: Wed, 17 Nov 2004 00:28:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling bugs
Message-ID: <20041116232827.GA842@elte.hu>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A7D09.4080001@bigpond.net.au>
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


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> Couldn't this part of the problem have been solved by using an
> atomic_t for nr_uninterruptible as for nr_iowait?  It would also
> remove the need for migrate_nr_uninterruptible().

maybe, but why? Atomic ops are still a tad slower than normal ops and
every cycle counts in the wakeup path. Also, the solution is still not
correct, because it does not take other migration paths into account, so
we could end up with a sleeping task showing up on another CPU just as
well. The most robust solution is to simply not care about migration and
to care about the total count only.

	Ingo
