Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVFLA1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVFLA1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 20:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVFLA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 20:27:54 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:26552
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261863AbVFLA1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 20:27:36 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <1118534993.5593.175.camel@sdietrich-xp.vilm.net>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
	 <1118533485.13312.91.camel@tglx.tec.linutronix.de>
	 <1118534993.5593.175.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 12 Jun 2005 02:28:39 +0200
Message-Id: <1118536119.13312.129.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 17:09 -0700, Sven-Thorsten Dietrich wrote:
> Even if there is a case of minimal expansion in the overhead on some
> architecture, it may justify the effort for a certain class of
> applications which require known interrupt response latencies.

Nobody denied that. I'm just cautious about arguments which count
instruction cylces on a given CPU.

> The concept model here is, that you will have all interrupts running in
> threads, EXCEPT one or more SA_NODELAY real-time IRQs. Those RT-IRQs may
> be required to track satellites, manage I/O for a QOS or RF protocol
> stack, shut down a SAW, or a variety of RT-related services.
> 
> The IRQ-disable-removal allows that the RT-IRQ encounters minimal
> delay. 
> 
> Often, that IRQ will also wake up a process, and that process may have
> some response-time constraints on it, as well.
> 
> SO that's one model that is helped by this design.

No problem with that. I have done this already and know about the pro
and cons. 

As I pointed out before, speed is not always the measure.

The point is configurability of features, but OTH you _cannot_ implement
a CONFIG option for each particular spinlock. You have to come down to a
certain set of config options by experimentation or by analysing ofcode
paths. Lot of work to be done though.

tglx




