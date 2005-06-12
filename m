Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFLTa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFLTa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVFLTaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:30:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17540 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261812AbVFLTJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 15:09:45 -0400
Date: Sun, 12 Jun 2005 21:02:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Daniel Walker <dwalker@mvista.com>, Esben Nielsen <simlo@phys.au.dk>,
       Linux Kernel <linux-kernel@vger.kernel.org>, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050612190241.GA29708@elte.hu>
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com> <Pine.LNX.4.61.0506120926331.15684@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506120926331.15684@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zwane Mwaikambo <zwane@fsmlabs.com> wrote:

> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles. The current 
> > method does "lea" which takes 1 cycle, and "or" which takes 1 cycle. I'm 
> > not sure if there is any function call overhead .. So the soft replacment 
> > of cli/sti is 70% faster on a per instruction level .. So it's at least 
> > not any slower .. Does everyone agree on that?
> 
> Well you also have to take into account the memory access, so it's not 
> always that straightforward.

preempt_count resides in the first cacheline of 'current thread info' 
and is almost always cached. It's the same cacheline that 'current', 
'smp_processor_id()' are using.

	Ingo
