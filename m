Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSKRWTa>; Mon, 18 Nov 2002 17:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbSKRWTT>; Mon, 18 Nov 2002 17:19:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42765 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265085AbSKRWRp>;
	Mon, 18 Nov 2002 17:17:45 -0500
Message-ID: <3DD9688F.8030202@pobox.com>
Date: Mon, 18 Nov 2002 17:24:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
References: <Pine.LNX.4.33.0211181714340.1796-100000@router.windsormachine.com>
In-Reply-To: <Pine.LNX.4.33.0211181714340.1796-100000@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:

> On Mon, 18 Nov 2002, Jeff Garzik wrote:
>
>
> >Given the output you just provided, 8139too is indeed the only driver
> >that will work for you.
> >
> >WRT pci-skeleton.c I think that is a red herring for you... 8139cp
> >support is available from 8139cp.c.  But given the lspci output, it will
> >not work for you...
> >
> >thanks!
> >
> >	Jeff
>
>
> I guess 2.4.20 should get the proper pci_id added into 8139too.c then, if
> these cards are just starting to come out.


this is a toughie...   basically that is an invalid PCI ID that should 
not occur.  the "00ec" should really be "10ec", but it sounds like there 
is a missing bit in the EEPROM where your card's PCI ID is stored.

A better patch would add

	{ 0x00ec, 0x8139, 0xa0a0, 0x0027, ... }

because otherwise you wind up with a potential [low] chance of picking 
up boards with that same PCI device id 0x8139.

> I left the D card in my workstation for now, I'll see how it handles the
> nightly backup tonight, and if you want me to test things for 8139cp


cool.  no need to test 8139cp, it won't even load with your card, since 
it is not an 8139C+ chip.


> What IS pci-skeleton then?



Example driver that other developers may base drivers off of...

	Jeff



