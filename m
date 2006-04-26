Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWDZLkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWDZLkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDZLkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:40:05 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:45783 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S932406AbWDZLkE convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:40:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI ERROR: Segmentation fault in pci_do_scan_bus
Date: Wed, 26 Apr 2006 17:05:55 +0530
Message-ID: <4F36B0A4CDAD6F46A61B2B32C33DC69C025569E4@BLR-EC-MBX03.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI ERROR: Segmentation fault in pci_do_scan_bus
Thread-Index: AcZo+gzwGk2abkBKT1WaIyz8MlsRIgAKe9CQ
From: <biswa.nayak@wipro.com>
To: <greg@kroah.com>
Cc: <Linux-Kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Apr 2006 11:39:47.0562 (UTC) FILETIME=[1EF404A0:01C66926]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg for your reply. My comments are below.

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Greg KH

> >On Tue, Apr 25, 2006 at 05:25:32PM +0530, biswa.nayak@wipro.com
wrote:
> > Hi
> > 
> > I am getting segmentation fault, consistently on call to 
> > 'pci_do_scan_bus'. This is a small test code ( attached with this 
> > mail) to test the APIs exposed by the PCI subsystem.

> The module code you attached isn't exactly "small" :)
> What chunk of code is causing the problem?
> Why are you scanning the PCI bus from a module?

Sorry for attaching the whole module. 
Initially I thought of sending only the part which is causing the
problem, but
later thought of sending full module which is compiling and working for
better understanding.

In my code inside 'test_scan_bus' I am calling 'pci_do_scan_bus' in that
case I am getting the segmentation fault.

I am developing a test suite which will validate all the BSPs. 
That's the reason I am calling this exported APIs from the subsystem to
verify that things are working fine. 

> > I just checked where it
> >  faults and found out that inside 'sysfs_create_bin_file' it is not 
> > able  to find the kobject out of the dev pointer passed to it. Now 
> > extracting  of the dev object out of the bus pointer is done by  
> > 'list_for_each_entry(dev, &bus->devices, bus_list)' in  
> > 'pci_bus_add_devices'. Now I am not able to understand why the
kobject  
> > is missing. Is it something that I am missing or is it a kernel
defect?
> > Any help in this will be really appreciated. The bug message is
pasted  
> > below.

> I'm confused as to why you are trying to set up the pci bus for a pci
bus that is already set up.
> That's why the function is dying...

I am not trying to set up the already set up bus ( or is it what I am
doing by making a call to this function?). My intention is to call all
the APIs provided by all the subsystem of the system, like PCI, USB,
UART, FS etc...

I am doing something seriously wrong over here?

Thanks
~Biswa
