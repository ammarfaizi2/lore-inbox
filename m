Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319250AbSHUXqu>; Wed, 21 Aug 2002 19:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319251AbSHUXqs>; Wed, 21 Aug 2002 19:46:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:40433 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319250AbSHUXqn>; Wed, 21 Aug 2002 19:46:43 -0400
Subject: Re: 2.5 IDE Whitepaper?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: PAUL BENNETT <paul.bennett@usa.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3D64231C.6050407@mandrakesoft.com>
References: <20020821183807.21562.qmail@uwdvg003.cms.usa.net> 
	<3D64231C.6050407@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Aug 2002 00:51:52 +0100
Message-Id: <1029973912.26845.266.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 00:32, Jeff Garzik wrote:
> PAUL BENNETT wrote:
> > I am looking for documentation regarding the 2.5 IDE rewrite.  For example: 
> > What are the goals for 2.5.  What is the implementation plan?  What were the
> > problems in 2.4, and how will they be fixed in 2.5, etc?
> 
> <chuckle>  I wish :)
> 
> I imagine it will happen like most things happen, Linus describes his 
> ideas and goals and wishes in a few lkml posts, and eventually something 
> like it happens :)

I can try, my working list approximates this (ignoring the 2.5
porting/block I/O stuff which is a chapter in itself)

Phase #1 (mostly complete)
	Merge Andre's current code [DONE]
	Remove all the bogus code from the PCI drivers [90% DONE]
	Move all the drivers seperate from the core code [DONE]
	Migrate the PCI drivers to a registration API and allow insmod
	Fix bugs arising from the first bits of phase 1

Phase #2 
	Deal with insmod of a device currently running as legacy
	Fix up the locking ready to allow rmmod of a pci driver
	Allow rmmod and hotplug at the controller level

Phase #3
	Complete splitting setup-pci functions into smaller bits of code
	and replace deep magic and callbacks with functions called from
	each driver. Get all the if device==foo out of the PCI code 	paths

Phase #4
	Do something about the ide_register/unregister end of the world
	and legacy chipset stuff. The PPC folks may tackle this in
	advance
	Get us to the point we can foo = ide_attach(); ide_remove(foo) 	
	for arbitary interfaces
	
And then (when the setup is turned the right way out and not before)
begin looking at turning the actual block I/O engine the right way out.
(That is driver calls helpers not midlayer and magic)

That should allow us to keep solid stable IDE along the way.

