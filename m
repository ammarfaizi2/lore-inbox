Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVEDVde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVEDVde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVEDVde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:33:34 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:30654 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261665AbVEDVd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:33:29 -0400
From: Ulrich Weigand <uweigand@de.ibm.com>
Message-Id: <200505042133.j44LX8Xk010820@53v30g15.boeblingen.de.ibm.com>
Subject: Re: Again: UML on s390 (31Bit)
To: bstroesser@fujitsu-siemens.com
Date: Wed, 4 May 2005 23:33:08 +0200 (CEST)
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Stroesser wrote:

>Unfortunately, I guess this will not help. But maybe I'm missing
>something, as I don't even understand, what the effect of the
>attached patch should be.
Have you tried it?

>AFAICS, after each call to do_signal(),
>entry.S will return to user without regs->trap being checked again.
>do_signal() is the only place, where regs->trap is checked, and
>it will be called on return to user exactly once.
It will be called multiple times if *multiple* signals are pending,
and this is exactly the situation in your problem case (some other
signal is pending after the ptrace intercept SIGTRAP was delievered).

>So a practical solution should allow to reset regs->trap while the
>child is on the first or second syscall interception.
This is exactly what this patch is supposed to do: whenever during
a ptrace intercept the PSW is changed (as it presumably is by your
sigreturn implementation), regs->trap is automatically reset.

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  Linux on zSeries Development
  Ulrich.Weigand@de.ibm.com
