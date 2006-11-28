Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936044AbWK1T0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936044AbWK1T0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936055AbWK1T0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:26:07 -0500
Received: from isaowa.keyvoice.com ([12.153.69.53]:23982 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S936054AbWK1T0G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:26:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reserving a fixed physical address page of RAM.
Date: Tue, 28 Nov 2006 14:26:03 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D0F7D@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccSrOdmej2lbH1FT5KS/7yFyJ7ljAAdesOg
From: "Jon Ringle" <JRingle@vertical.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jon Ringle wrote:
> > Robert Hancock wrote:
> >> Jon Ringle wrote:
> >>> Hi,
> >>>
> >>> I need to reserve a page of memory at a specific area of RAM that 
> >>> will be used as a "shared memory" with another processor 
> over PCI. 
> >>> How can I ensure that the this area of RAM gets reseved 
> so that the 
> >>> Linux's memory management (kmalloc() and friends) don't use it?
> >>>
> >>> Some things that I've considered are iotable_init() and ioremap().
> >>> However, I've seen these used for memory mapped IO 
> devices which are 
> >>> outside of the RAM memory. Can I use them for reseving RAM too?
> >>>
> >>> I appreciate any advice in this regard.
> >>
> >> Sounds to me like dma_alloc_coherent is what you want..
> >>
> > It looks promising, however, I need to reserve a physical 
> address area 
> > that is well known (so that the code running on the other processor 
> > knows where in PCI memory to write to). It appears that 
> > dma_alloc_coherent returns the address that it allocated. Instead I 
> > need something where I can tell it what physical address 
> and range I 
> > want to use.
> 
> I don't think this is possible in the general case, as 
> there's no mechanism for moving things out of the way if they 
> might be in use. Your best solution is likely to use 
> dma_alloc_coherent and pass the bus address returned into the 
> other processor to tell it where to write..

I can't do that because my mechanism to talk to the other processor is
exactly what I'm trying to setup. Catch-22 :)
