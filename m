Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbUBWXPA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUBWXMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:12:36 -0500
Received: from bay12-f33.bay12.hotmail.com ([64.4.35.33]:28939 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262086AbUBWXMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:12:21 -0500
X-Originating-IP: [172.155.10.97]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys
Date: Mon, 23 Feb 2004 18:12:20 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY12-F33OzP0x9R09y0000867e@hotmail.com>
X-OriginalArrivalTime: 23 Feb 2004 23:12:20.0127 (UTC) FILETIME=[7CA282F0:01C3FA62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Feb 23, 2004 at 08:51:45AM -0800, Tobias Oed wrote:
>>[*]
>>Do I need to hold the pci_bus_lock spinlock for the following (checks for
>>NULL omitted here)
>>dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
>>dev = pci_dev_get(dev);
>>I'd rater use pci_get_slot instead of pci_find_slot, but I don't know how
>>to
>>get a struct pci_bus *  from an int.
>
>You should never need to use those functions at all anyway.  Just use
>the proper pci_register_driver() call and be done with it.
>
>thanks,
>
>greg k-h

Thanks for pointing that out. I don't know what I'm doing and starting by 
trying to fix a closed source driver is not making it any easier.
As Robin Rosenberg said elsethread, you may want to consider the following 
patch to warn programmers more consistently
Cheers, Tobias.
--- search.c.orig       2004-02-23 18:05:41.627162872 -0500
+++ search.c    2004-02-23 18:06:24.292676728 -0500
@@ -90,6 +90,10 @@
  * is located in system global list of PCI devices.  If the device
  * is found, a pointer to its data structure is returned.  If no
  * device is found, %NULL is returned.
+ *
+ * NOTE: Do not use this function anymore, use pci_get_slot() instead, as
+ * the pci device returned by this function can disappear at any moment in
+ * time.
  */
struct pci_dev *
pci_find_slot(unsigned int bus, unsigned int devfn)

_________________________________________________________________
Dream of owning a home? Find out how in the First-time Home Buying Guide. 
http://special.msn.com/home/firsthome.armx

