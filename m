Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUDFRYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 13:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbUDFRYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 13:24:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60115 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262029AbUDFRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 13:24:15 -0400
Date: Tue, 6 Apr 2004 19:24:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040406172431.GA9185@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406155925.GW2234@dualathlon.random>
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


* Andrea Arcangeli <andrea@suse.de> wrote:

> >         http://redhat.com/~mingo/4g-patches/loop_print.c
> 
> loop print does no memory access at all, it just loops forever, [...]

expecting such a reply my first mail already answers this point:

[**] i also repeated the measurements with a d-TLB-intense workload,
     which should be the worst-case, considering the TLB flushes. [the
     workload iterated through #dTLB pages and touched one byte in each
     page.] This added +0.02% overhead in the 1000Hz + PAE case. (just
     at the statistical noise limit).

i just didnt expect your apparent inability to read.

(note that this dTLB test did the worst-case test by looping through
#dTLB pages (and not more), and thus maximizing the slowdown effect of
any TLB flushes. I also tested other workloads, such as
data-cache-intensive and memory-intensive workloads, with similar
results.)

> I simply heard the effect was less visible on PIII than on more recent
> cpus, but maybe that was wrong.

my mail also answers your other point:

    [...] I used a 525 MHz Celeron for testing. The results are
    similar on faster x86 systems.

yes, i did check a P4 CPU too. Plus:

> [...] no surprise at all you get very little slowdown no matter how
> many tlb flushes happens.

contrary to your claim, 90% of the TLB-flush overhead is in fact
upfront, at the time of the cr3 write, in the irq handler. So
loop_print.c will already show 90% of the overhead - and it's by far the
simplest and most stable measurement utility.

(anyway, feel free to reproduce and post contrary results here. The onus
is on you. And if you think i'm upset about your approach to this whole
issue then you are damn right.)

	Ingo
