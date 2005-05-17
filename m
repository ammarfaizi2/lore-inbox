Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEQN6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEQN6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVEQN6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:58:39 -0400
Received: from mail.suse.de ([195.135.220.2]:12730 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261184AbVEQN6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:58:37 -0400
Date: Tue, 17 May 2005 15:58:34 +0200
From: Andi Kleen <ak@suse.de>
To: Joe Korty <joe.korty@ccur.com>
Cc: Christoph Lameter <christoph@lameter.com>,
       Linus Torvalds <torvalds@osdl.org>, randy_dunlap <rdunlap@xenotime.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050517135834.GG9699@wotan.suse.de>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <Pine.LNX.4.62.0505162225260.28022@graphe.net> <20050517134434.GA26822@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517134434.GA26822@tsunami.ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	help
> > +	  100 HZ is a typical choice for servers, SMP and NUMA systems
> > +	  with lots of processors that may show reduced performance if
> > +	  too many timer interrupts are occurring.
> 
> One of the options should mention the power savings benefit on laptops.
> How about:

Actually it is not 100% clear. The ACPI idle code relies on
the timer right now to go from C1 to C2/C3.  It basically
goes down in a staircase, first staying in C1, then when woken
up and still idle go down lower etc.

With HZ=100 the minimal latency (assuming no other interrupts) to go from C1 
to C2 is 10ms, not 1ms, which might be even a power loss in some workloads.

-Andi

P.S.: The SUSE 2.4 kernels had for some time variable HZ, settable at boot. 
It surprisingly didn't cause too much slowdown or code bloat and only
needed minor fixes over the tree. Might be worth considering at least
as a CONFIG

