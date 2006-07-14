Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWGNUC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWGNUC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWGNUC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:02:29 -0400
Received: from rtr.ca ([64.26.128.89]:35272 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422724AbWGNUC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:02:28 -0400
Message-ID: <44B7F852.3040501@rtr.ca>
Date: Fri, 14 Jul 2006 16:02:26 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>  <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>  <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>  <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan> <1152545639.27368.137.camel@localhost.localdomain> <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan> <Pine.LNX.4.64.0607110926150.858@p34.internal.lan> <44B7D168.2080304@rtr.ca> <Pine.LNX.4.64.0607141318040.1687@p34.internal.lan> <44B7D6CE.4030406@rtr.ca>
In-Reply-To: <44B7D6CE.4030406@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Justin Piszcz wrote:
>> They are Western Digital 400* drives.
>>
>> [4294678.049000]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
>> [4294678.050000]   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
>>
>> On a SiL controller, it also happens when they are on a promise 
>> controller too.
>>
>> On Fri, 14 Jul 2006, Mark Lord wrote:
>>
>>> Justin Piszcz wrote:
>>>>
>>>> opcode=0x35 & opcode=0xca
>>>
>>> Those are non-DMA WRITE opcodes.  Using PIO for I/O is pretty rare 
>>> these days,
>>> so I'm betting that this is not a hard disk device -- compactflash?
> 
> Okay.  So why are we issuing PIO WRITE commands to drives that
> obviously should only be sent DMA commands by libata?
> 
> Perhaps that's the bug.

Oh wait.. I remember this.. No, those are DMA commands,
despite the misleading libata name for them.  We went through
this before last spring..

Okay.  So I wonder what's really going on.
The next step would be to instrument the interrupt handler,
so that when it sees bad-status, it dumps out the stat/err values
right then and there, before anything else can muck with them.

It might also be good to have it dump out the controller engine's
DMA status/err values, assuming the controller has registers for those.

Then we should get a better picture of what's going on.
Assuming the drives aren't lying to us (a perfectly good assumption here),
then the controller must be aborting the transfer unexpectedly.

Cheers
