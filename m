Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932194AbWFDIe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWFDIe3 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWFDIe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:34:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:11229 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932194AbWFDIe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:34:29 -0400
Date: Sun, 4 Jun 2006 10:33:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060604083351.GA6467@elte.hu>
References: <20060601183836.d318950e.akpm@osdl.org> <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com> <20060602142009.GA10236@elte.hu> <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com> <20060602205332.GA5022@elte.hu> <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com> <20060603071301.GB19257@elte.hu> <20060603144121.GA3701@elte.hu> <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com> <986ed62e0606031929g41ad18fbrb1788c26da86287f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606031929g41ad18fbrb1788c26da86287f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5127]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Barry K. Nathan <barryn@pobox.com> wrote:

> Yes, the latest combo patch works. It still gives the warning, too 
> (copied here since it looks slightly different with the latency trace 
> patch added):

> I've posted the /proc/latency_trace here:
> http://members.cox.net/barrykn/linux/trace/latency_trace.bz2

ok, thanks - this pinpointed the problem. I have just sent the fix for 
that (against -mm3), does your networking card still work with that 
patch applied, and if yes, is the lock validator silent on your box now? 

Btw., the easiest way to find out whether there's a lockdep problem on 
your box is to grep for debug_locks in /proc/lockdep_stats - it should 
still be on 1. If there's a warning, it goes to 0. That is an easy to 
script flag.

> It turns out that I was *way* off on the size in my last mail. It's
> actually close to 9MB decompressed, 370K bz2-compressed.

heh ;) Yeah. But it does tell us everything (and much more) about the 
immediate history of any particular bug.

	Ingo
