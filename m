Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTJOSlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263940AbTJOS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:26:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63949 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263922AbTJOSZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:25:35 -0400
Date: Tue, 14 Oct 2003 13:43:53 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
In-Reply-To: <Pine.LNX.4.44.0310132122160.2156-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.56.0310141339220.17642@earth>
References: <Pine.LNX.4.44.0310132122160.2156-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Oct 2003, Linus Torvalds wrote:

> since the timer may not even _exist_ any more - the act of running the
> timer may well have free'd the timer structure, and you're now zeroing
> memory that may have been re-allocated for something else.

doh, indeed.

i'm happy with the timer->base write ordering fix that addresses the first
race, it fixes the bug that was actually triggered in RL. The other two
races are present too but were present in previous incarnations of the
timer code too. I'll think about them - both rely on racing with timer
expiry itself - which is more likely to trigger these days because the
tick is now 1 msec, and kernel virtualization is more common too, which
can introduce almost arbitrary 'CPU delays' at any point in the kernel.

	Ingo
