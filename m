Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbUKBN6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbUKBN6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUKBN5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:57:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63649 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262247AbUKBMvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:51:12 -0500
Date: Tue, 2 Nov 2004 13:52:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] optional non-interactive mode for cpu scheduler
Message-ID: <20041102125218.GH15290@elte.hu>
References: <41871BA7.6070300@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41871BA7.6070300@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> optional non-interactive mode for cpu scheduler

i think the following scheme would work better:

 - introduce a new SCHED_CPUBOUND policy
 - return ->static_prio + 5 for such tasks
 - keep their timeslice based off ->static_prio

the point is this: such tasks would thus be automatically and
perpetually considered 'CPU hogs'. Applications cannot abuse this
mechanism because they get the maximum 'penalty'.

and as a bonus, no magic sysctl and inherently more flexibility.

(note that this scheme has advantages above nice +5 because nice +5
still has the interactivity stuff on which can create priority
fluctuations and may thus affect workloads.)

if you agree with this scheme, would you be interested in implementing
this?

	Ingo
