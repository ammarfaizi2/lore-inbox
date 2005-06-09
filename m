Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVFIL52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVFIL52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVFIL52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:57:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2726 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262356AbVFIL5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:57:23 -0400
Date: Thu, 9 Jun 2005 13:55:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050609115547.GA12744@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42A7135C.5010704@cybsft.com> <42A72A53.5050809@cybsft.com> <1118306872.10717.38.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118306872.10717.38.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> > # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> > 
> > it seems to work fine. With the above enabled it hangs on both of my SMP 
> > systems as described above. :-/
> 
> Same problem here. OK unsetting the CONFIG_DEBUG_RT_LOCKING_MODE.

this one should be fixed in the latest patch. (note that when 
DEBUG_RT_LOCKING_MODE is set the spinlocks/rwlocks default to 
non-preemptible. You can set preemption it via 
/proc/sys/kernel/preempt_locks. You normally dont want to enable this 
option.)

> I have another problem :
> I can't boot. 

could you try the latest (-48-03) patch? I fixed a couple of things that 
might impact SMP booting.

> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ...  <======= freeze
> 
> Is it a problem or a CONFIG parameter ?

a freeze is always a problem, whether it can be worked around via a 
CONFIG parameter or not. Generally if you see any reduction in 
functionality that deviates from the stock Linux kernel, it's a bug.

	Ingo
