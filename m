Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWCCONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWCCONM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWCCONL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:13:11 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:8859 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751112AbWCCONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:13:10 -0500
Date: Fri, 03 Mar 2006 09:09:28 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
In-reply-to: <1141377188.8912.25.camel@localhost.localdomain>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
Message-id: <200603030909.28640.jringle@vertical.com>
Organization: Vertical
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43EAE4AC.6070807@snapgear.com>
 <200603021707.01190.jringle@vertical.com>
 <1141377188.8912.25.camel@localhost.localdomain>
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 March 2006 04:13 am, Adrian Cox wrote:
> On Thu, 2006-03-02 at 17:07 -0500, Jon Ringle wrote:
> > As it turns out, Linux completes it's bootup before Windows bootup even
> > begins, and it seems that Linux changes the configuration of the various
> > other PCI devices that happen to be on the system as well. I need to get
> > Linux to leave the configuration of other PCI devices it finds alone. It
> > should only mess with it's own configuration. Why should Linux need to
> > change the configuration of other PCI devices when it is fulfilling the
> > role of a PCI device itself?
>
> Have you disabled CONFIG_PCI?
>
> CONFIG_PCI is the configuration option for a PCI host, just as
> CONFIG_USB is the configuration option for a USB host. Linux contains
> code for CONFIG_USB_GADGET, but what you need is the non-existent
> CONFIG_PCI_GADGET.
>
> If you're running on a PCI option device (unless using a 21555
> non-transparent bridge), you need to disable CONFIG_PCI and write your
> own driver for the PCI option device functionality.

Another requirement that I have that makes it difficult for me to disable 
CONFIG_PCI is that the hardware component that is running Windows (and 
therefore the PCI host) is optional hardware. If the Windows part is not 
present, then the IXP will be configured (via hardware means) as a PCI host. 
So, I need to detect at run time whether the IXP is in PCI option or PCI host 
mode. If it is in PCI host mode then the code encapuslated by CONFIG_PCI must 
be available.

I can see now that I also have a need to have a "CONFIG_PCI_GADGET".

Jon
