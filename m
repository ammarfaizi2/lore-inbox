Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTIDQhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbTIDQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:37:13 -0400
Received: from trained-monkey.org ([209.217.122.11]:56584 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S265284AbTIDQhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:37:05 -0400
To: dsaxena@mvista.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
References: <16215.13051.836875.270440@nanango.paulus.ozlabs.org>
	<Pine.GSO.4.21.0309041449260.8244-100000@waterleaf.sonytel.be>
	<20030904155856.GB31420@xanadu.az.mvista.com>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 04 Sep 2003 12:36:45 -0400
In-Reply-To: <20030904155856.GB31420@xanadu.az.mvista.com>
Message-ID: <m3ekywbjdu.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Deepak" == Deepak Saxena <dsaxena@mvista.com> writes:

Deepak> What happens if I have a device that can be either ISA or
Deepak> connected directly to a local memory bus? The driver should be
Deepak> able to ioremap(some resource) and then read/write the device
Deepak> without having to have ugly #ifdefs to deal with different bus
Deepak> types.

You can't do that reliably, some architectures requires different
access for ISA vs PCI vs random-other busses. The driver needs to be
aware what bus it's trying to go through.

Deepak> Example in point is the CS8900a device which is hooked
Deepak> up directly to a FPGA on the local memory bus with the
Deepak> bytelanes backwards.  The ammount of hacking done in the
Deepak> driver to get around that is ugly. It would be much nicer if
Deepak> the driver still just did read*/write* and the platform level
Deepak> code could deal with all the translation issues. This requires
Deepak> a generic API for all I/O devices.

That might be nicer from the driver perspective but it will make
readb/writeb a lot more complex and inefficient for no reason on some
architectures.

The driver will have to know whether it's on a PCI, ISA or directly
attached anyway when it's probing so it's perfectly reasonable to
expect it to deal with that when it's accessing the registers as well.

Cheers,
Jes
