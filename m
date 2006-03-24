Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWCXMTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWCXMTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWCXMTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:19:08 -0500
Received: from ns1.suse.de ([195.135.220.2]:61606 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422707AbWCXMTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:19:07 -0500
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the e820 table
References: <1143138170.3147.43.camel@laptopd505.fenrus.org>
	<200603231856.12227.ak@suse.de>
	<1143140539.3147.44.camel@laptopd505.fenrus.org>
	<1143141320.3147.47.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 24 Mar 2006 13:19:02 +0100
In-Reply-To: <1143141320.3147.47.camel@laptopd505.fenrus.org>
Message-ID: <p73k6ak593d.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> On Thu, 2006-03-23 at 20:02 +0100, Arjan van de Ven wrote:
> > > That is e820_mapped(address, address+size, E820_RESERVED)
> > > 
> > > And not having a size is definitely wrong on i386 too.
> > 
> > s/wrong/not selective enough/
> > 
> > and e820_mapped doesn't check this either anyway, at least not the way
> > you imply it does.
> > 
> > I'll do a new patch using this for x86_64 though, no need to make a
> > second function like this.
> 
> 
> There have been several machines that don't have a working MMCONFIG,
> often because of a buggy MCFG table in the ACPI bios. This patch adds a
> simple sanity check that detects a whole bunch of these cases, and when
> it detects it, linux now boots rather than crash-and-burns. The accuracy
> of this detection can in principle be improved if there was a "is this
> entire range in e820 with THIS attribute", but no such function exist
> and the complexity needed for this is not really worth it; this simple
> check already catches most cases anyway.

I added the patch to my patchkit now. I also have an older patch (needs a bit
more cleanup) that checks for all busses if they are reachable using MCFG
Still needs some more work and interaction check with PCI hotplug though.


-Andi

