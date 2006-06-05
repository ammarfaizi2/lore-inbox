Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751399AbWFEUGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWFEUGZ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWFEUGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:06:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63975 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751400AbWFEUGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:06:24 -0400
Date: Mon, 5 Jun 2006 22:05:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: mbligh@google.com, akpm@osdl.org, apw@shadowen.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605200551.GA15560@elte.hu>
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605130039.db1ac80c.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5387]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy.Dunlap <rdunlap@xenotime.net> wrote:

> > > panic on NUMA-Q during LTP. Was fine in -mm2.
> > > 
> > > BUG: unable to handle kernel paging request at virtual address 22222232
> > 
> > > EIP is at check_deadlock+0x19/0xe1
> > > eax: 00000001   ebx: e4453030   ecx: 00000000   edx: e4008000
> > > esi: 22222222   edi: 00000001   ebp: 22222222   esp: e47ebec0
> > 
> > again these 0x22222222 entries on the stack. What on earth does this? 
> > Andy got a similar crash on x86_64, with a 0x2222222222222222 entry ...
> > 
> > nothing of our magic values are 0x22 or 0x222222222.
> 
> kernel/mutex-debug.c:
> void debug_mutex_free_waiter(struct mutex_waiter *waiter)
> {
> 	DEBUG_WARN_ON(!list_empty(&waiter->list));
> 	memset(waiter, 0x22, sizeof(*waiter));
> }

ah!!! that's indeed a hint. Will take a look tomorrow.

	Ingo
