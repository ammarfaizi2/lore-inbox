Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVCXUsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVCXUsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCXUo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:44:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42254 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261184AbVCXUlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:41:12 -0500
Date: Thu, 24 Mar 2005 21:41:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/acpi/scan.c: inconsequent NULL handling
Message-ID: <20050324204109.GC3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found the following:

<--  snip  -->

static int
acpi_bus_match (
        struct acpi_device      *device,
        struct acpi_driver      *driver)
{
        if (driver && driver->ops.match)
                return driver->ops.match(device, driver);
        return acpi_match_ids(device, driver->ids);
}

<--  snip  -->


Either driver can be NULL, in which case the driver->ids is a possible 
NULL pointer reference, or it can't, in which case the check whether 
it's NULL is superfluous.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

