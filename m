Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUKQO0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUKQO0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUKQO0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:26:06 -0500
Received: from emulex.emulex.com ([138.239.112.1]:7074 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S262328AbUKQOZ7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:25:59 -0500
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Potential issue with some implementations of pci_resource_start()
Date: Wed, 17 Nov 2004 09:18:27 -0500
Message-ID: <0B1E13B586976742A7599D71A6AC733C02F276@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Potential issue with some implementations of pci_resource_start()
Thread-Index: AcTMjAUFQ4DLiGCwRxGpge8K6CNeeAAH8nmw
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, <linux-os@chaos.analogic.com>, <jes@wildopensource.com>,
       <James.Smart@Emulex.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the question was to flush out what to expect from pci_resource_start(), and if it is functioning as desired, update the documentation to reflect what it actually returns. It is too ambiguous as is (and in many cases, it is the contents of the bar register). The fact it's a cookie is not well known, as it was not the definition I received from private questions to several kernel developers.

Can someone please update Documentation/pci.txt so that it has correct definitions for pci_resource_start() and pci_resource_end()...

FYI: In our case, we have an adapter that can use adapter or host memory for messaging. It detects the use of adapter memory by comparing the bus address given by the driver to it's bar values. So yes - we had to read the config space registers directly to give the adapter the proper values.

-- James S


> From: jes@trained-monkey.org [mailto:jes@trained-monkey.org]
>
> James> Are these platform bugs that need to be corrected ? or is it a
> James> change in the pci_resource_start() definition ?
> 
> pci_resource_start will rather give you a cookie that you can pass to
> iomap() (ioremap() in the old API) etc. You shouldn't be relying on
> the physical bar content for anything in a Linux driver.
> 
> Cheers,
> Jes


> From: linux-os [mailto:linux-os@chaos.analogic.com]
> 
> pic_resource_start() is supposed to give you something that
> ioremap() can use. On 64-bit platforms it is unlikely to be
> a physical address, but a "cookie" that ioremap() knows about.
> 
> If you want the physical address you are going to have to read
> the registers directly. It will give you a number that is useless
> as an address, though.
> 
> Cheers,
> Dick Johnson
