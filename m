Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTIDQR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTIDQR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:17:59 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:33279 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265239AbTIDQQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:16:36 -0400
Date: Thu, 4 Sep 2003 18:15:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Deepak Saxena <dsaxena@mvista.com>
cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904155856.GB31420@xanadu.az.mvista.com>
Message-ID: <Pine.GSO.4.21.0309041800330.8244-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Deepak Saxena wrote:
> On Sep 04 2003, at 14:57, Geert Uytterhoeven was caught saying:
> > On Thu, 4 Sep 2003, Paul Mackerras wrote:
> > > Geert Uytterhoeven writes:
> > > > `ioremap is meant for PCI memory space only'
> > > 
> > > Did I say that, or someone else? :)  ioremap predates PCI support by a
> > > long way IIRC...
> > 
> > inb() and friends are for ISA/PCI I/O space
> > isa_readb() and friends are for ISA memory space
> > readb() and friends are for PCI memory space (after ioremap())
> > 
> > That's why other buses (e.g. SBUS and Zorro) have their own versions of
> > ioremap() and readb() etc.).
> > 
> > Life would be much easier with bus-specific I/O ops...
> 
> What happens if I have a device that can be either ISA or connected 
> directly to a local memory bus? The driver should be able to 
> ioremap(some resource) and then read/write the device without
> having to have ugly #ifdefs to deal with different bus types.
> Example in point is the CS8900a device which is hooked up directly
> to a FPGA on the local memory bus with the bytelanes backwards.
> The ammount of hacking done in the driver to get around that is
> ugly. It would be much nicer if the driver still just did read*/write*
> and the platform level code could deal with all the translation
> issues. This requires a generic API for all I/O devices.

The usual solution is to have my_read() and friends in your driver, and #define
them to what's appropriate based on your CONFIG_* settings.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

