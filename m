Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbTABQcy>; Thu, 2 Jan 2003 11:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTABQcy>; Thu, 2 Jan 2003 11:32:54 -0500
Received: from host194.steeleye.com ([66.206.164.34]:17157 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264766AbTABQcx>; Thu, 2 Jan 2003 11:32:53 -0500
Message-Id: <200301021641.h02GfFU02455@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: david-b@pacbell.net, akpm@digeo.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic device DMA (dma_pool update) 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Wed, 01 Jan 2003 20:13:35 PST." <200301020413.UAA03503@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Jan 2003 10:41:15 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 	Let me clarify or revise my request.  By "show me or invent an
> example" I mean describe a case where this would be used, as in
> specific hardware devices that Linux has trouble supporting right now,
> or specific programs that can't be run efficiently under Linux, etc.
> What device would need to do this kind of allocation?  Why haven't I
> seen requests for this from people working on real device drivers?
> Where is this going to make the kernel smaller, more reliable, faster,
> more maintainable, able to make a computer do something it could do
> before under Linux, etc.?

I'm not really the right person to be answering this.  For any transfer you 
set up (which encompasses all of the SCSI stuff bar target mode and AENs) you 
should have all the resources ready and waiting in the interrupt, and so never 
require an in_interrupt allocation.

However, for unsolicited transfer requests---the best example I can think of 
would be incoming network packets---it does make sense:  You allocate with 
GFP_ATOMIC, if the kernel can fulfil the request, fine; if not, you drop the 
packet on the floor.  Now, whether there's an unsolicited transfer that's 
going to require coherent memory, that I can't say.  It does seem to be 
possible, though.

James


