Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWG1Shw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWG1Shw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWG1Shw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:37:52 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:13021 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1161226AbWG1Shv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:37:51 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Date: Fri, 28 Jul 2006 12:37:45 -0600
User-Agent: KMail/1.9.1
Cc: Shem Multinymous <multinymous@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Matt Domsch <Matt_Domsch@dell.com>, "Brown, Len" <len.brown@intel.com>
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com> <200607272127.14689.bjorn.helgaas@hp.com> <20060728124940.GA26735@khazad-dum.debian.net>
In-Reply-To: <20060728124940.GA26735@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281237.45576.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 July 2006 06:49, Henrique de Moraes Holschuh wrote:
> On Thu, 27 Jul 2006, Bjorn Helgaas wrote:
> > > > If that's true, isn't it a BIOS defect if this embedded controller isn't
> > > > described via ACPI?
> > > 
> > > The ThinkPad ACPI tables do list the relevant IO ports (0x1600-0x161F)
> > > as reserved, but provide no way to discern what's behind them.
> > 
> > How are they listed?  Maybe an example would help.  Do you mean the
> 
> In the T43, very recent BIOS, it is inside _SB_.PCI0.LPC.SIO, where _HID is
> PNP0C02, and it holds resources to a number of different devices.  Port 1600
> is not even in a block by itself, it is in a block that reserves 0x42 bytes,
> while the EC occupies just 0x1600-0x161F.

And there are no other devices that consume 0x1600-0x161F?  Interesting.
I wonder what Windows does to bind drivers to the LPC devices?  Do they
have to do the same SMBIOS OEM string hack?

> The table (within the driver, for whitelisting) has exactly *one* substring
> for string match, that works for all models since the A31, and maybe even
> earlier ones.  The OEM string table used by IBM is quite stable.

I guess as long as they change the OEM string the same time they change
the EC/accelerometer/battery/kitchen-sink implementation, you're OK :-)
It just feels like living on borrowed time.
