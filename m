Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWJXINp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWJXINp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJXINo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:13:44 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:22232 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932434AbWJXINN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:13:13 -0400
Message-ID: <453DCB17.6050304@s5r6.in-berlin.de>
Date: Tue, 24 Oct 2006 10:13:11 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux1394-devel@lists.sourceforge.net,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain> <1161675611.10524.598.camel@localhost.localdomain>
In-Reply-To: <1161675611.10524.598.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>> Recently, ohci1394 grew some "proper" error handling in its suspend
>> function, something that looks like:
>> 
>>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>>         if (err)
>>                 goto out;
...
> First, it breaks some old PowerBooks where the internal OHCI has no PM
> feature exposed on PCI....

Just out of curiosity: Are these HCs actual PCI hardware or are they
glued onto an extra PCI interface? Does the startup message of ohci1394
log OHCI 1.1 or 1.0 compliance for them? Probably the latter; OHCI 1.1
was released in January 2000.

OHCI 1.1 says "PCI based 1394 Open Host Controllers /should/ implement
PCI Power Management, and implementations that support PCI Power
Management /shall/ exhibit behavior consistent with this Annex."
(Emphasis mine.) I.e. a compliant HC does either not support power
management at all or supports it including the pci_set_power_state()
triggered state transitions.

OHCI 1.00 does not have a power management specification. It points to
the PCI Local Bus Specification Revision 2.1 though (which I don't have).

We are still working on full power management support by ohci1394 and
upper IEEE 1394 layers, so I am glad to get feedback and patches.
-- 
Stefan Richter
-=====-=-==- =-=- ==---
http://arcgraph.de/sr/
