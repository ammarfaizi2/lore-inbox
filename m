Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWARJCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWARJCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWARJCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:02:43 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:15972 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030199AbWARJCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:02:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xyl7Y5RoZ7ErBPFqV4EhqaYIGGJQN6ghKn5jirmmhSjRlO6B8Gyx3x0W9u4lQHhRXbKdIpY6p9ifDXN5fD1XJovO8c/1939pDUMkitvTbmY6iaIyfCHWAhTbQYkXPtqqsBDkiySz35l/2bMDMY2HsPU0Ppn2MjtVJXSc13Kh77Y=  ;
Message-ID: <43CE0429.3090708@yahoo.com.au>
Date: Wed, 18 Jan 2006 20:02:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: patrizio.bassi@gmail.com
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] e1000 C style badness
References: <5wgyi-18w-7@gated-at.bofh.it> <43CE02BD.8060309@gmail.com>
In-Reply-To: <43CE02BD.8060309@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrizio Bassi wrote:
> Jens Axboe ha scritto:
> 
>>Hi,
>>
>>Recent e1000 updates introduced variable declarations after code. Fix
>>those up again.
>>
>>Signed-off-by: Jens Axboe <axboe@suse.de>
>>
>>diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
>>index d0a5d16..ca68a04 100644
>>--- a/drivers/net/e1000/e1000_main.c
>>+++ b/drivers/net/e1000/e1000_main.c
>>@@ -2142,9 +2142,11 @@ e1000_leave_82542_rst(struct e1000_adapt
>> 		e1000_pci_set_mwi(&adapter->hw);
>> 
>> 	if(netif_running(netdev)) {
>>+		struct e1000_rx_ring *ring;
>>+
>> 		e1000_configure_rx(adapter);
>> 		/* No need to loop, because 82542 supports only 1 queue */
>>-		struct e1000_rx_ring *ring = &adapter->rx_ring[0];
>>+		ring = &adapter->rx_ring[0];
>> 		adapter->alloc_rx_buf(adapter, ring, E1000_DESC_UNUSED(ring));
>> 	}
>> }
>>@@ -3583,8 +3585,8 @@ e1000_clean_rx_irq(struct e1000_adapter 
>> 	rx_desc = E1000_RX_DESC(*rx_ring, i);
>> 
>> 	while(rx_desc->status & E1000_RXD_STAT_DD) {
>>-		buffer_info = &rx_ring->buffer_info[i];
>> 		u8 status;
>>+		buffer_info = &rx_ring->buffer_info[i];
>> #ifdef CONFIG_E1000_NAPI
>> 		if(*work_done >= work_to_do)
>> 			break;
>>
> 
> 
> Shouldn't variables declaration be on top of function and not on top of
> a block (like if, while, for...)?
> 

Any block is OK, and they all have the same nice symmetry - variables
come into scope at the top and go out of scope at the bottom.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
