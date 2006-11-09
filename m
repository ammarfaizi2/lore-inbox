Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423909AbWKIPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423909AbWKIPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423908AbWKIPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:04:25 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:64519 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1423909AbWKIPEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:04:24 -0500
Message-ID: <4553436D.30601@shadowen.org>
Date: Thu, 09 Nov 2006 15:04:13 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Nicolas DET <nd@bplan-gmbh.de>
CC: linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing compile failures on ppc64 in ohci-hcd.c as below:

In file included from drivers/usb/host/ohci-hcd.c:949:
drivers/usb/host/ohci-ppc-of.c: In function `ohci_hcd_ppc_of_init':
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type
arg (arg 2)
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type
arg (arg 3)
drivers/usb/host/ohci-ppc-of.c: At top level:
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `__inittest'
drivers/usb/host/ohci-pci.c:252: error: `__inittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `init_module'
drivers/usb/host/ohci-pci.c:252: error: `init_module' previously defined
here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `__exittest'
drivers/usb/host/ohci-pci.c:260: error: `__exittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `cleanup_module'
drivers/usb/host/ohci-pci.c:260: error: `cleanup_module' previously
defined here

Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
occured by default on my config then we end up with two module_init()
calls, which is illegal.

  powerpc-add-of_platform-support-for-ohci-bigendian-hc

I am guessing that we are only meant to be able to have one of these
defined at a time?  I changed the default to n for this and I could at
least compile the kernel, but I am sure thats not the right fix.

Nicolas?

-apw

