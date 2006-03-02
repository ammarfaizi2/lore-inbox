Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752068AbWCBWKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbWCBWKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWCBWKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:10:44 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:11099 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1752068AbWCBWKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:10:43 -0500
Date: Thu, 02 Mar 2006 17:07:01 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
In-reply-to: <Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Greg Ungerer" <gerg@snapgear.com>, linux-kernel@vger.kernel.org
Message-id: <200603021707.01190.jringle@vertical.com>
Organization: Vertical
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43EAE4AC.6070807@snapgear.com>
 <200602281535.21974.jringle@vertical.com>
 <Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com>
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 04:13 pm, linux-os (Dick Johnson) wrote:
> On Tue, 28 Feb 2006, Jon Ringle wrote:
> > When I have the IXDP465 in PCI Option mode, Linux still writes to pci
> > configuration space which confuses the heck out of the PCI Host (Windows
> > 2003). What do I need to do in order to have Linux work as a PCI option
> > but still not mess with the pci configuration, and leave that task to the
> > PCI Host?
> >
> > Jon
>
> But anything on the PCI bus will get written, at least to find out
> the length of the address space. Please read about the PCI System
> Architecture. There are several writes that are mandatory. If
> somebody is attempting to configure the PCI devices, the following
> will occur.

Thanks for the book reference. I am reading it.

> (1) The BIOS will find some available address-space and put it
> into any base-address register that has memory-space enabled
> in the command register.
>
> (2) The BIOS will find some available I/O space and put it into
> a base-address register, too.
>
> This all occurs long before any OS is booted. These writes
> will occur.

That's all well and fine. However, I think I need to explain a bit better the 
hardware topology here.

             +--------------------+
             |     POST/BIOS      |
             |    Windows 2003    |
             |       Pentium      |
             |      PCI Host      |
             |      PCI Arbiter   |
             +--------------------+
                       |
<-------- PCI bus ---------------------------------->
    |                       |
+---------+           +---------------------------+    
| Various |           | IXDP465 (PCI option mode) |
|  other  |           |         Redboot           |
|   PCI   |           |      Linux 2.6.16-rc5     |
| Devices |           +---------------------------+
+---------+

When power is applied to the system, several things are happening 
simultaneously, as I understand it:

1) The POST/BIOS code executes on the Pentium side that should do the actions 
you describe above.
2) The PCI devices are configuring themselves.
3) The IXDP465 is executing Redboot bootloader, which hands off control to 
Linux.

As it turns out, Linux completes it's bootup before Windows bootup even 
begins, and it seems that Linux changes the configuration of the various 
other PCI devices that happen to be on the system as well. I need to get 
Linux to leave the configuration of other PCI devices it finds alone. It 
should only mess with it's own configuration. Why should Linux need to change 
the configuration of other PCI devices when it is fulfilling the role of a 
PCI device itself?

Thanks,

Jon
