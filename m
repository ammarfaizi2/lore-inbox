Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWFHGds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWFHGds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 02:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWFHGds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 02:33:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:56283 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932527AbWFHGdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 02:33:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4487C40D.702@s5r6.in-berlin.de>
Date: Thu, 08 Jun 2006 08:30:37 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060607232345.3fcad56e@werewolf.auna.net> <20060607220704.GA6287@elte.hu> <44876745.4050108@s5r6.in-berlin.de> <20060608003153.GN2697@moss.sous-sol.org>
In-Reply-To: <20060608003153.GN2697@moss.sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.045) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
>>The pending_packet_queue is only accessed from within 
>>drivers/ieee1394/ieee1394_core.c, and only via net/core/skbuff.c's 
>>access functions for queueing/ dequeueing/ queuewalking. Or am I missing 
>>something?
> 
> Quick grep show following two irq handlers as examples:
> 
> ohci_irq_handler() | lynx_irq_handler()
>   hpsb_bus_reset()
>     abort_requests()
>       skb_dequeue()
>         spin_lock_irqsave()
>     
> That spin_lock is called directly from within irq handler.

Yes, definitely. What I wanted to reassure myself about was rather that 
no other net/ code besides skbuff.c's touches this queue. IOW only the 
ieee1394 low and mid layer control the contexts within which the queue 
lock is used.
-- 
Stefan Richter
-=====-=-==- -==- -=---
http://arcgraph.de/sr/
