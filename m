Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbVLWUjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVLWUjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbVLWUjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:39:25 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:7882 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161043AbVLWUjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:39:24 -0500
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost a
	preemption check!
From: Steven Rostedt <rostedt@goodmis.org>
To: John Rigg <lk@sound-man.co.uk>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20051223174744.GA4518@localhost.localdomain>
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com>
	 <1135352277.6652.2.camel@localhost.localdomain>
	 <20051223174744.GA4518@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 15:38:41 -0500
Message-Id: <1135370321.5774.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 17:47 +0000, John Rigg wrote:
> On Fri, Dec 23, 2005 at 10:37:57AM -0500, Steven Rostedt wrote:
> > OK, I just found an SMP bug, and here's the patch.  Maybe this will help
> > you kr.  I'm currently running x86_64 SMP with 2.6.15-rc5-rt4 with this
> > and my softirq-no-hrtimers patch I sent earlier.
> 
> It still doesn't boot here. Below is the bootmessage from serial console and
> my .config. The boot message looks pretty much the same as before the smp
> bug patch was applied (I've checked that it was actually applied). It's
> failing before it reaches CPU1 initialisation.
> 
> John
> ___________________________________________________________

> CONFIG_NUMA=y
> CONFIG_RWSEM_GENERIC_SPINLOCK=y
> CONFIG_K8_NUMA=y
> CONFIG_X86_64_ACPI_NUMA=y

OK, here's your problem (I didn't notice this at first and went through
a series of printks to see this).   NUMA isn't supported yet by -rt.
Turn it off and give it another try.

-- Steve


