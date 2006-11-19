Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933155AbWKSUYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbWKSUYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933160AbWKSUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:24:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1974 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933155AbWKSUYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:24:48 -0500
Date: Sun, 19 Nov 2006 21:23:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061119202348.GA27649@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com> <1163966437.5826.99.camel@localhost.localdomain> <20061119200650.GA22949@elte.hu> <1163967590.5826.104.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163967590.5826.104.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > dont worry, it's -rt only stuff.
> 
> Still, I'm curious :-) Besides, there have been people talking about 
> having -rt work on ppc64 so ...

ok :)

> What do you need an ack() for on fasteoi ? On all fasteoi controllers 
> I have, ack is implicit by obtaining the vector number and all there 
> is is an eoi...

it's a compatibility hack only. Threaded handlers are a different type 
of flow, but often the fasteoi handler is not changed to the threaded 
handler so i changed it to be a threaded handler too.

threaded handlers need a mask() + an ack(), because that's the correct 
model to map them to kernel threads - threaded handlers can be delayed 
for a long time if something higher-prio is preempting them.

	Ingo
