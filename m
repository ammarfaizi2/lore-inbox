Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVAUMDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVAUMDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAUMDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:03:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:3459 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262345AbVAUMDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:03:47 -0500
Date: Fri, 21 Jan 2005 13:03:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121120325.GA2934@elte.hu>
References: <20050121100606.GB8042@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121100606.GB8042@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
> Cpushare (until trusted computing will hit the hardware market). 
> [...]

why do you need any kernel code for this? This seems to be a limited
ptrace implementation: restricting untrusted userspace code to only be
able to exec read/write/sigreturn.

So this patch, unless i'm missing something, duplicates in essence what
ptrace can do already here and today, on any Linux box, on any CPU. You
can implement your client based on ptrace alone, just like UML does it -
and UML has much more complex needs than secure isolation.

ptrace ought to be perfectly fine for this, it traps every attempt to do
something privileged. [ptrace had its share of security problems but
_not_ many (if any at all) security problems that allowed a ptrace
client to _break out_ of a ptrace jail.]

	Ingo
