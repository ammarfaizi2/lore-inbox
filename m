Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266909AbUGMWCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266909AbUGMWCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266911AbUGMWCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:02:02 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:37084 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266909AbUGMWBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:01:45 -0400
Date: Wed, 14 Jul 2004 00:01:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713220103.GJ974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <200407130001.i6D01pkJ003489@localhost.localdomain> <20040712170844.6bd01712.akpm@osdl.org> <20040713162539.GD974@dualathlon.random> <20040713114829.705b9607.akpm@osdl.org> <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713145424.1217b67f.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:54:24PM -0700, Andrew Morton wrote:
> Confused.  Where do we call cond_resched() with local interrupts disabled?

there are a lot of cond_resched, we might be calling it with irq
disabled, nobody ever did a might_sleep in the fast path of
cond_resched. And even if nobody does, if entry.S and sched_yield can
optimize, then everybody else can optimize too. It's not like that
entry.S is a piece of scheduler internal that will be obviously modified
if we modify the scheduler. so if you intend to leave those two there's
no point to forbid others to optimize, and there's no might_sleep in
current cond_resched anyways so you're already allowing people to
optimize and I want to allow it still after I add might_sleep there.

> Sleeping with local interrupts disabled is usually a bug, so we should
> prefer to keep that check in might_sleep().

either it's _always_ a bug including for entry.S or sched_yield, or it's
_never_ a bug. I don't understand the "usually".
