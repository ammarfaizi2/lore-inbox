Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263082AbUJ2EGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUJ2EGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUJ2EGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:06:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263082AbUJ2EGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:06:17 -0400
Message-ID: <4181C1AA.7050004@pobox.com>
Date: Fri, 29 Oct 2004 00:06:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Moore, Robert" <robert.moore@intel.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, "Brown, Len" <len.brown@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: Why ACPI is in the kernel, notes from 2001
References: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moore, Robert wrote:
> Here's some notes from 2001:
> 
> Why ACPI is in the kernel
> 
> ACPI and the AML interpreter are required very early during kernel
> initialization, before the device drivers are loaded.  Control methods
> are executed by the interpreter at this time (such as all device _INI
> methods).
> 
> ACPI owns the ACPI hardware and ACPI interrupt (SCI), and therefore this
> part of the ACPI subsystem is similar to a device driver.
> 
> Control methods that are executed via the AML interpreter are allowed
> direct access to all of physical memory, all I/O space, and all PCI
> configuration space (via Operation Regions.)
> 
> Device drivers such as the Embedded Controller, Battery, and Thermal use
> ACPI services and execute AML control methods during their operation.
> 
> Device driver callback routines are invoked directly from the AML
> interpreter when the ASL Notify operation is executed.
> 
> ACPI and the AML interpreter cannot be paged out.  How do you wake up
> the disk used for paging?  Not a good idea for other device drivers to
> depend on code that may be paged out.
> 
> Also,
> 
> As of May 2000, the AML interpreter was in acpid! Shortly after that, we
> made a conscious decision to move it into the driver for the reasons
> above.  The code may be large (for Linux), but it is necessary and must
> remain resident (it is non-pageable).


None of this implies that the interpreter cannot be in initramfs-like 
userspace, which neither requires a device driver nor will ever be paged 
out.

	Jeff


