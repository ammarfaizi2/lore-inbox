Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTIDRD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTIDRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:03:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54024 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265081AbTIDRDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:03:54 -0400
Date: Thu, 4 Sep 2003 18:03:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030904180351.G8414@flint.arm.linux.org.uk>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405> <20030831121019.GB22771@iain-vaio-fx405> <20030831133846.C3017@flint.arm.linux.org.uk> <20030902203043.GA12997@iain-vaio-fx405> <20030902224433.F9345@flint.arm.linux.org.uk> <20030904123258.GA7674@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904123258.GA7674@iain-vaio-fx405>; from ibroadfo@cis.strath.ac.uk on Thu, Sep 04, 2003 at 01:32:58PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:32:58PM +0100, iain d broadfoot wrote:
> * Russell King (rmk@arm.linux.org.uk) wrote:
> > Could you try the updated debugging patch there please?  It should
> > print something extra no matter what.
> > 
> > Could you also provide the kernel messages which include the
> > initialisation of your PCMCIA or CardBus bridge please?
> 
> are these the right lines?
> 
> =======================================================================
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0800-0x08ff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: memory probe 0xa0000000-0xa0ffffff: clean.
> cs: request irq: pci irq 11 mask 0090
> orinoco_cs: RequestIRQ: Resource in use
> =======================================================================
> 
> that's from my boot sequence - I pulled and inserted the card and got
> the last two lines again.

Ok, I'm mostly happy that it isn't a generic PCMCIA bug as such now -
it seems that orinoco_cs may be passing a mask which doesn't include
any reasonable IRQs, or the two available IRQs (7 and 4) are already
in use by other devices.

Hmm, I wonder if we could fall back to the PCI IRQ when this occurs.
Unfortunately I can't look into the issue as deeply as I'd like at
present, so I'll create a "wouldn't it be nice if" (WIBNI) list of
things to do on pcmcia.arm.linux.org.uk.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


