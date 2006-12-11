Return-Path: <linux-kernel-owner+w=401wt.eu-S1761865AbWLKVR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761865AbWLKVR0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762594AbWLKVR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:17:26 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:53118 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761865AbWLKVRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:17:25 -0500
Date: Mon, 11 Dec 2006 13:17:25 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: john stultz <johnstul@us.ibm.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>
Subject: Re: rdtscp vgettimeofday
In-Reply-To: <20061211003904.GB5366@opteron.random>
Message-ID: <Pine.LNX.4.64.0612111302440.22490@twinlark.arctic.org>
References: <20061129025728.15379.50707.sendpatchset@localhost>
 <20061129025752.15379.14257.sendpatchset@localhost> <20061211003904.GB5366@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Andrea Arcangeli wrote:

> As far as I can see, many changes happened but nobody has yet added
> the rdtscp support to x86-64. rdtscp finally solves the problem and it
> obsoletes hpet for timekeeping and it allows a fully userland
> gettimeofday running at maximum speed in userland.

rdtscp doesn't solve anything extra which can't already be solved with 
existing vgetcpu (based on lsl) and rdtsc.  which have the advantage of 
working on all x86, not just the (currently) rare revF opteron.

lsl-based vgetcpu is relatively slow (because it is a protected 
instruction with lots of microcode) -- but there are other options which 
continue to work on all x86 (see <http://lkml.org/lkml/2006/11/13/401>).


> Before rdtscp we could never index the rdtsc offset in a proper index
> without being in kernel with preemption disabled, so it could never
> work reliably.

even with rdtscp you have to deal with the definite possibility of being 
scheduled away in the middle of the computation.  arguably you need to 
deal with the possibility of being scheduled away *and* back again to the 
same cpu (so testing cpu# at top and bottom of a loop isn't sufficient).

suleiman proposed a per-cpu scheduling event number to deal with that... 
not sure what folks think of that idea.

-dean
