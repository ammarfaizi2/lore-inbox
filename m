Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVCRQFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVCRQFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVCRQFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:05:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14038 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261660AbVCRQCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:02:45 -0500
Date: Fri, 18 Mar 2005 17:02:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <bhuey@lnxw.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318160229.GC25485@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318125641.GA5107@nietzsche.lynx.com> <20050318131729.GB5107@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318131729.GB5107@nietzsche.lynx.com>
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


* Bill Huey <bhuey@lnxw.com> wrote:

> I'd like to note another problem. Mingo's current implementation of
> rt_mutex (super mutex for all blocking synchronization) is still
> missing reader counts and something like that would have to be
> implemented if you want to do priority inheritance over blocks.

i really have no intention to allow multiple readers for rt-mutexes. We
got away with that so far, and i'd like to keep it so. Imagine 100
threads all blocked in the same critical section (holding the read-lock)
when a highprio writer thread comes around: instant 100x latency to let
all of them roll forward. The only sane solution is to not allow
excessive concurrency. (That limits SMP scalability, but there's no
other choice i can see.)

	Ingo
