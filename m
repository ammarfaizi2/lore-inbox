Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVCREG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVCREG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCRECu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:02:50 -0500
Received: from ozlabs.org ([203.10.76.45]:52709 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261399AbVCREBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:01:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16954.21127.536184.940537@cargo.ozlabs.ibm.com>
Date: Fri, 18 Mar 2005 15:01:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, ak@muc.de,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]
	PCIErrorRecovery)
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080FDC40@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080FDC40@orsmsx404.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nguyen, Tom L writes:

> We decided to implement PCI Express error handling based on the PCI
> Express specification in a platform independent manner.  This allows any
> platform that implements PCI Express AER per the PCI SIG specification
> can take advantage of the advanced features, much like SHPC hot-plug or
> PCI Express hot-plug implementations.

Does the PCI Express AER specification define an API for drivers?

> For PCI Express the endpoint device driver can take recovery action on
> its own, depending on the nature of the error so long as it does not
> affect the upstream device.  This can include endpoint device resets.

Likewise, with EEH the device driver could take recovery action on its
own.  But we don't want to end up with multiple sets of recovery code
in drivers, if possible.  Also we want the recovery code to be as
simple as possible, otherwise driver authors will get it wrong.

> To support the AER driver calling an upstream device to initiate a reset
> of the link we need a specific callback since the driver doing the reset
> is not the driver who got the error.  In the case of general PCI this

I would see the AER driver as being included in the "platform" code.
The AER driver would be be closely involved in the recovery process.

What is the state of a link during the time between when an error is
detected and when a link reset is done?  Is the link usable?  What
happens if you try to do a MMIO read from a device downstream of the
link?

Regards,
Paul.
