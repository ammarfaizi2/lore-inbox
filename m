Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263368AbVCKDBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbVCKDBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbVCKCsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:48:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:17367 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263335AbVCKCn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:43:59 -0500
Subject: Re: AGP bogosities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503101818.25033.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <200503101804.04371.jbarnes@engr.sgi.com>
	 <16944.65119.216720.79612@cargo.ozlabs.ibm.com>
	 <200503101818.25033.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 13:38:35 +1100
Message-Id: <1110508715.32524.317.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 18:18 -0800, Jesse Barnes wrote:
> On Thursday, March 10, 2005 6:11 pm, Paul Mackerras wrote:
> > What is the relationship in the PCI device tree between the video
> > cards and their bridges?  Is there for instance only one AGP bridge
> > per host bridge?
> 
> I *think* a TIO (numalink<->agp & numalink<->pci) has two AGP busses coming
> off of it...
> 
> > Interesting, could you post the output from lspci -v on that system?
> 
> flatearth:~ # lspci -v


 .../...

That one is even worse... from what I see in your lspci output, you have
no bridge with AGP capability at all, and the various AGP devices are
all siblings...

Are you sure there is any real AGP slot in there ?

I'm afraid we may have to do the card <-> bridge machine as a bridge
specific function. At least the bridge driver can "know" how the HW for
that specific bridge lays out the PCI view of the AGP slot.

Ben.


