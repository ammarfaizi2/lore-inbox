Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWFGX54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWFGX54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWFGX54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:57:56 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:6603 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932470AbWFGX54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:57:56 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44876745.4050108@s5r6.in-berlin.de>
Date: Thu, 08 Jun 2006 01:54:45 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060607232345.3fcad56e@werewolf.auna.net> <20060607220704.GA6287@elte.hu>
In-Reply-To: <20060607220704.GA6287@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.045) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
...
> ieee1394 reuses the skb infrastructure of the networking code,
> and uses two skb-head queues: ->pending_packet_queue and
> hpsbpkt_queue. The latter is used in the usual fashion: processed
> from a kernel thread. The other one, ->pending_packet_queue is also
> processed from hardirq context (f.e. in hpsb_bus_reset()), which is
> not what the networking code usually does (which completes from
> softirq or process context). This locking assymetry can be totally
> correct if done carefully, but it can also be dangerous if
> networking helper functions are reused, which could assume
> traditional networking use.
...

The pending_packet_queue is only accessed from within 
drivers/ieee1394/ieee1394_core.c, and only via net/core/skbuff.c's 
access functions for queueing/ dequeueing/ queuewalking. Or am I missing 
something?
-- 
Stefan Richter
-=====-=-==- -==- -=---
http://arcgraph.de/sr/
