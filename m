Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUD1XCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUD1XCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUD1XCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:02:03 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:6102 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261802AbUD1XB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:01:59 -0400
To: ken@coverity.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Implementation inconsistencies in 2.6.3
References: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 28 Apr 2004 18:15:42 +0200
In-Reply-To: <4448.171.64.70.113.1083102442.spork@webmail.coverity.com> (Ken
 Ashcraft's message of "Tue, 27 Apr 2004 14:47:22 -0700 (PDT)")
Message-ID: <m3llkgnknl.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ken Ashcraft" <ken@coverity.com> writes:

/drivers/net/wan/hdlc_cisco.c:

> ---------------------------------------------------------
> [BUG] <khc@pm.waw.pl> not referencing 'dev'
>
> example:
> /home/kash/linux/2.6.3/linux-2.6.3/drivers/ieee1394/eth1394.c:569:ether1394_header:
> NOTE:READ: Checking arg dev [EXAMPLE=net_device.hard_header-1]
>
> /home/kash/linux/2.6.3/linux-2.6.3/drivers/net/wan/hdlc_cisco.c:37:cisco_hard_header:
> ERROR:READ: Not checking arg [COUNTER=net_device.hard_header-1]  [fit=62]
> [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=10] [counter=1] [z =
> -0.622543017479467] [fn-z = -4.35889894354067]
> #define CISCO_ADDR_REQ		0	/* Cisco address request */
> #define CISCO_ADDR_REPLY	1	/* Cisco address reply */
> #define CISCO_KEEPALIVE_REQ	2	/* Cisco keepalive request */
>
>
>
> Error --->
> static int cisco_hard_header(struct sk_buff *skb, struct net_device *dev,
> 			     u16 type, void *daddr, void *saddr,
> 			     unsigned int len)
> {

False positive - while other hard_header functions may want to know
the actual outbound device, it isn't the case here.
-- 
Krzysztof Halasa, B*FH
