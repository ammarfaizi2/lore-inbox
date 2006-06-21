Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWFUWZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWFUWZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWFUWZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:25:16 -0400
Received: from mga06.intel.com ([134.134.136.21]:39355 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030345AbWFUWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:25:13 -0400
X-IronPort-AV: i="4.06,163,1149490800"; 
   d="scan'208"; a="54824361:sNHT49695912"
Date: Wed, 21 Jun 2006 15:19:43 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Brice Goglin <brice@myri.com>, LKML <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because of e820
Message-ID: <20060621151942.A17228@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <44907A8E.1080308@myri.com> <44907B13.2030402@linux.intel.com> <4490BE76.6040008@myri.com> <4491029D.4060002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4491029D.4060002@linux.intel.com>; from arjan@linux.intel.com on Wed, Jun 14, 2006 at 11:47:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 11:47:57PM -0700, Arjan van de Ven wrote:
> 
> > We need to improve this "mmconfig disabled" anyhow. Having the extended
> > config space unavailable on lots of machines is also far from a viable
> > solution :)
> 
> it's unlikely to be many machines though.
> 
I just noticed today - this check killed PCI Express on 3 of the 4
machines I normally use for testing. Digging a bit deeper, I found
this in the PCI firmware spec (v 3.0):

If the operating system does not natively comprehend reserving the
MMCFG region, the MMCFG region must be reserved by firmware. The
address range reported in the MCFG table or by _CBA method (see
Section 4.1.3) must be reserved by declaring a motherboard resource.
For most systems, the motherboard resource would appear at the root
of the ACPI namespace (under \_SB) in a node with a _HID of EISAID
(PNP0C02), and the resources in this case should not be claimed in
the root PCI bus.s _CRS. The resources can optionally be returned in
Int15 E820 or EFIGetMemoryMap as reserved memory but must always be
reported through ACPI as a motherboard resource

Sure enough, the ACPI namespace for the "broken" machines lists
the MMCFG resources as indicated above, and PCI Express works fine
otherwise. I haven't looked yet whether it's possible to add this
check in the code, have you looked into that option? I understand
the PCI firmware spec is not necessarily the final authority on
this, but a _lot_ of BIOS developers read that to figure out what
to do...

Rajesh
