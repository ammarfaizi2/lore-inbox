Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWAJKFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWAJKFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWAJKFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:05:11 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52716 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751036AbWAJKFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:05:10 -0500
Date: Tue, 10 Jan 2006 11:05:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rt2 - repeatable xrun - no good data in trace
Message-ID: <20060110100517.GA23255@elte.hu>
References: <5bdc1c8b0601081252x59190f1ajcb5514364d78a4e@mail.gmail.com> <43C17E50.4060404@stud.feec.vutbr.cz> <Pine.LNX.4.61.0601082247170.17804@yvahk01.tjqt.qr> <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0601081404n2a163ce1ya21919800546dfc8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> > cdrecord does run with SCHED_RR/99 when started with proper privileges.
>
> Ah, then it's likely that this isn't a real problem and it would be 
> expected to cause an xrun?
> 
> Anyway, it seems strange that the trace doesn't show anything. I 
> suppose that's because cdrecord just grabs a lot of time at a higher 
> priority than Jack and Jack ends up not getting serivces at all for 
> 5-10mS?

the tracer will only detect undue delays in the 'highest prio' task in 
the system - but it cannot detect whether all priorities in the system 
are given out properly. In this particular case it was cdrecord that had 
the highest priorities, and the delays you saw in Jackd were due to 
cdrecord trumping Jackd's priority.

One way to make such scenarios easier to notice & debug would be for 
jackd to warn if there are tasks in the system that have higher
priorities. (maybe it could even do it at xrun time, from a lower-prio 
thread.)

	Ingo
