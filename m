Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVEZQz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVEZQz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVEZQz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:55:56 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:10145 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261604AbVEZQzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:55:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CSB5 IDE does not fully support native mode??
Date: Thu, 26 May 2005 10:55:38 -0600
User-Agent: KMail/1.8
Cc: evt@texelsoft.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <200505242026.DJT32107@ms3.netsolmail.com> <1117117463.5743.149.camel@localhost.localdomain>
In-Reply-To: <1117117463.5743.149.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261055.38137.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 8:24 am, Alan Cox wrote:
> In order to keep the legacy world from falling to bits IDE and VGA have
> some ugly hacks in the PCI spec.
> 
> In legacy mode an IDE device appears at the "old" standard IDE addresses
> and uses an external IRQ pin wired to the ISA IRQ lines (14 or 15). In 
> native mode it behaves like a PCI device, honouring the PCI bars and
> using the PCI INT lines.

This has been niggling in my mind for a while -- in legacy mode,
the device should use IRQ 14/15.  But I think we still call
pci_enable_device(), which sets up IRQ routing according to
the usual PCI rules.  Should we be using pci_enable_device()
at all in legacy mode?
