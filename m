Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUFGPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUFGPVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUFGPVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:21:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:49544 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264781AbUFGPPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:15:34 -0400
Subject: Re: PREEMPT for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406070737240.1730@ppc970.osdl.org>
References: <16580.7953.94871.281986@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0406070737240.1730@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1086621161.10517.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 10:12:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> doesn't seem to make much sense, since "regs->msr" certainly isn't
> changing, so clearly the above is equivalent to just pushing the whole
> preempt disable into "giveup_altivec()".

regs->msr can be changing. If you preempt between those 2 lines,
another process can steal the altivec or FP unit and your "regs"
wille be affected.

> The most _common_ bug (and the one I don't see any code for at all in your
> patch) is stuff that knows which CPU it is on, or that reads actual
> special CPU registers and acts on them. The other thing to look out for is
> anything that gets the CPU number: use "get_cpu() + put_cpu()" rather than
> "smp_processor_id()".
> 
> 		Linus
> 
> ** Sent via the linuxppc64-dev mail list. See http://lists.linuxppc.org/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

