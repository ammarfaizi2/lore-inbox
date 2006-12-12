Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbWLLBi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWLLBi3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWLLBi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:38:29 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:7384 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbWLLBi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:38:28 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
X-Message-Flag: Warning: May contain useful information
References: <20061208182241.786324000@osdl.org>
	<20061208182500.611327000@osdl.org>
	<1165809339.7260.19.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 11 Dec 2006 17:38:24 -0800
In-Reply-To: <1165809339.7260.19.camel@localhost.localdomain> (Benjamin Herrenschmidt's message of "Mon, 11 Dec 2006 14:55:39 +1100")
Message-ID: <adafyblzyen.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Dec 2006 01:38:24.0924 (UTC) FILETIME=[3708E5C0:01C71D8E]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm worried by this... At no point do you check the host bridge
 > capabilities, and thus will happily set the max read req size to some
 > value larger than the max the host bridge can cope...

Well, it's disabled by default... the option is there as a quick way
to fix "why is my bandwidth so low" when a broken BIOS sets these to
minimum values.  Maybe we should just strip out that code and point
people who want to tweak this at setpci instead.

 > So for PCI-X, if we want tat, we need a pcibios hook for the platform
 > to validate the size requested. For PCI-E, we can use standard code to
 > look for the root complex (and bridges on the path to it) and get the
 > proper max value.

Actually even PCIe might not be that easy.  For example with current
kernels on PowerPC 440SPe (SoC with PCIe), I just get:

    # lspci
    00:01.0 InfiniBand: Mellanox Technology: Unknown device 6274 (rev a0)

ie no host bridge / root complex.

 - R.
