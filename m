Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUHPDcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUHPDcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUHPDcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:32:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48301 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267394AbUHPDcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:32:19 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816030053.GA10323@elte.hu>
References: <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu>
	 <20040816030053.GA10323@elte.hu>
Content-Type: text/plain
Message-Id: <1092627186.867.145.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:33:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:00, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > could this be some DMA starvation effect? Or is this xrun calculated
> > from arrival of the audio interrupt (hence DMA completion) to the
> > actual running of jackd?
> 
> would there be a way to find out what portion of the xrun is caused by
> latencies of the audio card (DMA, etc.) vs. latency from the point jackd
> is woken up by the sound-driver to the point jackd preempts the mlock
> process and runs?
> 

WHat is being measured is the length of time between jackd is woken up
and when it runs - the xrun report prints the difference between the
current time and the timestamp returned by
snd_pcm_status_get_trigger_tstamp (updated by the interrupt handler) and
the current time.

jackd prints a different error message if it detects that the interrupt
handler was delayed, this is a separate issue than an xrun.  I have seen
this happen before, but I don't think this is going on here.

Lee



