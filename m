Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVBGWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVBGWei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVBGWeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:34:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:41982 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261286AbVBGWeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:34:11 -0500
Message-ID: <4207ECDB.7060506@us.ibm.com>
Date: Mon, 07 Feb 2005 16:34:03 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com> <20050207221820.GA27543@kroah.com>
In-Reply-To: <20050207221820.GA27543@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Feb 07, 2005 at 04:00:27PM -0600, brking@us.ibm.com wrote:
> 
>>Currently, code exists in the pci layer to allow userspace to specify
>>driver data when adding a pci dynamic id from sysfs. However, this data
>>is never used and there exists no way in the existing code to use it.
> 
> 
> Which is a good thing, right?  "driver_data" is usually a pointer to
> somewhere.  Having userspace specify it would not be a good thing.

That depends on the driver usage, and the patch allows it to be 
configurable and defaults to not being used.

>>This patch allows device drivers to indicate that they want driver data
>>passed to them on dynamic id adds by initializing use_driver_data in their
>>pci_driver->pci_dynids struct. The documentation has also been updated
>>to reflect this.
> 
> 
> What driver wants to use this?

I am in the process of adding dynids support into the ipr scsi driver. I 
originally was using driver_data as a pointer, but am changing it to be 
an index instead, so that it can be specified by the user.

There are essentially 2 different types of chipsets that ipr controls, 
the primary difference being the register offsets. I am using 
driver_data to figure that out today.

My other option is to somehow change the driver to cope with having no 
driver data, but that will result in more driver code and will 
ultimately be less flexible in the new chipsets that can be added using 
dynids.


-Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
