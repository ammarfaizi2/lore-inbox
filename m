Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbUKLWcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUKLWcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUKLWcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:32:08 -0500
Received: from colo.lackof.org ([198.49.126.79]:33231 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262643AbUKLWcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:32:01 -0500
Date: Fri, 12 Nov 2004 15:31:59 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041112223159.GC8828@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D84972020F3C9D@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3C9D@NT-IRVA-0741.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 01:49:18PM -0800, Michael Chan wrote:
> I disagree with your interpretations of the ECN.

Yeah -  I think the alternatives suggested in the new Implementation
Note are confusing and distracting from the actual definitions
and declarations in the previous parts of the spec. The Implementation
Note is NOT the spec. It's just advisory.

The ECN starts out by defining two classes of systems:

| Make the Enhanced Configuration Access Mechanism required for
| PC-compatible platforms, but optional for platforms based on other
| processor/system architectures where firmware abstractions are
| provided for the configuration space access (e.g., DIG64 compliant systems).

The last phrase "where firmware abstractions" is the key bit.


> 2. mmconfig implementation must provide a method for software to
> guarantee that the config access has completed before software execution
> continues.

Agreed.

>  In Implementation Note, it provides some examples on how to
> do this. One example is to make mmconfig non-posted. But there are other
> examples.

Yes, but the patch only modifies code for arches which use
direct access to generate the mmconfig cycles. I believe the
posted write examples are for systems which provide "an architected
firmware interface". I'm pretty sure "software" in this context
refers to the "firmware" (e.g. SAL). This spec wasn't written exclusively
for OS dorks like us.

> In short, I believe mmconfig is allowed to be posted or non-posted. If
> it is posted, there must be a method to allow software to flush it.

Yes. Agreed.
But existing direct access methods must implement non-postable writes
to be compliant.

E.g. the second paragraph of the Implementation Note:
| In those cases in which the software must know that a posted
| transaction is completed by the completer, ...

IMHO, "In those cases" refers to the second class of systems.
i386 and x86_64 are (still) in the first class of "legacy" systems.

hth,
grant
