Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTABQ4j>; Thu, 2 Jan 2003 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbTABQ4j>; Thu, 2 Jan 2003 11:56:39 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:28369 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265262AbTABQ4i>; Thu, 2 Jan 2003 11:56:38 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 2 Jan 2003 09:04:57 -0800
Message-Id: <200301021704.JAA00852@adam.yggdrasil.com>
To: James.Bottomley@steeleye.com
Subject: Re: [PATCH] generic device DMA (dma_pool update)
Cc: akpm@digeo.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>adam@yggdrasil.com said:
>> 	Let me clarify or revise my request.  By "show me or invent an
>> example" I mean describe a case where this would be used, as in
>> specific hardware devices that Linux has trouble supporting right now,
>> or specific programs that can't be run efficiently under Linux, etc.
>> What device would need to do this kind of allocation?  Why haven't I
>> seen requests for this from people working on real device drivers?
>> Where is this going to make the kernel smaller, more reliable, faster,
>> more maintainable, able to make a computer do something it could do
>> before under Linux, etc.?

>I'm not really the right person to be answering this.  For any transfer you 
>set up (which encompasses all of the SCSI stuff bar target mode and AENs) you 
>should have all the resources ready and waiting in the interrupt, and so never 
>require an in_interrupt allocation.

>However, for unsolicited transfer requests---the best example I can think of 
>would be incoming network packets---it does make sense:  You allocate with 
>GFP_ATOMIC, if the kernel can fulfil the request, fine; if not, you drop the 
>packet on the floor.  Now, whether there's an unsolicited transfer that's 
>going to require coherent memory, that I can't say.  It does seem to be 
>possible, though.

	When a network device driver receives a packet, it gives the
network packet that it pre-allocated to the higher layers with
netif_rx() and then allocates a net packet with dev_alloc_skb(), but
that is non-consistent "streaming" memory.  The consistent memory is
general for the DMA gather-scatter stub(s), which is (are) generally
reused since the receive for the packet that arrived has been
completed.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
