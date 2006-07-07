Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWGGQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWGGQgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWGGQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:36:31 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61690 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932219AbWGGQga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:36:30 -0400
Date: Fri, 7 Jul 2006 18:36:22 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060707183622.6897375d@cad-250-152.norway.atmel.com>
In-Reply-To: <44AE1690.5070509@yahoo.com.au>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<44AE1690.5070509@yahoo.com.au>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 18:08:48 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> need_resched() translates to a test_bit, which doesn't have any
> barriers, so it could be optimised away completely. And if you're
> intending to use preempt, you need to have preemption disabled in the
> idle loop.

Actually, preemption seems to be disabled when entering cpu_idle(), but
it must be enabled around the call to schedule(). That explains the
"scheduling while atomic" storm we saw when enabling CONFIG_PREEMPT
anyway.

CONFIG_PREEMPT support is one of the things still missing, btw. I'll
implement that next, now that genirq seems to be working.

> Documentation/sched-arch.txt attempts to explain, and  something like
> arm26's cpu_idle() is a nice, simple example to follow.

I'll do that. Thanks.

Håvard
