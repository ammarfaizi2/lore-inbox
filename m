Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSHEOD7>; Mon, 5 Aug 2002 10:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHEOD7>; Mon, 5 Aug 2002 10:03:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3569 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318470AbSHEOD5>; Mon, 5 Aug 2002 10:03:57 -0400
Subject: Re: [PATCH] 2.5.30 Maestro3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3D4E831B.30000@evision.ag>
References: <3D4E831B.30000@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 16:25:55 +0100
Message-Id: <1028561156.18478.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 14:52, Marcin Dalecki wrote:
> The attached patch is updating the Maestro3 OSS sound chip driver to
> 
> 1. The changes in IRQ handline.
> 
> 2. C99 standard conformant initializers.
> 
> Plese apply. (I happen to use such a chip...)

How about fixing it first ?


>      /* must be a better way.. */
> -    save_flags(flags);
> -    cli();
> +    local_irq_save(flags);

This is insufficient. It has to lock against card interrupts and other
arbitary ill defined (in 2.4 anyway) suspend things. Assuming the PM
layer can mind its own business nowdays you are at least going to want
to take the card lock. I think thats mostly sufficient for the maestro
case. There is a long standing question about whether the resume code
should end by calling the irq handler to fake any missed IRQ pending
over the suspend of the card - but thats also true in the 2.4 case.


