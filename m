Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVCPWJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVCPWJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCPWJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:09:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15502 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261529AbVCPWIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:08:37 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
Date: Wed, 16 Mar 2005 14:06:01 -0800
User-Agent: KMail/1.7.2
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, riel@redhat.com, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
In-Reply-To: <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503161406.01788.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 16, 2005 1:24 pm, Paul Mackerras wrote:
> Keir Fraser writes:
> > This patch cleans up AGP driver treatment of bus/device memory. Every
> > use of virt_to_phys/phys_to_virt should properly be converting between
> > virtual and bus addresses: this distinction really matters for the Xen
> > hypervisor.
>
> I think you are misunderstanding the distinction between physical
> addresses and bus addresses.  Specifically, it seems wrong to me to be
> putting bus addresses into the GATT rather than physical addresses.
>
> For example, on my G5, physical addresses are 36 bits (in the
> hardware) but bus addresses are only 32 bits.  Using bus addresses in
> the GATT would mean that I couldn't put any memory above the 4GB point
> into the GATT.
>
> The distinction is that physical addresses are what are used to access
> physical memory, whereas bus addresses are what appears on some
> external bus (usually PCI).  The GATT sits between an external (AGP)
> bus and memory, so while the GATT is indexed using bus addresses, its
> entries contain physical addresses.  So in fact virt_to_phys is the
> correct thing to use to calculate values to put in GATT entries.

Thanks for the explanation Paul, now the code actually makes sense.  
Converting to the DMA mapping API doesn't make sense at all in this context 
then, since we're basically programming the GATT (an IOMMU type table) with 
physical addresses.  Ken, are you sure you need to make these changes at all?  
Does Xen break w/o them?

Jesse
