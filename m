Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTIDPuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTIDPuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:50:00 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:6333 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265069AbTIDPt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:49:58 -0400
Date: Thu, 4 Sep 2003 08:58:56 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904155856.GB31420@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <16215.13051.836875.270440@nanango.paulus.ozlabs.org> <Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04 2003, at 14:57, Geert Uytterhoeven was caught saying:
> On Thu, 4 Sep 2003, Paul Mackerras wrote:
> > Geert Uytterhoeven writes:
> > > `ioremap is meant for PCI memory space only'
> > 
> > Did I say that, or someone else? :)  ioremap predates PCI support by a
> > long way IIRC...
> 
> inb() and friends are for ISA/PCI I/O space
> isa_readb() and friends are for ISA memory space
> readb() and friends are for PCI memory space (after ioremap())
> 
> That's why other buses (e.g. SBUS and Zorro) have their own versions of
> ioremap() and readb() etc.).
> 
> Life would be much easier with bus-specific I/O ops...

What happens if I have a device that can be either ISA or connected 
directly to a local memory bus? The driver should be able to 
ioremap(some resource) and then read/write the device without
having to have ugly #ifdefs to deal with different bus types.
Example in point is the CS8900a device which is hooked up directly
to a FPGA on the local memory bus with the bytelanes backwards.
The ammount of hacking done in the driver to get around that is
ugly. It would be much nicer if the driver still just did read*/write*
and the platform level code could deal with all the translation
issues. This requires a generic API for all I/O devices.

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
