Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbULOAkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbULOAkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULOAjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:39:39 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:38607 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261729AbULOAhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:37:37 -0500
Date: Wed, 15 Dec 2004 01:37:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Martin =?utf-8?Q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>,
       Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       chris@tebibyte.org, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041215003707.GW16322@dualathlon.random>
References: <41A08765.7030402@ribosome.natur.cuni.cz> <1101045469.23692.16.camel@thomas> <1101120922.19380.17.camel@tglx.tec.linutronix.de> <41A2E98E.7090109@ribosome.natur.cuni.cz> <1101205649.3888.6.camel@tglx.tec.linutronix.de> <41BF0F0D.4000408@ribosome.natur.cuni.cz> <20041214173858.GJ16322@dualathlon.random> <1103067018.5420.37.camel@npiggin-nld.site> <20041214235549.GT16322@dualathlon.random> <1103069783.3406.97.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103069783.3406.97.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 01:16:23AM +0100, Thomas Gleixner wrote:
> It solves one of the problems, but your fix is really the only complete
> fix I have in hands since this thread(s) started. + my simple changes to
> the whom to kill selection :)

That patch prevents the machine to trigger "early" "suprious" oom kills
(I had reports of suprious oom kills myself, oom killer triggered
despite lots of swapcache was freeable), so it cannot help when a true
oom happens like with your workload. In your workload the oom isn't
a suprious error.

The two patches to apply are out there (you posted a version that merges
both of them and doesn't even require to fix the caller of alloc_pages
that should be using GFP_ATOMIC instead of GFP_KERNEL). I would like to
fix those callers too from my part ;), but I understand if it's not
something for a mainline kernel (at least I'm very glad I didn't have to
find this bug in the drivers the hard way ;).
