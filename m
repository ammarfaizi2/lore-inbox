Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFLD5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFLD5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 23:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVFLD5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 23:57:44 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:23022 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261266AbVFLD5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 23:57:37 -0400
Message-ID: <007a01c56f0a$3f251c80$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <tglx@linutronix.de>, "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Esben Nielsen" <simlo@phys.au.dk>,
       <linux-kernel@vger.kernel.org>, <sdietrich@mvista.com>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com> <1118533485.13312.91.camel@tglx.tec.linutronix.de>
Subject: Re: [PATCH] local_irq_disable removal
Date: Sun, 12 Jun 2005 00:50:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW - STI takes 3,5 and 7 cycles on 386,486, and 386SX respectively (these
are all still popular embedded processors)

Do not forget the impact of instruction size on fetch cost - the "book"
cycle counts are only for instructions ALREADY fetched and in the pipe/queue
and IGNORE the cost of fetching said instruction.  If you happen to get an
L1 hit, you win.  If that LEA or OR stradles a dword or cache line boundary
the CLI/STI may well wind up running faster under combat conditions if line
load or second memory fetch is needed to get the second half of the
instruction.

On an x86 CPU that which appears to be fast per the book clocks is often
slower, and that which appears to clock faster is often slower in reality
due to increased fetch cost of plump instructions.  I have many benchmarks
that prove this.

----- Original Message ----- 
From: "Thomas Gleixner" <tglx@linutronix.de>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>; "Esben Nielsen" <simlo@phys.au.dk>;
<linux-kernel@vger.kernel.org>; <sdietrich@mvista.com>
Sent: Saturday, June 11, 2005 19:44
Subject: Re: [PATCH] local_irq_disable removal


> On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
>
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The
current
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle.

