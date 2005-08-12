Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbVHLIJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbVHLIJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVHLIJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 04:09:29 -0400
Received: from [81.2.110.250] ([81.2.110.250]:46742 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750831AbVHLIJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 04:09:27 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>
In-Reply-To: <200508111707.30861.bjorn.helgaas@hp.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <20050811214807.GA9775@havoc.gtf.org> <42FBC985.4030602@pobox.com>
	 <200508111707.30861.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 09:35:50 +0100
Message-Id: <1123835751.22460.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-11 at 17:07 -0600, Bjorn Helgaas wrote:
> So the scenario in question (correct me if I'm wrong) is that we
> have a PCI IDE device that is handed off in compatibility mode (and
> may only work in that mode).  In that case, the PCI *device* still
> exists, so shouldn't the IDE PCI code claim that device, notice that
> it's in compatibility mode, and use the legacy ports and IRQs if
> necessary?

The PCI IDE code and legacy IDE code both find the device and they
realise its the same device so that it is driven by a suitable driver.
The legacy IDE driver is useful if your platform has an unsupported IDE
controller. It seems ot me the correct fix for IA64 is probably to set
your arch specific probe address function to only probe the standard PCI
legacy ports and to do any other appropriate checks, not to take an axe
to Kconfig. 

Alan

