Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264450AbTCXRUW>; Mon, 24 Mar 2003 12:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbTCXRSt>; Mon, 24 Mar 2003 12:18:49 -0500
Received: from files.ssi.bg ([217.79.71.21]:2574 "HELO files.ssi.bg")
	by vger.kernel.org with SMTP id <S264422AbTCXRSd>;
	Mon, 24 Mar 2003 12:18:33 -0500
Date: Mon, 24 Mar 2003 19:24:51 +0200
From: Alexander Atanasov <alex@ssi.bg>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
 looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
Message-Id: <20030324192451.13aa10b2.alex@ssi.bg>
In-Reply-To: <1048527607.25655.18.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
	<1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
	<20030324180125.2606b046.alex@ssi.bg>
	<1048527607.25655.18.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, Alan!

On 24 Mar 2003 17:40:08 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2003-03-24 at 16:01, Alexander Atanasov wrote:
> > 	I don't understand, what's the difference and how the list is
> > 	lost?
> > ata_unused used to hold all drives that were not claimed by any
> > driver, now idedefault_driver claims all that drives, all drives go
> > in the .list
> 
> ata_unused -> unattached device slots, new hotplug discoveries

	Ok. 

> idedefault_driver -> attached/known devices with no driver
> other list -> driven by that driver
> 
> > The bug is there,  and waiting to explode, keeping both lists would
> > mean to add one more  list head  in ide_drive_t,  is that the fix
> > you want?
> 
> I don't see where stuff is ending up on both lists yet. I've not had
> time to look hard at it though
> 

	It happens this way:
	ide_register_driver -> ata_attach -> idedefault_driver.attach -> ide_register_subdriver -> list_add(&driver->list, &driver->drives) ->
return to ata_attach -> list_add_tail(&drive->list, &ata_unused);
	
--
have fun,
alex
