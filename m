Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUBWQvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUBWQvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:51:50 -0500
Received: from bay12-f104.bay12.hotmail.com ([64.4.35.104]:1800 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261960AbUBWQvr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:51:47 -0500
X-Originating-IP: [172.156.152.146]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys
Message-ID: <BAY12-F104dqK4Zd2yg00005ba3@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2004 16:51:45.0230 (UTC) FILETIME=[51F9BEE0:01C3FA2D]
Date: 23 Feb 2004 08:51:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Mon, 23 Feb 2004 11:51:45 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed

Please cc me as I'm not subscribed to the list.

Robin Rosenberg wrote:

>Tracing the stack, I see:
>
>pci_find_subsys is deprecated which is called from
>pci_find_device which is deprecated which is called from
>pci_find_slot, which is NOT deprecated.
>

I noticed that a while ago and modified the nvidia kernel interface 
(os-interface.c): I save a reference to struct pci_dev and return that when 
called in interrupt context [*]. Unfortunately it doesn't fix the problem: 
the badness goes away as expected but X is still frozen.
>From what I understand it's an agp related problem (specially on via 
chipset). The driver is hopelessly confused and tries to reinit itself and 
the card. Limiting my agp rate to x2in the bios makes things stable. With 
that even gaim runs stable. (gaim triggers the problem  systematically when 
displaying the buddy list if I use agp x4).
btw I'm running 4620 as all later releases of the driver have terrible 
performance with my tnt2.

[*]
Do I need to hold the pci_bus_lock spinlock for the following (checks for 
NULL omitted here)
dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
dev = pci_dev_get(dev);
I'd rater use pci_get_slot instead of pci_find_slot, but I don't know how to 
get a struct pci_bus *  from an int.

Tobias.

_________________________________________________________________
Watch high-quality video with fast playback at MSN Video. Free! 
http://click.atdmt.com/AVE/go/onm00200365ave/direct/01/

