Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUFQNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUFQNDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUFQNDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:03:39 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:690 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266479AbUFQNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:03:34 -0400
Date: Thu, 17 Jun 2004 22:04:49 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040617121356.GA24338@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Message-id: <CBC4546BAB9F1Aindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617121356.GA24338@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 14:13:56 +0200, Ingo Molnar wrote:

>but there's another possible method (suggested by Alan Cox) that
>requires no changes to the timer API hotpaths: 'clear' all timer lists
>upon a crash [once all CPUs have stopped and irqs are disabled] and just
>let the drivers use the normal timer APIs. Drive timer execution via a
>polling method.
>
>this basically approximates your polling based implementation but uses
>the existing kernel timer data structures and timer mechanism so should
>be robust and compatible. It doesnt rely on any previous state (because
>all currently pending timers are discarded) so it's as crash-safe as
>possible.
>
>what do you think?
>

It sounds good because change of timer/tasklet code is not needed.
But, I wonder whether this method is safe. For example, if kernel 
crashes because of problem of timer, clearing lists may be dangerous 
before dumping. Is it possible to clear all timer lists safely?

Best Regards,
Takao Indoh
