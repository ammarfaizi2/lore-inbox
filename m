Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWGIK5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWGIK5X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGIK5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:57:22 -0400
Received: from khc.piap.pl ([195.187.100.11]:56448 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932312AbWGIK5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:57:22 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<200607080841.38235.chase.venters@clientec.com>
	<m38xn3j1um.fsf@defiant.localdomain>
	<200607081541.07449.chase.venters@clientec.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 09 Jul 2006 12:57:19 +0200
In-Reply-To: <200607081541.07449.chase.venters@clientec.com> (Chase Venters's message of "Sat, 8 Jul 2006 15:40:44 -0500")
Message-ID: <m3odvz3v1s.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

>> Sure, but a barrier alone isn't enough. You have to use assembler and
>> it's beyond scope of C volatile.
>
> Right, which is why volatile is wrong.

In this case (and not only this). Of course. But not always.

> You need the barrier for both the CPU and the compiler.

For spinlocks, yes.

For other things... Sometimes you need a barrier for the compiler
only. Sometimes you don't need any general barrier, you only need
to make sure a single variable isn't being cached (by the compiler).
That's what volatile is for.

Saying that volatile is always wrong looks to me like saying that goto
is always wrong :-) And yes, there are people who say that every single
goto in the universe is wrong.
-- 
Krzysztof Halasa
