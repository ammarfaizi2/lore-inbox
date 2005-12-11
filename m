Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVLKUGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVLKUGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVLKUGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 15:06:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26312 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750847AbVLKUGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 15:06:21 -0500
Date: Sun, 11 Dec 2005 21:05:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ed Tomlinson <edt@aei.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch -mm] fix SLOB on x64
Message-ID: <20051211200535.GB19322@elte.hu>
References: <20051211141217.GA5912@elte.hu> <200512111222.56067.edt@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512111222.56067.edt@aei.ca>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ed Tomlinson <edt@aei.ca> wrote:

> On Sunday 11 December 2005 09:12, Ingo Molnar wrote:
> > this patch fixes 32-bitness bugs in mm/slob.c. Successfully booted x64 
> > with SLOB enabled. (i have switched the PREEMPT_RT feature to use the 
> > SLOB allocator exclusively, so it must work on all platforms)
> 
> Its a good idea to get this working everywhere.  Why have you switched 
> to use SLOB exclusively?

because the SLAB hacks were getting ugly, and i gave up on it during the 
2.6.15-rc5 merge. (The SLAB code has lots of irqs-off / per-cpu and 
non-preempt assumptions integrated, which were a pain to sort out.)

We'll eventually do a cleaner conversion of SLAB to PREEMPT_RT, but for 
now the SLOB is turned on exclusively if PREEMPT_RT. (in other 
preemption modes it's optionally selectable if EMBEDDED is enabled)

	Ingo
