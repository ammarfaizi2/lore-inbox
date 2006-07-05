Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWGELSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWGELSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWGELSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:18:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:6590 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964800AbWGELSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:18:31 -0400
Date: Wed, 5 Jul 2006 13:13:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Arjan van de Ven <arjan@infradead.org>, netdev@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060705111350.GA25161@elte.hu>
References: <20060703030355.420c7155.akpm@osdl.org> <200607042153.31848.rjw@sisk.pl> <1152043271.3109.95.camel@laptopd505.fenrus.org> <44AB940F.7000801@s5r6.in-berlin.de> <44AB9633.9090208@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AB9633.9090208@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5059]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> I wrote:
> > (Ieee1394 core's usage of the skb_* API is entirely unrelated to
> > networking; even if eth1394 was used.)
> 
> PS:
> I wonder if it wouldn't be better to migrate ieee1394 core away from 
> skb_*. I didn't look thoroughly at it yet but the benefit of using 
> this API appears quite low to me.

yeah, it seems to be the wrong abstraction to use. It's also more 
expensive than necessary: e.g. skb-heads have a qlen field that is 
maintained in every list op - but the ieee1394 code does not make use of 
the queue-length information. Using list.h plus a spinlock should do the 
trick?

	Ingo
