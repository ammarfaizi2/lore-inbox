Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWC1Vfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWC1Vfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWC1Vfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:35:47 -0500
Received: from www.osadl.org ([213.239.205.134]:22435 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932223AbWC1Vfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:35:46 -0500
Subject: Re: PI patch against 2.6.16-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0603282202250.22822-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0603282202250.22822-100000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 23:36:42 +0200
Message-Id: <1143581802.5344.229.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 22:17 +0100, Esben Nielsen wrote:
> I think we talk about the situation

No, we talk about existing lock chains L(0) --> L(n).

>                         B locks 1            C locks 2       D locks 3
>                         B locks 2, boosts C and block
>       A locks 2
>       A is boost B
>       A drop it's spinlocks and is preempted
>                                              C unlocks 2 and auto unboosts
>                         B is running
>                         B locks 3, boosts C and blocks
>       A gets a CPU again
>       A boosts B
>       A boosts D
> 
> Is there anything wrong with that?
> And in the case where A==D there indeed is a deadlock which will be
> detected.

If you get to L(x) the underlying dependencies might have changed
already as well as the dependencies x ... n. We might get false
positives in the deadlock detection that way, as a deadlock is an
"atomic" state.

	tglx


