Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUEPVTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUEPVTi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbUEPVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:19:37 -0400
Received: from nacho.zianet.com ([216.234.192.105]:28689 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S264817AbUEPVTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:19:34 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sun, 16 May 2004 15:19:03 -0600
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405132232.01484.elenstev@mesatop.com> <200405160928.22021.elenstev@mesatop.com> <20040516203818.GY3044@dualathlon.random>
In-Reply-To: <20040516203818.GY3044@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161519.03834.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 02:38 pm, Andrea Arcangeli wrote:
> On Sun, May 16, 2004 at 09:28:21AM -0600, Steven Cole wrote:
> > Andrea, I did see a significant slowdown with Andy's test script (with DMA on)
> > on my timed test of 2.6.6-current vs 2.6.3.
> 
> 2.6.3 is quite old, as Andrew is wondering about, this is more likely a
> vm heuristic issue if something, it cannot be anon-vma related.
> 
> btw, if you've 2.6.3 you should download just two patches to go to
> 2.6.5.
> 
> 
Sure, but I also wanted to beat the ppp paths while I did other things.
I've been using bk to keep a current kernel, and my older source
trees were sitting on another (disconnected) disk.  The 2.6.3 is
the vendor kernel.

That download succeeded, better than I've experienced for a long
time, possibly due to not having PREEMPT set.  With PREEMPT and
2.6.x kernels, I had been getting this, and ppp would stop moving data.

May 13 18:09:30 spc kernel: serial8250: too much work for irq10

I did build boot and run 2.6.5-aa5 (which had -aa4 in the EXTRAVERSION),
but the results for the bk exerciser script were similar to 2.6.6-current:

-----------------------------
2.6.6-current:

time bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
290.48user 96.76system 15:00.85elapsed 42%CPU 

(cd foo; time bk pull -q)
402.74user 254.98system 23:25.43elapsed 46%CPU 
------------------------------
2.6.5-aa5:

time bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
290.78user 94.29system 16:06.73elapsed 39%CPU 

(cd foo; time bk pull -q)
401.82user 234.05system 23:36.32elapsed 44%CPU 

------------------------------
2.6.3-4mdk (repeated run)

time bk clone -qlr40514130hBbvgP4CvwEVEu27oxm46w testing-2.6 foo
288.71user 58.47system 10:57.37elapsed 52%CPU 

(cd foo; time bk pull -q)
397.94user 186.18system 17:24.73elapsed 55%CPU 

Anyway, although the regression for my particular machine for this
particular load may be interesting, the good news is that I've seen
none of the failures which started this whole thread, which are relatively
easily reproduceable with PREEMPT set.  

Perhaps  PREEMPT should be renamed to BUG_FLUSH. :)

Steven
