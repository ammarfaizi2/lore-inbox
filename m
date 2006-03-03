Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWCCOky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWCCOky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWCCOkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 09:40:53 -0500
Received: from mail.humboldt.co.uk ([80.68.93.146]:31499 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP
	id S1751187AbWCCOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 09:40:53 -0500
Subject: Re: Linux running on a PCI Option device?
From: Adrian Cox <adrian@humboldt.co.uk>
To: Jon Ringle <jringle@vertical.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200603030909.28640.jringle@vertical.com>
References: <43EAE4AC.6070807@snapgear.com>
	 <200603021707.01190.jringle@vertical.com>
	 <1141377188.8912.25.camel@localhost.localdomain>
	 <200603030909.28640.jringle@vertical.com>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 14:40:43 +0000
Message-Id: <1141396843.8912.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 09:09 -0500, Jon Ringle wrote:
> On Friday 03 March 2006 04:13 am, Adrian Cox wrote:
> > If you're running on a PCI option device (unless using a 21555
> > non-transparent bridge), you need to disable CONFIG_PCI and write your
> > own driver for the PCI option device functionality.
> 
> Another requirement that I have that makes it difficult for me to disable 
> CONFIG_PCI is that the hardware component that is running Windows (and 
> therefore the PCI host) is optional hardware. If the Windows part is not 
> present, then the IXP will be configured (via hardware means) as a PCI host. 
> So, I need to detect at run time whether the IXP is in PCI option or PCI host 
> mode. If it is in PCI host mode then the code encapuslated by CONFIG_PCI must 
> be available.

Based on only a quick look at the code: if the Windows host is present,
don't call pci_common_init() in ixdp425_pci_init(). You then need to
write the entire CONFIG_PCI_GADGET code, and ensure that you only enable
it if the Windows host is present.

The greater problem is that these changes may work all the way up into
your application. If the Windows host is present, then you need its
cooperation to find other devices on the PCI bus.

-- 
Adrian Cox <adrian@humboldt.co.uk>

