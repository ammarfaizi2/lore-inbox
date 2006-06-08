Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWFHAab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWFHAab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWFHAaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:30:30 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20611 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932510AbWFHAa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:30:28 -0400
Date: Wed, 7 Jun 2006 17:31:53 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060608003153.GN2697@moss.sous-sol.org>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060607232345.3fcad56e@werewolf.auna.net> <20060607220704.GA6287@elte.hu> <44876745.4050108@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44876745.4050108@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> The pending_packet_queue is only accessed from within 
> drivers/ieee1394/ieee1394_core.c, and only via net/core/skbuff.c's 
> access functions for queueing/ dequeueing/ queuewalking. Or am I missing 
> something?

Quick grep show following two irq handlers as examples:

ohci_irq_handler() | lynx_irq_handler()
  hpsb_bus_reset()
    abort_requests()
      skb_dequeue()
        spin_lock_irqsave()
    
That spin_lock is called directly from within irq handler.

thanks,
-chris
