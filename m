Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSLEDGE>; Wed, 4 Dec 2002 22:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSLEDGE>; Wed, 4 Dec 2002 22:06:04 -0500
Received: from host194.steeleye.com ([66.206.164.34]:42506 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267200AbSLEDGD>; Wed, 4 Dec 2002 22:06:03 -0500
Message-Id: <200212050313.gB53DXV05743@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: David Gibson <david@gibson.dropbear.id.au>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from David Gibson <david@gibson.dropbear.id.au> 
   of "Thu, 05 Dec 2002 13:38:47 +1100." <20021205023847.GA1500@zax.zax> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 21:13:33 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david@gibson.dropbear.id.au said:
> The point is, there has to be an advantage to using consistent memory
> if it is available AND the possibility of it not being available. 

I'm really thinking of this from the driver writer's point of view.  The 
advantage of consistent memory is that you don't have to think about where to 
place all the sync points (sync points can be really subtle and nasty and an 
absolute pain---I shudder to recall all of the problems I ran into writing a 
driver on a fully inconsistent platform).

The advantage here is that you can code the driver only to use consistent 
memory and not bother with the sync points (whatever the cost of this is).  
Most platforms support reasonably cheap consistent memory, so most people 
simply don't want to bother with inconsistent memory if they can avoid it.

If you do the sync points, you can specify the DMA_CONFORMANCE_NON_CONSISTENT 
level and have the platform choose what type of memory you get.  For a 
platform which makes memory consistent by turning off CPU caching at the page 
level, it's probably better to return non-consistent memory if the driver can 
cope with it.

James


