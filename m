Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWG1D1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWG1D1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWG1D1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:27:21 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:682 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750721AbWG1D1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:27:20 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Date: Thu, 27 Jul 2006 21:27:14 -0600
User-Agent: KMail/1.9.1
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Matt Domsch" <Matt_Domsch@dell.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com> <200607271010.53489.bjorn.helgaas@hp.com> <41840b750607270942l7a53010du1fabcf2a4b492789@mail.gmail.com>
In-Reply-To: <41840b750607270942l7a53010du1fabcf2a4b492789@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607272127.14689.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 10:42, Shem Multinymous wrote:
> On 7/27/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > I always thought that ACPI was supposed to describe everything that
> > (a) consumes resources or requires a driver and (b) is not enumerable
> > by other hardware standards such as PCI.
> >
> > If that's true, isn't it a BIOS defect if this embedded controller isn't
> > described via ACPI?
> 
> The ThinkPad ACPI tables do list the relevant IO ports (0x1600-0x161F)
> as reserved, but provide no way to discern what's behind them.

How are they listed?  Maybe an example would help.  Do you mean the
ACPI namespace has a device whose _CRS includes ports 0x1600-0x161F,
but that device's _HID is used for devices with different programming
models?  Or do you mean it's in some static table (not the namespace)?
Or is the device at 0x1600-0x161F really a bridge, and we can't
determine what's on the other side?

> BTW, I should clarify that this embedded controller interface (used by
> hdaps and tp_smapi) is different than the standard ACPI EC interface,
> and goes through different IO ports.

That's fine.  The point is that for every device, ACPI should tell the
OS the programming model (with _HID/_CID) and resources it uses (with
_CRS/_PRS).  If ACPI doesn't do that, how is the OS supposed to know
that it can't allocate those I/O ports to other devices?

> > it seems like the ideal way forward
> > would be to get the BIOS fixed so you could claim the device with PNP
> > for future ThinkPads, and the table of OEM strings would not require
> > ongoing maintenance.
> 
> This is unrealistic. The hdaps and tp_smapi drivers support dozens of
> ThinkPad models, each with a different BIOS.

If there's an ACPI defect, I think it's realistic to report it and
ask for a fix in future releases.  Obviously you can't fix all the
machines in the field, so you'd still need something like the OEM
string table.  But if the BIOS were fixed for future machines, at
least the OEM string table would stop growing.

Bjorn
