Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCRCoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCRCoq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCRCoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:44:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:42185 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261382AbVCRCom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:44:42 -0500
Subject: RE: PCI Error Recovery API Proposal. (WAS::  [PATCH/RFC]
	PCIErrorRecovery)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Linas Vepstas <linas@austin.ibm.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, ak@muc.de,
       Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080FDC40@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080FDC40@orsmsx404.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 13:43:37 +1100
Message-Id: <1111113817.25180.79.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 10:53 -0800, Nguyen, Tom L wrote:

> To support the AER driver calling an upstream device to initiate a reset
> of the link we need a specific callback since the driver doing the reset
> is not the driver who got the error.  In the case of general PCI this
> could be useful if a PCI bus driver were available to support the
> callback for a bridge device.  This would also support specific error
> recovery calls to reset an endpoint adapter.  We need a call to request
> a driver to perform a reset on a link or device.  

That is quite implementation specific, it doesn't need to be part of the
API (the way the general error management is implemented in PCIE could
be completely done within the bus drivers I suppose). Again, I'm not
trying to define or force a given implementation. I'm trying to define
the driver-side API, that's all.

I have difficulties following all of your previous explanations, I must
admit. My point here is I'd like you to find out if the API can fit on
the driver side, and if not, what would need to be changed. For example,
we might want to distinguish between slot reset (full hard reset) and
link reset, that sort of thing (thus adding a new state for link reset
and a new return code for the others for requesting a link reset if
possible, platforms that don't do it, like IBM EEH PCI would just
fallback to full reset).

Again, the goal here is to have a way for drivers to be mostly bus
agnostic (that is not have to care if they are running on PCI, PCI-X,
PCIE, with or without IBM EEH mecanism, and whatever other mecanism
another vendor might provide) and still implement basic error recovery.

A driver _designed_ for a PCI-Express deviec that knows it's on PCI
Express can perfectly use additional APIs to gather more error details,
etc... but it would be nice to fit the "common needs" as much as
possible in a common and _SIMPLE_ API. The simplicity here is a
requirement, I'm very serious about it, because if it's not simple,
drivers either won't implement it or won't get it right.

Ben.


