Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272796AbTG3Hg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272798AbTG3Hg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:36:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8620 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272796AbTG3Hg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:36:57 -0400
Date: Wed, 30 Jul 2003 09:34:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, <linas@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030730073458.GA23835@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0307300932560.433-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jul 2003, Andrea Arcangeli wrote:

> The thing triggered simply by running setitimer in one function, while
> the it_real_fn was running in the other cpu. I don't see how 2.6 can
> have fixed this, it_real_fun can still trivially call add_timer while
> you run inside do_setitimer in 2.6 too. [...]

This is not a race that can happen. itimer does this:

	del_timer_sync();
	add_timer();

how can the add_timer() still happen while it_real_fn is still running on 
another CPU?

	Ingo

