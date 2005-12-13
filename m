Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVLMW2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVLMW2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVLMW2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:28:07 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:39619 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030251AbVLMW2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:28:05 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: paulmck@us.ibm.com
Cc: Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ] 
In-reply-to: Your message of "Tue, 13 Dec 2005 08:20:27 -0800."
             <20051213162027.GA14158@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Dec 2005 09:27:41 +1100
Message-ID: <17158.1134512861@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005 08:20:27 -0800, 
"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>If the variable p references MMIO rather than normal memory, then
>wmb() and rmb() are needed instead of smp_wmb() and smp_rmb().

mmiowb(), not wmb().  IA64 has a different form of memory fence for I/O
space compared to normal memory.  MIPS also has a non-empty form of
mmiowb().

>This is because the I/O device needs to see the accesses ordered
>even in a UP system.

Why does mmiowb() map to empty on most systems, including Alpha?
Should it not map to wmb() for everything except IA64 and MIPS?

