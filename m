Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbUKRJo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbUKRJo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRJo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:44:59 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:46024 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262691AbUKRJo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:44:57 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: Re: Documentation/pci.txt inconsistency
Date: Thu, 18 Nov 2004 10:45:01 +0100
User-Agent: KMail/1.7.1
References: <200411171334.56492@bilbo.math.uni-mannheim.de> <20041117220310.GB1291@kroah.com>
In-Reply-To: <20041117220310.GB1291@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411181045.01691@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Nov 17, 2004 at 01:34:56PM +0100, Rolf Eike Beer wrote:
> > The examples in section 2 of Documentation/pci.txt use pci_get_*. Some
> > lines
> >
> > later there is this funny little paragraph:
> > > Note that these functions are not hotplug-safe.  Their hotplug-safe
> > > replacements are pci_get_device(), pci_get_class() and
> > > pci_get_subsys(). They increment the reference count on the pci_dev
> > > that they return. You must eventually (possibly at module unload)
> > > decrement the reference count on these devices by calling
> > > pci_dev_put().
> >
> > How about this:
> >
> > These functions are hotplug-safe. They increment the reference count on
> > the pci_dev that they return. You must eventually (possibly at module
> > unload) decrement the reference count on these devices by calling
> > pci_dev_put().
>
> Great, care to send a patch instead?

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.9/Documentation/pci.txt	2004-11-18 09:43:56.927721824 +0100
+++ linux-2.6.10-rc2/Documentation/pci.txt	2004-11-18 10:09:06.070297280 +0100
@@ -156,11 +156,9 @@
 VENDOR_ID or DEVICE_ID.  This allows searching for any device from a
 specific vendor, for example.
 
-Note that these functions are not hotplug-safe.  Their hotplug-safe
-replacements are pci_get_device(), pci_get_class() and pci_get_subsys().
-They increment the reference count on the pci_dev that they return.
-You must eventually (possibly at module unload) decrement the reference
-count on these devices by calling pci_dev_put().
+   These functions are hotplug-safe. They increment the reference count on
+the pci_dev that they return. You must eventually (possibly at module unload)
+decrement the reference count on these devices by calling pci_dev_put().
 
 
 3. Enabling and disabling devices
