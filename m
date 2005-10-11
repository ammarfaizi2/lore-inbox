Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVJKLQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVJKLQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVJKLQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:16:29 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:50140 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751454AbVJKLQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:16:28 -0400
Date: Tue, 11 Oct 2005 13:17:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark Knecht <markknecht@gmail.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
Message-ID: <20051011111700.GA15892@elte.hu>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com> <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net> <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com> <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com> <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net> <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com> <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net> <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com> <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Knecht <markknecht@gmail.com> wrote:

> > ( softirq-timer/0-3    |#0): new 3997 us maximum-latency critical section.
> 
> So the root cause of this 4mS delay is the 250Hz timer. If I change 
> the system to use the 1Khz timer then the time in this section drops, 
> as expected, to 1mS.

this was a bug in the critical-section-latency measurement code of x64.  
The timer irq is the one that leaves userspace running for the longest 
time, between two kernel calls.

I have fixed these bugs in -rc4-rt1, could you try it? It should report 
much lower latencies, regardless of PM settings.

	Ingo
