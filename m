Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUH2Vdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUH2Vdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268336AbUH2Vdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:33:42 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6829 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268327AbUH2Vdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:33:40 -0400
Subject: Re: interrupt cpu time accounting?
From: Robert Love <rml@ximian.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
In-Reply-To: <413249F7.50904@pobox.com>
References: <41323FA8.80203@pobox.com> <1093814102.2595.8.camel@localhost>
	 <413249F7.50904@pobox.com>
Content-Type: text/plain
Date: Sun, 29 Aug 2004 17:33:40 -0400
Message-Id: <1093815220.2595.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 17:26 -0400, Jeff Garzik wrote:

> What piece of code defines "balanced"?  :)

kernel/sched.c :: load_balance()

We used to try to keep the processors within 25% of each other, and try
very hard to ensure that no processor had zero processes.  The sched
domain code changed all that.

The only place the load balancer will help in your scenario is when the
processor is so busy processing interrupts and processes get backed up
on the processor (new processes moved there or, more likely, via forks).
The load balance won't help if the baseline minimum number of processes
is there but they are starving.

> Less a neat idea, and more IMHO recognition of a problem that needs solving.
> 
> I am worried that processes will get starved if one CPU is _heavily_ 
> loaded servicing interrupts, and the others are not.

If people are seeing it, then I 100% agree.

	Robert Love


