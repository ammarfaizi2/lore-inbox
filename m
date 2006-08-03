Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWHCPYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWHCPYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWHCPYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:24:11 -0400
Received: from mga07.intel.com ([143.182.124.22]:11708 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964783AbWHCPYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:24:09 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="96807756:sNHT1160710313"
Message-ID: <44D214D2.70206@linux.intel.com>
Date: Thu, 03 Aug 2006 08:22:58 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
References: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
In-Reply-To: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:

Hi,

> Arjan van de Ven <arjan@infradead.org> wrote:
>> this is another one of those nasty buggers;
> 
> Good catch.  It's really time that we fix this properly rather than
> adding more kludges to the core code.

however I'm not quite yet convinced that this patch is going to solve
this particular deadlock.
(I agree with the principle of it and I think it's really needed,
I just don't yet see how it's going to solve this specific deadlock. But
then again it's early and I've not had sufficient coffee yet so I could
well be wrong)

> [WIRELESS]: Send wireless netlink events with a clean slate
> 
> Drivers expect to be able to call wireless_send_event in arbitrary
> contexts.  On the other hand, netlink really doesn't like being
> invoked in an IRQ context.  So we need to postpone the sending of
> netlink skb's to a tasklet.

it's not just about irq context, it's about being called with any lock that's
used in IRQ context; that is what makes this double nasty...

Greetings,
    Arjan van de Ven
