Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270085AbTG3KfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTG3KfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:35:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6024 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270085AbTG3KfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:35:17 -0400
Date: Wed, 30 Jul 2003 12:34:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, <linas@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730083726.GE23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Andrea Arcangeli wrote:

> I never did any 2.6 patch, so it maybe a different thing what you've
> seen, not what I applied to 2.4. Infact even the 2.4 patch isn't from
> me.

the 2.4 timer-scalability patches do have a problem: due to TIMER_BH the
actual timer expiry can happen on a different CPU, which opens up a
del_timer()/add_timer() race in the itimer code. Your patch closes that
hole.

But on 2.6 the timer will run precisely on the CPU it was added, so i
think the race is not possible.

	Ingo

