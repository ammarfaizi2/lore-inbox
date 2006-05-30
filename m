Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWE3BaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWE3BaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWE3BaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:30:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751561AbWE3B3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:29:47 -0400
Date: Mon, 29 May 2006 18:33:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Ayaz Abdulla <aabdulla@nvidia.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [patch 02/61] lock validator: forcedeth.c fix
Message-Id: <20060529183300.122c671b.akpm@osdl.org>
In-Reply-To: <20060529212313.GB3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212313.GB3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:23:13 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> nv_do_nic_poll() is called from timer softirqs, which has interrupts
> enabled, but np->lock might also be taken by some other interrupt
> context.

But the driver does disable_irq(), so I'd say this was a false-positive.

And afaict this is not a timer handler - it's a poll_controller handler
(although maybe that get called from timer handler somewhere?)

That being said, doing disable_irq() from a poll_controller handler is
downright scary.

Anwyay, I'll tentatively mark this as a lockdep workaround, not a bugfix.
