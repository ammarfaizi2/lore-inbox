Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUKMTqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUKMTqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKMTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:46:38 -0500
Received: from colo.lackof.org ([198.49.126.79]:7115 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261156AbUKMTqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:46:36 -0500
Date: Sat, 13 Nov 2004 12:46:34 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Andi Kleen <ak@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041113194634.GC3023@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2004 at 08:22:50AM -0800, Michael Chan wrote:
> > If I got the discussion so far correctly then the PCI-SGI spec does not
> > guarantee that there is no posting, but you know that the chipset
> > you are using right now doesn't do it.
> 
> Yes, that's my understanding of the spec. Grant Grundler does not agree
>  and thinks that non-posting is the only compliant implementation.

That's not what I said. I think we do agree. I'll rephrase.
The code currently in arch/i386 and arch/x86_64 support a chipset that
is compliant with the part of the spec that requires non-postable
config writes.

Other chipsets can implement postable config space. To be compliant
with the ECN, the architecture must define a method to guarantee
the posted writes have reached the target device. I think the
ECN we've been talking about assumes that method will be implemented
in firmware somehow and NOT as a direct access method in the OS.

> I wish he was right as it would be the easiest to deal with.
> We contacted Intel about the out-of-spec readl when writing to
> the PMCSR to change power state as they were the original author
> of the mmconfig code. Their solution was to remove the readl after
> confirming that mmconfig was non-posted on their chipsets.

That means someone has to introduce a new method to access
mmconfig if they implement postable writes.

hth,
grant
