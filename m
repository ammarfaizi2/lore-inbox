Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUHSGim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUHSGim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUHSGil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:38:41 -0400
Received: from fmr01.intel.com ([192.55.52.18]:5274 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265996AbUHSGii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:38:38 -0400
Subject: Re: 2.6.8.1-mm1 broke USB driver with ACPI pci irq routing... info
	follows
From: Len Brown <len.brown@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
       Cyrille Ch?p?lov <cyrille@chepelov.org>
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C37A2@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C37A2@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092897504.25902.220.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Aug 2004 02:38:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 19:40, Bjorn Helgaas wrote:

> Make acpi_irq_penalty non-initdata, since it's used by the
> non_init acpi_pci_link_allocate().

hmmm, now that we need to keep this around, we might consider squeezing
it down to, say 64 bytes.  This stuff will probably never run for IRQs >
64 and probably a byte/level is enough.

>   And make acpi_irq_penalty_init()
> __init, since it is used only by the __init pci_acpi_init().
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

I'll apply this Bjorn.

I have to complement you on your paranoia to
1. keep acpi_pci_irq_enable(dev) for all devices in 2.6.8
2. add pci=routeirq to diagnose the breakage when you took it out

thanks,
-Len


