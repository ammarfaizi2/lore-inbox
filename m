Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWCBXBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWCBXBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCBXBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:01:32 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:39324 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750985AbWCBXBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:01:31 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 0/9] PNP: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:01:27 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021601.27467.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches removes the assumption that pnp_register_driver()
returns the number of devices claimed.  Returning the count is unreliable
because devices may be hot-plugged in the future.  (Many devices don't
support hot-plug, of course, but PNP in general does.)

This changes the convention to "zero for success, or a negative error
value," which matches pci_register_driver(), acpi_bus_register_driver(),
and platform_driver_register().

If drivers need to know the number of devices, they can count calls
to their .probe() methods.
