Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWCNMXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWCNMXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWCNMXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:23:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:53959 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750740AbWCNMXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:23:50 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603142307.01682.kernel@kolivas.org>
References: <1142329861.9710.16.camel@homer>
	 <200603142110.37017.kernel@kolivas.org> <1142337363.9710.29.camel@homer>
	 <200603142307.01682.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 13:24:59 +0100
Message-Id: <1142339099.11303.12.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 23:07 +1100, Con Kolivas wrote:
> On Tuesday 14 March 2006 22:56, Mike Galbraith wrote:
> > With my full change set, you _will_ see differences with interbench.
> > Interbench will say you're better off without my changes in fact.  Run
> > any of the known scheduler exploits without my changes, and then with,
> > and you'll likely consider revising interbench a little methinks ;-)
> 
> Not really; interbench is after interactivity, and exploit prone designs don't 
> necessarily have bad interactivity. If you can reproduce the nfs case as an 
> extra load for interbench I'd love to include it.

Yes, interbench tries to assess interactivity, but it gets it totally
wrong sometimes.  It runs it's measurement at a high priority, and calls
the result good if it was able to get as much cpu as it wants.  The very
code responsible for good interbench numbers is also responsible for
starvation problems.  It's the long sleep logic.  That logic makes my
box suck rocks under thud and irman2.

Don't forget, every one of the exploits I test with were posted by
people who were experiencing scheduler problems in real life.  Try to
use your box while running those exploits, and then tell me that you
agree with interbench's assessment.

	-Mike

