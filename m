Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbUKLUzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbUKLUzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 15:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbUKLUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 15:55:23 -0500
Received: from colo.lackof.org ([198.49.126.79]:61125 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262615AbUKLUzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 15:55:11 -0500
Date: Fri, 12 Nov 2004 13:55:09 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041112205509.GB8828@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D84972020F3C9C@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1508D50A0692F42B217C22C02D84972020F3C9C@NT-IRVA-0741.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 11:23:06AM -0800, Michael Chan wrote:
> Hi Grant,
> 
> I think it is well documented that config cycles are non-posted in PCI,
> PCIX, and PCI Express specs as you pointed out. The only ambiguity is
> whether the mmconfig memory cycle from the CPU to the chipset is posted
> or not.

sorry - I was wrongly assuming mmconfig has to follow the same
semantics as config since it's intended as a replacement.

In short, the ECN answers Andi's question with "Yes" - thanks for
pointing it out.
For those who don't want to read the whole ECN, bits of it below.

>  The Implementation Note in the MMCONFIG ECN from pcisig (link
> below) allows the mmconfig write cycle to be posted, meaning mmconfig
> write cycle can complete before the real config write cycle completes.

Yes. I found it on page 5 of PciEx_ECN_MMCONFIG_040217.pdf.
AFAICT, this section only applies to "systems that implement a
processor-architecture-specific firmware interface standard".
e.g. ia64 SAL calls.

> That's why we needed confirmations from chipset engineers.

Well, Intel confirmed existing chipset comply with this bit of the ECN:
| For systems that are PC-compatible, or that do not implement a
| processor-architecture-specific firmware interface standard that
| allows access to the Configuration Space, the enhanced configuration
| access mechanism is required as defined in this section.
....
| The system hardware must provide a method for the system software
| to guarantee that a write transaction using the enhanced configuration
| access mechanism is completed by the completer before system software
| execution continues.


> http://www.pcisig.com/specifications/pciexpress/specifications/specifica
> tions

I assumed this one was meant:
http://www.pcisig.com/specifications/pciexpress/PciEx_ECN_MMCONFIG_040217.pdf

thanks,
grant
