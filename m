Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbUKKHKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbUKKHKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUKKHKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:10:08 -0500
Received: from fmr12.intel.com ([134.134.136.15]:10460 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262179AbUKKHJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:09:57 -0500
Subject: Re: [PATCH/RFC 1/4]device core changes
From: Li Shaohua <shaohua.li@intel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>, Greg <greg@kroah.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041110042822.A13318@flint.arm.linux.org.uk>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
	 <20041108225810.GB16197@kroah.com>
	 <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
	 <1099971341.15294.48.camel@sli10-desk.sh.intel.com>
	 <20041109045843.GA4849@kroah.com>
	 <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
	 <20041110012443.GA9496@kroah.com>
	 <1100051137.7825.6.camel@sli10-desk.sh.intel.com>
	 <20041110042822.A13318@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1100156613.8769.26.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 15:03:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 12:28, Russell King wrote:
> On Wed, Nov 10, 2004 at 09:45:37AM +0800, Li Shaohua wrote:
> > On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > > Maybe your other patches weren't so bad...  If we implement them, can we
> > > drop the platform notify stuff?
> > Currently only ARM use 'platform_notify', and we can easily convert it
> > to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
> > is we will have many '#ifdef ..' if many platforms implement their
> > per-bus 'platform_bind'.
> 
> Except none of the merged ARM platforms use platform_notify, and I haven't
> seen any suggestion in the ARM world of why it would be needed.
Ok, let me summarize it. we now have two options:
1. using 'platform_notify'
platform_notify only has one parameter 'struct device', we must know the
exact bus type of a device. We can identify the bus type from its name
(such as 'pci', 'ide'), but it's quite some ugly. Or we can add a 'type'
flag in the 'struct bus_type' to indicate the exact bus type which Greg
doesn't like it. One shortcoming is the method hasn't good flexibility,
we must add a new type whenever a new bus type is added.
2. using per-bus type 'platform_bind'
Every bus type defines a 'platform_bind', so we know the exact bus type
naturally in platform_bind. The method can't handle special devices,
such as PCI root bridge, which hasn't a bus type, so no 'platform_bind'
is invoked for them. we must use some tricky methods to work around.
Another concern is the chaos if many platforms define 'platform_bind'
for a bus type, which isn't a big problem currently.
Greg, it seems you tend to option 2, isn't it?

Thanks,
Shaohua

