Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVCPX40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVCPX40 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVCPX4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:56:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54166 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262885AbVCPXz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:29 -0500
Date: Wed, 16 Mar 2005 18:55:13 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Paul Mackerras <paulus@samba.org>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kurt@garloff.de,
       Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <200503161406.01788.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
 <200503161406.01788.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005, Jesse Barnes wrote:

> Thanks for the explanation Paul, now the code actually makes sense.  
> Converting to the DMA mapping API doesn't make sense at all in this context 
> then, since we're basically programming the GATT (an IOMMU type table) with 
> physical addresses.  Ken, are you sure you need to make these changes at all?  
> Does Xen break w/o them?

Thing is, the rest of the kernel uses virt_to_phys for
two different things.  Only one of them has to do with
the real physical address, the other is about getting
the page frame number.

On native x86, x86-64 and others, the page frame number
and physical address are directly related to each other.
Under Xen, however, the two are different - and the
AGPGART really needs to have the physical address ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
