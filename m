Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVCQW6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVCQW6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVCQW6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:58:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:32199 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261333AbVCQW6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:58:53 -0500
Subject: RE: PCI Error Recovery API Proposal. (WAS:: [PATCH/RFC]
	PCIErrorRecovery)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024080FDBA3@orsmsx404.amr.corp.intel.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080FDBA3@orsmsx404.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 09:57:58 +1100
Message-Id: <1111100278.25180.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On a fatal error the interface is down.  No matter what the driver
> supports (AER aware, EEH aware, unaware) all IO is likely to fail.
> Resetting a bus in a point-to-point environment like PCI Express or EEH
> (as you describe) should have little adverse effect.  The risk is the
> bus reset will cause a card reset and the driver must understand to
> re-initialize the card.  A link reset in PCI Express will not cause a
> card reset.  We assume the driver will reset its card if necessary.

Does the link side of PCIE provides a way to trigger a hard reset of the
rest of the card ? If not, then it's dodgy as there may be no way to
consistently "reset" the card if it's in a bad state. I have to double
check, but I suspect that IBM's implementation of EEH-compliant PCIE
will add a full hard reset not just a link reset.



