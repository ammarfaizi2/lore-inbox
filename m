Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936043AbWK1Thf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936043AbWK1Thf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936066AbWK1Thf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:37:35 -0500
Received: from mail.keyvoice.com ([12.153.69.53]:56245 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S936043AbWK1The convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:37:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reserving a fixed physical address page of RAM.
Date: Tue, 28 Nov 2006 14:37:32 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D0F81@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccS1gpnhJbSJlOTRQmYG98ggWbD8wATSASQ
From: "Jon Ringle" <JRingle@vertical.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Fawad Lateef" <fawadlateef@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 28/11/06, Fawad Lateef <fawadlateef@gmail.com> wrote:
> > On 11/28/06, Dave Airlie <airlied@gmail.com> wrote:
> > > On 11/28/06, Jon Ringle <jringle@vertical.com> wrote:
> > <snip>
> > > > It looks promising, however, I need to reserve a 
> physical address 
> > > > area that is well known (so that the code running on the other 
> > > > processor knows where in PCI memory to write to). It 
> appears that 
> > > > dma_alloc_coherent returns the address that it 
> allocated. Instead 
> > > > I need something where I can tell it what physical 
> address and range I want to use.
> > > >
> > >
> > > I've seen other projects just boot a 128M board with mem=120M and 
> > > just use the 8MB at 120 to talk to the other processor..
> > >
> >
> > Yes, this can be used if required physical-memory exists in 
> the last 
> > part of RAM as if you use mem=<xxxM> then kernel will only 
> use memory 
> > less than or equal-to <xxxM> and above can be used by 
> drivers (or any 
> > kernel module) might be through ioremap which takes 
> physical-address.
> >
> > But if lets say we need only 1MB portion of specific 
> physical-memory 
> > region then AFAIK it must be done by hacking in kernel code during 
> > memory-initialization (mem_init function) where it is 
> marking/checking 
> > pages as/are reserved; you can simply mark you required pages as 
> > reserved too and set their count to some-value if you want to know 
> > later which pages are reserved by you. (can do this reservation work
> > here: http://lxr.free-electrons.com/source/arch/i386/mm/init.c#605).
> > CMIIW
> >
> 
> Can you not use the 'memmap=' kernel option to reserve the 
> specific area you need?
> (See Documentation/kernel-parameters.txt for details)

This looks like what I want, but after searching for this, I found that
memmap= is implemented for i386 and ia64 only. My arch is arm (processor
is an IXP455).

I'll explore the mem= option to see if it will work out.

Jon
