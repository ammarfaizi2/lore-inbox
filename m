Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWJTNFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWJTNFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 09:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWJTNFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 09:05:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:9869 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030269AbWJTNFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 09:05:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Allen Martin" <AMartin@nvidia.com>
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
Date: Fri, 20 Oct 2006 15:04:51 +0200
User-Agent: KMail/1.9.3
Cc: "Robert Hancock" <hancockr@shaw.ca>, "Len Brown" <lenb@kernel.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Daniel Mierswa" <impulze@impulze.org>,
       "Andy Currid" <ACurrid@nvidia.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48D31D@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00E48D31D@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201504.51657.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well that's the problem.  The issue only existed in the nForce2
> reference BIOS (and maybe early in nForce3) but we still occasionally

Definitely some NF3 too, i've seen it on 64bit boxes.

> see shipping customer BIOSes to this day that have this same bug for
> nForce5 (like M2NPV referenced in this thread).
> 
> Probably what ASUS is doing in the M2NPV BIOS is copying the ACPI tables
> from an earlier nForce2 product.

But the timer override is correct or still broken?

> Probably what needs to happen is to make the HPET check more robust and
> only return 1 if HPET is present and enabled.

I think the problem is that those Asus boards also don't have a HPET
table. So even though NF5 has HPET the kernel doesn't know about it
and the heuristic "if HPET then NF5 and timer override ok" breaks.

I still suspect doing a 
"if (PCI ID from NF2 or NF3) ignore timer override" 
is probably the best solution right now. But I don't have a full
list of PCI-IDs for NF2/NF3. Do you have one?

Ok that might still break the NF4. I assume it never needs any
timer overrides so it might be safe to include it in the PCI-IDs
too.

Or do you have a better proposal?

-Andi
