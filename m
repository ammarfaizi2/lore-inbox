Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVFLALK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVFLALK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 20:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVFLALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 20:11:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41711 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261858AbVFLALH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 20:11:07 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: tglx@linutronix.de
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <1118533485.13312.91.camel@tglx.tec.linutronix.de>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
	 <1118533485.13312.91.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 17:09:52 -0700
Message-Id: <1118534993.5593.175.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 01:44 +0200, Thomas Gleixner wrote:
> On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
> 
> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> No, because x86 is not the whole universe
> 

Das Dehnt sich aus.

Even if there is a case of minimal expansion in the overhead on some
architecture, it may justify the effort for a certain class of
applications which require known interrupt response latencies.

The concept model here is, that you will have all interrupts running in
threads, EXCEPT one or more SA_NODELAY real-time IRQs. Those RT-IRQs may
be required to track satellites, manage I/O for a QOS or RF protocol
stack, shut down a SAW, or a variety of RT-related services.

The IRQ-disable-removal allows that the RT-IRQ encounters minimal
delay. 

Often, that IRQ will also wake up a process, and that process may have
some response-time constraints on it, as well.

SO that's one model that is helped by this design.






