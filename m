Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934180AbWKTOZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934180AbWKTOZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934181AbWKTOZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:25:41 -0500
Received: from c2bthomr13.btconnect.com ([194.73.73.229]:17519 "EHLO
	c2bthomr13.btconnect.com") by vger.kernel.org with ESMTP
	id S934180AbWKTOZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:25:40 -0500
Subject: Re: [PATCH] PCMCIA identification strings for cards manufactured
	by Elan
From: Tony Olech <tony.olech@elandigitalsystems.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
In-Reply-To: <20061120130237.GA22330@flint.arm.linux.org.uk>
References: <200611201214.kAKCErcU005240@imap.elan.private>
	 <20061120130237.GA22330@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Elan Digital Systems Limited
Date: Mon, 20 Nov 2006 14:23:02 +0000
Message-Id: <1164032582.30853.36.camel@n04-143.elan.private>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: rmk+lkml@arm.linux.org.uk
Elan-message-recipient: linux@dominikbrodowski.net
Elan-message-recipient: linux-pcmcia@lists.infradead.org
Elan-message-recipient: perex@suse.cz
Elan-message-recipient: dahinds@users.sourceforge.net
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The strings came from our company product database.
I do not have the time to track down examples of each
varient, but here are the two I have been testing with:

Socket 0:
  product info: "Elan", "Serial+Parallel Port: SP230", "1.00",
"KIT:K51477-006           "
  manfid: 0x015d, 0x4c45
  function: 2 (serial)

Socket 1:
  product info: "Elan", "Serial Port: SL332", "1.01", "KIT:K51520-027
"
  manfid: 0x015d, 0x4c45
  function: 2 (serial)

AND NO, matching on function ID just randomly locked up the
kernel, but now I think that was because of the "pdaudiocf"
module and its MANF_ID/CARD_ID number matching.

Tony Olech
Elan Digital Systems Limited
-----------------------------------------------------------------
On Mon, 2006-11-20 at 13:02 +0000, Russell King wrote:
> On Mon, Nov 20, 2006 at 11:17:15AM +0000, Tony Olech wrote:
> > In older versions of the linux kernel it was sufficient for the
> > 16-bit PCMCIA card manufacturer to distribute or make available
> > a text configuration file along with the physical cards. Such a
> > file with an extension of ".conf" and placed in the /etc/pcmcia
> > very easily enabled new hardware without rebuilding the kernel,
> > however with the new scheme of things, having found no userland
> > solution to the problem of new 16bit pcmcia card identification
> > this patch enumerates Elan Digital Systems strings.
> 
> > *** linux-2.6.18/drivers/serial/serial_cs.c.orig	2006-11-17 10:59:10.000000000 +0000
> > --- linux-2.6.18/drivers/serial/serial_cs.c	2006-11-17 10:59:54.000000000 +0000
> > ***************
> > *** 786,793 ****
> > --- 786,817 ----
> >   	PCMCIA_DEVICE_CIS_PROD_ID12("ADVANTECH", "COMpad-32/85B-4", 0x96913a85, 0xcec8f102, "COMpad4.cis"),
> >   	PCMCIA_DEVICE_CIS_PROD_ID123("ADVANTECH", "COMpad-32/85", "1.0", 0x96913a85, 0x8fbe92ae, 0x0877b627, "COMpad2.cis"),
> >   	PCMCIA_DEVICE_CIS_PROD_ID2("RS-COM 2P", 0xad20b156, "RS-COM-2P.cis"),
> >   	PCMCIA_DEVICE_CIS_MANF_CARD(0x0013, 0x0000, "GLOBETROTTER.cis"),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100  1.00.",0x19ca78af,0xf964f42b),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL100",0x19ca78af,0x71d98e83),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232  1.00.",0x19ca78af,0x69fb7490),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c1997.","SERIAL CARD: SL232",0x19ca78af,0xb6bc0235),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232",0x63f2e0bd,0xb9e175d3),
> > + 	PCMCIA_DEVICE_PROD_ID12("ELAN DIGITAL SYSTEMS LTD, c2000.","SERIAL CARD: CF232-5",0x63f2e0bd,0xfce33442),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232",0x3beb8cf2,0x171e7190),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF232-5",0x3beb8cf2,0x20da4262),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF428",0x3beb8cf2,0xea5dd57d),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: CF500",0x3beb8cf2,0xd77255fa),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: IC232",0x3beb8cf2,0x6a709903),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: SL232",0x3beb8cf2,0x18430676),
> > + 	PCMCIA_DEVICE_PROD_ID12("Elan","Serial Port: XL232",0x3beb8cf2,0x6f933767),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(0,"Elan","Serial+Parallel Port: SP230",0x3beb8cf2,0xdb9e58bc),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: CF332",0x3beb8cf2,0x16dc1ba7),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL332",0x3beb8cf2,0x19816c41),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL385",0x3beb8cf2,0x64112029),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(1,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(2,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> > + 	PCMCIA_MFC_DEVICE_PROD_ID12(3,"Elan","Serial Port: SL432",0x3beb8cf2,0x1cce7ac4),
> 
> Shouldn't these be matched by the function ID?  Show the full output
> of cardctl ident (or whatever the pcmcia-utils equivalent is).
> 

