Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264411AbUEXRRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUEXRRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUEXRRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:17:12 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:14269 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264411AbUEXRRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:17:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 24 May 2004 10:16:57 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       rmk+lkml@arm.linux.org.uk
Subject: Re: scheduler: IRQs disabled over context switches
In-Reply-To: <20040524090538.GA26183@elte.hu>
Message-ID: <Pine.LNX.4.58.0405241012300.4174@bigblue.dev.mdolabs.com>
References: <20040523174359.A21153@flint.arm.linux.org.uk> <20040524083715.GA24967@elte.hu>
 <Pine.LNX.4.58.0405232340070.2676@bigblue.dev.mdolabs.com>
 <20040524090538.GA26183@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Ingo Molnar wrote:

> 
> * Davide Libenzi <davidel@xmailserver.org> wrote:
> 
> > We used to do it in 2.4. What changed to make it fragile? The
> > threading (TLS) thing?
> 
> it _should_ work, but in the past we only had trouble from such changes
> (at least in the O(1) tree of scheduling - 2.4 scheduler is OK.). We
> could try the patch below. It certainly boots on SMP x86. But it causes
> a 3.5% slowdown in lat_ctx so i'd not do it unless there are some really
> good reasons.

IMO it is fine, as long as it works with IRQ disabled. There are archs 
where IRQ latencies matters more than lat_ctx times (that BTW are bogus). 
And we already have the infrastructure in place to let the arch to choose 
the way better fits it. Russel reported that a guy trying it (IRQ enabled 
ctx switch) with MIPS was having some problem with it though.


BTW, the unlock_irq should go in prepare not finish.


- Davide

