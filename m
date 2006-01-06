Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752359AbWAFQ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbWAFQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWAFQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53259 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752232AbWAFQ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:34 -0500
Date: Fri, 6 Jan 2006 17:29:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/acpi/scan.c: inconsequent NULL handling
Message-ID: <20060106162929.GK12131@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
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

