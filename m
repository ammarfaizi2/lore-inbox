Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVAMRS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVAMRS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVAMROY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:14:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:52986 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261207AbVAMRNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:13:44 -0500
Subject: Re: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200501121655.42947.jbarnes@engr.sgi.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
	 <200501121655.42947.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1105636311.30960.8.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 11:11:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse-

I'm having trouble with enabling the legacy PCI stuff.  I added #define
HAVE_PCI_LEGACY to pci.h, but probe.c doesn't build:

drivers/pci/probe.c: In function `pci_create_legacy_files':
drivers/pci/probe.c:50: error: `pci_read_legacy_io' undeclared (first
use in this function)
drivers/pci/probe.c:50: error: (Each undeclared identifier is reported
only oncedrivers/pci/probe.c:50: error: for each function it appears
in.)
drivers/pci/probe.c:51: error: `pci_write_legacy_io' undeclared (first
use in this function)
drivers/pci/probe.c:60: error: `pci_mmap_legacy_mem' undeclared (first
use in this function)

Am I missing something obvious? :)

Thanks-
John

On Wed, 2005-01-12 at 18:55, Jesse Barnes wrote:
> On Wednesday, January 12, 2005 4:39 pm, John Rose wrote:
> > The removal of the class device from sysfs is carried out explicitly by
> > class_device_del(), which occurs prior to class_device_put().  The class
> > device is gone from sysfs by the time class_device_put() is called.  As
> > such, this release function should not carry out sysfs cleanups for the
> > class device.
> >
> > I'm unsure how pci_remove_legacy_files() doesn't cause the same crash for
> > those who implemented it, but I'll leave that alone for now.
> 
> Feel free to fix it too.  I haven't tested the removal case, so thanks for 
> catching it.
> 
> Jesse
> 

