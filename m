Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTL2Q6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTL2Q6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:58:42 -0500
Received: from util.ext.ti.com ([192.91.75.135]:34506 "EHLO util.ext.ti.com")
	by vger.kernel.org with ESMTP id S263772AbTL2Q6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:58:34 -0500
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: linux-kernel@vger.kernel.org
X-Accept-Language: en-us, en
Message-ID: <3FF05C27.5030706@ti.com>
Date: Mon, 29 Dec 2003 18:53:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: network driver that uses skb destructor
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to write a network driver that uses DMA and manages it's 
own memory.

The most common approach (in RX) seem to be to allocate the memory for 
DMA transfer using dev_alloc_skb(), get the HW DMA engine to transfer 
the packet into this skb buffer and later free it using dev_kfree_skb().

For various reasons (mainly to support legacy source code) I would like 
to allocate and free the buffer using my own functions. Theoretically, I 
could get away by using skb->destructor.

When I receive a packet I could allocate a zero length skb, point 
skb->data to my (already allocated) buffer which contains the packet and 
register the skb->destructor callback. Later, when this skb would be 
freed my destructor callback would be called and it would return the 
buffer to driver's pool.

It seems to me that it should work, but I'm a little bit cautions 
because I could not find a single network driver (in 2.4 kernel) that 
uses such an approach and I'm not extremely eager to be the first one to 
try.

Anybody tried to implement similar approach ?
Any thoughts why this would (or would not) work ?

Thanks a lot.

-- 
Alexander Sirotkin
SW Engineer

Texas Instruments
Broadband Communications Israel (BCIL)
Tel:  +972-9-9706587
________________________________________________________________________
"Those who do not understand Unix are condemned to reinvent it, poorly."
      -- Henry Spencer 

