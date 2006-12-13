Return-Path: <linux-kernel-owner+w=401wt.eu-S932421AbWLMBVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWLMBVO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWLMBVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:21:14 -0500
Received: from fallback.mail.elte.hu ([157.181.151.13]:60377 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421AbWLMBVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:21:12 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:21:12 EST
Date: Wed, 13 Dec 2006 02:12:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] net, 8139too.c: fix netpoll deadlock
Message-ID: <20061213011231.GA6361@elte.hu>
References: <20061212101656.GA5064@elte.hu> <20061212124935.GA4356@elte.hu> <457EAE62.8090404@garzik.org> <20061212214939.GA470@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212214939.GA470@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Francois Romieu <romieu@fr.zoreil.com> wrote:

> > (I'll queue it, if Linus doesn't pick it up; please CC me in the 
> > future)
> 
> I have lived with the "NAPI ->poll() handler runs in BH irq enabled 
> context" rule for years. Is it definitely false/dead ?
> 
> If so at least 8139cp needs the same fix.

hm, this isnt really about NAPI polling, but about the 
netconsole/netpoll/netdump poll_controller() handler.

with netconsole, printk can be called from IRQ context (and is 
frequently from IRQ context during bootup or module initialization), so 
a BH rule isnt enough for them.

	Ingo
