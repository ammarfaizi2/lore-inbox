Return-Path: <linux-kernel-owner+w=401wt.eu-S1762600AbWLKAiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762600AbWLKAiI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 19:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762594AbWLKAiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 19:38:07 -0500
Received: from ns.suse.de ([195.135.220.2]:57265 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762595AbWLKAiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 19:38:06 -0500
Date: Mon, 11 Dec 2006 01:39:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
       mingo@elte.hu, Suleiman Souhlal <ssouhlal@FreeBSD.org>
Subject: rdtscp vgettimeofday
Message-ID: <20061211003904.GB5366@opteron.random>
References: <20061129025728.15379.50707.sendpatchset@localhost> <20061129025752.15379.14257.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129025752.15379.14257.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As far as I can see, many changes happened but nobody has yet added
the rdtscp support to x86-64. rdtscp finally solves the problem and it
obsoletes hpet for timekeeping and it allows a fully userland
gettimeofday running at maximum speed in userland.

Before rdtscp we could never index the rdtsc offset in a proper index
without being in kernel with preemption disabled, so it could never
work reliably.

What's the status of the DSO API? Does it break backwards
compatibility or is the production glibc already capable of handling
that new kernel API?

I need rdtscp working on vsyscalls ASAP, but I should first understand
if I need to base my code on top of the vDSO patch or if to fork it
off in a dead branch to preserve backwards compatibility with current
glibc userland.

Thanks.
