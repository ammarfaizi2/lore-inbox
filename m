Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263883AbTLTLUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTLTLUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:20:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16855 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263883AbTLTLUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:20:11 -0500
Date: Sat, 20 Dec 2003 12:19:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031220111917.GA18267@elte.hu>
References: <1071864709.1044.172.camel@localhost> <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au> <200312201355.08116.kernel@kolivas.org> <1071891168.1044.256.camel@localhost> <3FE3C6FC.7050401@cyberone.com.au> <1071893802.1363.21.camel@localhost> <3FE3D0CB.603@cyberone.com.au> <1071897314.1363.43.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071897314.1363.43.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Meder <chris@onestepahead.de> wrote:

> That would leave me with two possibilities: 2.6. is doing something
> different in the gnomemeeting case or gnomemeeting is doing something
> different in the 2.6 case. A cursory look at the gnomemeeting sources
> didn't give me the impression that it's doing anything which would be
> affected by 2.6 deployment but I'll ask on the gnomemeeting-devel list
> for advice.

yep, i've looked at the source too and it doesnt do anything that 
changed in 2.6 from an interactivity POV.

To analyze the precise workload that hurts gnomemeeting, could you try
the following workload:

	main()
	{
		for (;;) sched_yield();
	}

and run 1-2 copies of such a load-generator - does it degrade
gnome-meeting audio just as much as eg. a kernel compile does?

as a next step, does the following degrade gnomemeeting?:

	main()
	{
		for (;;) ;
	}

my guess would be that if the yield() one degrades interactivity too
then this is unlikely to be somehow related to the scheduler proper.

If it doesnt degrade but the simple non-yield loop above does, then it's
probably something scheduling related in the sound architecture. (eg. 
use of yield() by some codepath of the sound drivers - although they
dont seem to be doing anything like this.)

If neither of these workloads degrades gnomemeeting, but a kernel-make
does, then it's the interactivity estimator.

    Ingo
