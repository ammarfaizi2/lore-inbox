Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSL0VjQ>; Fri, 27 Dec 2002 16:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSL0VjQ>; Fri, 27 Dec 2002 16:39:16 -0500
Received: from host194.steeleye.com ([66.206.164.34]:3848 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264779AbSL0VjP>; Fri, 27 Dec 2002 16:39:15 -0500
Message-Id: <200212272147.gBRLlU103775@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Brownell <david-b@pacbell.net>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation 
In-Reply-To: Message from David Brownell <david-b@pacbell.net> 
   of "Fri, 27 Dec 2002 12:21:54 PST." <3E0CB662.2010009@pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 27 Dec 2002 15:47:30 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david-b@pacbell.net said:
> - DMA mapping calls still return no errors; so BUG() out instead? 

That's actually an open question.  The line of least resistance (which is what 
I followed) is to do what the pci_ API does (i.e. BUG()).

It's not clear to me that adding error returns rather than BUGging would buy 
us anything (because now all the drivers have to know about the errors and 
process them).

>    Consider systems where DMA-able memory is limited (like SA-1111,
>    to 1 MByte); clearly it should be possible for these calls to
>    fail, when they can't allocate a bounce buffer.  Or (see below)
>    when an invalid argument is provided to a dma mapping call. 

That's pretty much an edge case.  I'm not opposed to putting edge cases in the 
api (I did it for dma_alloc_noncoherent() to help parisc), but I don't think 
the main line should be affected unless there's a good case for it.

Perhaps there is a compromise where the driver flags in the struct 
device_driver that it wants error returns otherwise it takes the default 
behaviour (i.e. no error return checking and BUG if there's a problem).

James


