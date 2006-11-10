Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946064AbWKJI6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946064AbWKJI6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946067AbWKJI6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:58:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12942 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1946064AbWKJI6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:58:53 -0500
Date: Fri, 10 Nov 2006 09:57:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, Andi Kleen <ak@suse.de>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Message-ID: <20061110085728.GA14620@elte.hu>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <20061109233035.569684000@cruncher.tec.linutronix.de> <1163121045.836.69.camel@localhost> <200611100610.13957.ak@suse.de> <1163146206.8335.183.camel@localhost.localdomain> <20061110005020.4538e095.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110005020.4538e095.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> If so, could that function use the PIT/pmtimer/etc for working out if 
> the TSC is bust, rather than directly using jiffies?

there's no realiable way to figure out the TSC is bust: some CPUs have a 
slight 'skew' between cores for example. On some systems the TSC might 
skew between sockets. A CPU might break its TSC only once some 
powersaving mode has been activated - which might be long after bootup. 
The whole TSC business is a nightmare and cannot be supported reliably. 
AFAIK Windows doesnt use it, so it's a continuous minefield for new 
hardware to break.

We should wait until CPU makers get their act together and implement a 
TSC variant that is /architecturally promised/ to have constant 
frequency (system bus frequency or whatever) and which never stops.

	Ingo
