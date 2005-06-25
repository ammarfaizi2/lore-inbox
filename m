Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263370AbVFYJKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbVFYJKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 05:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVFYJKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 05:10:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13984 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263370AbVFYJKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 05:10:13 -0400
Date: Sat, 25 Jun 2005 11:09:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <20050625090941.GB27073@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu> <344410000.1119646572@flay> <20050625040052.GB4800@elte.hu> <44570000.1119681732@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44570000.1119681732@[10.10.2.4]>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> > (btw., if the TSC is that unreliable on numaq boxes, shouldnt we disable 
> > it for userspace apps too? Or are those hangs purely kernel bugs? In 
> > which case it might make sense to debug those a bit more - large-scale 
> > TSC unsyncedness is something that could slip in on other hardware too.)
> 
> Well it reads reliably. it just reliably reads utter random crap 
> (well, across CPUs). Not many things read tsc from userspace, and it 
> won't hang I guess .... depends what their expecations are. I do like 
> gettimeofday not to go backwards though - that tends to bugger things 
> up ;-)

the patch only adds the TSC back for purposes of sched_clock() (whose 
call sites are robust against cross-CPU migration) - gettimeofday() is 
still using the PIT or HPET.

but i intended this to be an problem-free change - if it causes any 
problems i'll switch the code to use gettimeofday() and not the 
[thus-]lower-accuracy sched_clock().

	Ingo
