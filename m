Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWG1Mts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWG1Mts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWG1Mts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:49:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46808 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751100AbWG1Mtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:49:47 -0400
X-Sasl-enc: rLYrfZbftIZYqnGhk/nIzmnBtXIruFlNqDxkJxWqKQA0 1154090989
Date: Fri, 28 Jul 2006 09:49:40 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Matt Domsch <Matt_Domsch@dell.com>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] DMI: Decode and save OEM String information
Message-ID: <20060728124940.GA26735@khazad-dum.debian.net>
References: <41840b750607270647w5a05ad00r613dbaf42bf04771@mail.gmail.com> <200607271010.53489.bjorn.helgaas@hp.com> <41840b750607270942l7a53010du1fabcf2a4b492789@mail.gmail.com> <200607272127.14689.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607272127.14689.bjorn.helgaas@hp.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Bjorn Helgaas wrote:
> > > If that's true, isn't it a BIOS defect if this embedded controller isn't
> > > described via ACPI?
> > 
> > The ThinkPad ACPI tables do list the relevant IO ports (0x1600-0x161F)
> > as reserved, but provide no way to discern what's behind them.
> 
> How are they listed?  Maybe an example would help.  Do you mean the

In the T43, very recent BIOS, it is inside _SB_.PCI0.LPC.SIO, where _HID is
PNP0C02, and it holds resources to a number of different devices.  Port 1600
is not even in a block by itself, it is in a block that reserves 0x42 bytes,
while the EC occupies just 0x1600-0x161F.

> That's fine.  The point is that for every device, ACPI should tell the
> OS the programming model (with _HID/_CID) and resources it uses (with
> _CRS/_PRS).  If ACPI doesn't do that, how is the OS supposed to know
> that it can't allocate those I/O ports to other devices?

Tell that to the vendors...

> > > it seems like the ideal way forward
> > > would be to get the BIOS fixed so you could claim the device with PNP
> > > for future ThinkPads, and the table of OEM strings would not require
> > > ongoing maintenance.
> > 
> > This is unrealistic. The hdaps and tp_smapi drivers support dozens of
> > ThinkPad models, each with a different BIOS.
> 
> If there's an ACPI defect, I think it's realistic to report it and
> ask for a fix in future releases.  Obviously you can't fix all the

I very much doubt you can pull that off, but if anyone has good contacts
within IBM/Lenovo's ThinkPad notebook division, we could try.  Heck, the
Thinkpad community have *firmware* fixes to send them and no channel
whatsoever to send a report to engineering.  Lenovo support doesn't let you
report something like that, unlike, say, Intel's.

> machines in the field, so you'd still need something like the OEM
> string table.  But if the BIOS were fixed for future machines, at
> least the OEM string table would stop growing.

The table (within the driver, for whitelisting) has exactly *one* substring
for string match, that works for all models since the A31, and maybe even
earlier ones.  The OEM string table used by IBM is quite stable.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
