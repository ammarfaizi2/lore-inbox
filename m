Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUGSKrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUGSKrL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUGSKrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:47:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51131 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264965AbUGSKrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:47:07 -0400
Date: Mon, 19 Jul 2004 12:29:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040719102954.GA5491@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712174639.38c7cf48.akpm@osdl.org>
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

> >  Should I try ext3?
> 
> ext3 is certainly better than that, but still has a couple of
> potential problem spots.  ext2 is probably the best at this time.

with the voluntary-preempt patch applied ext3 is below ~500 usecs for
all things i tried on a 2GHz CPU. Without the patch i can trigger
latencies up to milliseconds (even with CONFIG_PREEMPT) by triggering a
bigger commit stream via some large file write or a cached du / causing
a stream of atime updates. (I very much suspect that all other
journalled filesystems have similar problems and they'll need
measurements and fixing just like ext3 does.)

another bigger problem area is the VM - see my patch for details. 
pagetable zapping and page reclaim are both problematic and need fixups
even under CONFIG_PREEMPT. Doing a simple 'make -j' kernel build that
hits swap triggers these easily. (after applying my patch the latencies
go below 1msec even with a 'make -j' overload.)

	Ingo
