Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbUCOXNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbUCOXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:13:32 -0500
Received: from bhhdoa.org.au ([216.17.101.199]:53777 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S262839AbUCOXNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:13:24 -0500
Message-ID: <1079393493.40563cd58fbed@vds.kolivas.org>
Date: Tue, 16 Mar 2004 10:31:33 +1100
From: Con Kolivas <kernel@kolivas.org>
To: Kurt Garloff <garloff@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bonus inheritance
References: <20040315225459.GY4452@tpkurt.garloff.de>
In-Reply-To: <20040315225459.GY4452@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kurt Garloff <garloff@suse.de>:

> Hi Nick, Con,

Hi Kurt.

> I believe we need something similar in 2.6.
> The first part is attached: The bonus inheritance is implemented as
> inheritance, daring the value to the center instead of the minimum.
> I put inheritance to 80 to more closely resemble current 2.6.

> For the second part, I'm unsure. The current tweaks in the scheduler
> may already have the non-linear property that I believe we need.
> I'll need to reread the code to fully understand it though.

The estimator in 2.6 mainline is nothing like the 2.4 one. Most freshly forked
processes get rapidly elevated to just below fully interactive state in a non
linear fashion and thus are usually much better priority than any running cpu
bound process. Watch top during a kernel compile and starting new apps. You'll
see cpu bound tasks hover between PRI 20 and 25, fully interactive tasks hover
at 15-16 and newly forked processes start around 17. This is intentional as
allowing them to elevate fully to interactive means that disk activity would
fool the cpu scheduler into thinking a cpu bound task is fully interactive, so
they are better than fully cpu bound, but slightly worse than already running
interactive tasks until they declare themselves clearly.

Con
