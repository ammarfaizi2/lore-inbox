Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTBDViV>; Tue, 4 Feb 2003 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTBDViV>; Tue, 4 Feb 2003 16:38:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10903
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267411AbTBDViR>; Tue, 4 Feb 2003 16:38:17 -0500
Subject: Re: natsemi.c: Oversized(?) ethernet frame message w/ card hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James E Lucas <jelucas@utdallas.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4280608.1044393822565.JavaMail.jelucas@utdallas.edu>
References: <4280608.1044393822565.JavaMail.jelucas@utdallas.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044398683.29825.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 22:44:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 21:23, James E Lucas wrote:
> 
> And, my kernel ring buffer (dmesg) is showing messages like this:
> 
> eth0: Oversized(?) Ethernet frame spanned multiple buffers, entry 
> 0x00ba8b status 0xe0000bd5.

By strange co-incidence I saw this with natsemi on one of my boxes
today. 

> numbers of large UDP packets at the card to reproduce the breakage.  If 
> anyone's interested in it I could post it up somewhere, though it's not 
> very pretty ;)

I'd love a copy

> from National Semiconductor *seems* to indicate to me that this message 
> results from a packet spanning multiple descriptors in the hardware.  
> This *is* legal for the chip according to National's docs, but I can't 
> find anything in the driver that seems to acknowledge this beyond the 
> warning message.  My current working theory is that this doesn't happen

Our drivers post buffers larger than an ethernet packet to the card so
it means the card thinks it received a frame larger than anything it
should have accepted.

> very often, but when it does, the driver's not handling it properly.  
> What I'm not so sure on is why that hangs the card.  Perhaps it's 
> throwing the driver into an infinite loop or something.  Not really 

If it got stuck in a loop the box would hang. It appears to stop the
chip and it never restarts.

My card that did this is also an FA-311. I've only ever seen this once
however so I guess my network isnt loaded enough 8)



