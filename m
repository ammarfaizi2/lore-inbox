Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTAXUkA>; Fri, 24 Jan 2003 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbTAXUkA>; Fri, 24 Jan 2003 15:40:00 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:23822 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265570AbTAXUj7>; Fri, 24 Jan 2003 15:39:59 -0500
Date: Fri, 24 Jan 2003 15:46:35 -0500
From: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@redhat.com>, willy@debian.org,
       linux-kernel@vger.kernel.org, Jeff Wiedemeier <Jeff.Wiedemeier@hp.com>
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030124154635.A4161@dsnt25.mro.cpqcorp.net>
References: <20030124212748.C25285@jurassic.park.msu.ru> <20030124193135.GA30884@gtf.org> <20030124150006.A2882@dsnt25.mro.cpqcorp.net> <20030124200538.GB30884@gtf.org> <20030124152453.A4081@dsnt25.mro.cpqcorp.net> <20030124203402.GA4975@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124203402.GA4975@gtf.org>; from jgarzik@pobox.com on Fri, Jan 24, 2003 at 03:34:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 03:34:02PM -0500, Jeff Garzik wrote:
> On Fri, Jan 24, 2003 at 03:24:53PM -0500, Wiedemeier, Jeff wrote:
> > On Fri, Jan 24, 2003 at 03:05:38PM -0500, Jeff Garzik wrote:
> > If the intent is to just not use MSI on tg3 devices, I can use the pci
> > quirks to make sure that MSI gets turned off for tg3 devices.
> 
> hmmm, maybe I am missing something?

Quoting section 6.8.1.3 of the PCI 2.2 spec (talking about message
control in PCI config space):

  This register provides system software control over MSI. After reset,
  MSI is disabled (bit 0 is cleared) and the function requests servicing
  via its INTx# pin (if supported). System sofware can enable MSI by 
  setting bit 0 of this register. System software is permitted to 
  modify the Message Control register's read/write bits and fields.
  A device driver is not permitted to modify the Message Control
  register's read/write bits and fields.

> AFAICS, this is a per-driver decision, and needs to be done at the
> driver level, in the tg3 driver source.

The last sentence in the quote above indicates that it is not intended
(by the PCI spec) to be a per-driver decision, but rather a system
decision. The messages used are also a per-bus system resource and how
an MSI goes from the PCI bus to the rest of the system (i.e. the CPU(s))
is implementation dependent.
 
/jeff
