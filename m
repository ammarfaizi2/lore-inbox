Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbWFVL4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWFVL4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWFVL4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:56:33 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:54744 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1161088AbWFVL4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:56:32 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.2
Subject: Re: how I know if a interrupt is ioapic_edge_type or 
	ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
       cw@f00f.org, vsu@altlinux.ru
In-Reply-To: <20060621210817.74b6b2bc.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com>
	 <1150936606.2855.21.camel@localhost.portugal>
	 <20060621174754.159bb1d0.rdunlap@xenotime.net>
	 <1150938288.3221.2.camel@localhost.portugal>
	 <20060621210817.74b6b2bc.rdunlap@xenotime.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 22 Jun 2006 12:56:25 +0100
Message-Id: <1150977386.2859.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 21:08 -0700, Randy.Dunlap wrote:
> 
> If you have a specific issue/problem, it would probably be
> better just to focus on that. 

on linux-2.6.17/drivers/pci/quirks.c	

  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
  * interrupts delivered properly.
  */

 static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;

I want here put something like:  if ( dev->irq != XT-PIC) return and don't quirk this dev.
 	else 

	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 

--
Sérgio M. B.

