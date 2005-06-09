Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVFIRdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVFIRdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVFIRdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:33:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6049 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261916AbVFIRdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:33:44 -0400
Date: Thu, 9 Jun 2005 18:34:33 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609173433.GE24611@parcelfarce.linux.theplanet.co.uk>
References: <42A8386F.2060100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8386F.2060100@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:39:11PM +0900, Hidetoshi Seto wrote:
> Reflecting every comments, I brushed up my patch for generic part.
> So today I'll post it again, and also post "ia64 part", which
> surely implements ia64-arch specific error checking. I think
> latter will be a sample of basic implement for other arch.

I think this is the wrong way to go about it.  For PCI Express, we
have a defined cross-architecture standard which tells us exactly how
all future PCIe devices will behave in the face of errors.  For PCI and
PCI-X, we have a lot of legacy systems, each of which implements error
checking and recovery in a somewhat eclectic way.

So, IMO, any implementation of PCI error recovery should start by
implementing the PCI Express AER mechanisms and then each architecture can
look at extending that scheme to fit their own legacy hardware systems.
That way we have a clean implementation for the future rather than being
tied to any one manufacturer or architecture's quirks.

Also, we can evaluate it based on looking at what the standard says,
rather than all trying to wrap our brains around the idiosyncracies of
a given platform ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
