Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGaKnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGaKnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVGaKnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 06:43:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31626 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261629AbVGaKnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 06:43:32 -0400
Date: Sun, 31 Jul 2005 12:44:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050731104418.GA5318@elte.hu>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins> <20050730205259.GA24542@elte.hu> <1122796996.15033.9.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122796996.15033.9.camel@twins>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> because end_buffer_async_read/write use bit_spin_(un)lock and I do not 
> know how those interact with -RT.

bit_spin_lock is preemptible too - but it's not a too nice construct.  
What seems to have happened in your trace is that local_irq_disable() 
was used too in combination with bit-spinlocks, and a spinlock was taken 
from within it. The best fix would be to get rid of bit-spinlocks ...

	Ingo
