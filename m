Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUFFSOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUFFSOG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUFFSOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:14:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263943AbUFFSOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:14:01 -0400
Message-ID: <40C35ED7.1080000@pobox.com>
Date: Sun, 06 Jun 2004 14:13:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Manfred Spraul <manfred@colorfullife.com>, ktech@wanadoo.es,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com> <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org> <40C2D780.4010009@colorfullife.com> <Pine.LNX.4.58.0406060957410.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406060957410.7010@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> But it's usually a good thing to try to reset a device as much as possible 
> when you probe for it. If for no other reason than the fact that then 
> you'll have it in a "known state", and hopefully there won't be as many 
> surprises..


Strongly agreed.  I stress this, in Linux driver writing talks and 
rants, to whomever will listen as "the proper way to do things in Linux".

Presuming things about a device's state upon entry to the driver has led 
to bugs in the past.  Popular bugs include assuming (a) MAC address 
registers hold a valid/useful value or (b) ethernet NIC's DMA engine is 
not active.  Both of these are quite often not true when you take into 
account driver re-loads, warm reboots, and firmware features such as USB 
kbd/mouse/storage or PXE booting from a network.

A good driver unconditionally makes sure the device is inactive in its 
probe function (struct pci_driver::probe), before registering itself 
with any kernel subsystems.  This must also be done before request_irq 
and before enabling the bus-mastering bit in PCI_COMMAND register.

	Jeff


