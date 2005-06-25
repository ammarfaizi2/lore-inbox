Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVFYEB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVFYEB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbVFYEB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:01:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48531 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261432AbVFYEBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:01:23 -0400
Date: Sat, 25 Jun 2005 06:00:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <20050625040052.GB4800@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu> <344410000.1119646572@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344410000.1119646572@flay>
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


* Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:

> > is the only problem the unsyncedness? That should be fine as far as the 
> > scheduler is concerned. (we compensate for per-CPU drifts)
> 
> Well, I think so. But I don't see how you're going to compensate for 
> large-scale unsynced-ness safely. I've always completely avoided the 
> TSC altogether on NUMA-Q ... would prefer to keep it that way. We got 
> lots of wierd random crashes, panics, hangs, and -ve time offsets 
> returned from userspace time commands last time I tried it.

ok. Would be nice to check whether reverting that single change solves 
the boot problem. If it does i'll switch the measurement method to be 
do_gettimeoffset based, that way the measurement will still be accurate.  
(which is needed for precise migration cost results) Right now the 
calibration uses sched_clock() - which was the reason for the change.

(btw., if the TSC is that unreliable on numaq boxes, shouldnt we disable 
it for userspace apps too? Or are those hangs purely kernel bugs? In 
which case it might make sense to debug those a bit more - large-scale 
TSC unsyncedness is something that could slip in on other hardware too.)

	Ingo
