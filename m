Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCREXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCREXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVCREXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:23:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261327AbVCREX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:23:28 -0500
Date: Thu, 17 Mar 2005 23:23:10 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Paul Mackerras <paulus@samba.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ian.Pratt@cl.cam.ac.uk, kurt@garloff.de, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <16954.7656.838769.483631@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.61.0503172321001.8711@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
 <200503161406.01788.jbarnes@engr.sgi.com> <29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
 <16953.20279.77584.501222@cargo.ozlabs.ibm.com> <1111067594.1213.27.camel@localhost.localdomain>
 <16954.7656.838769.483631@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005, Paul Mackerras wrote:

> However, the idea of having phys_to_agp/agp_to_phys (or 
> virt_to_agp/agp_to_virt) sounds like it wouldn't be too much effort, if 
> it would help Xen.

It would be absolutely trivial.  On most architectures you would have:

#define virt_to_agp  virt_to_phys
#define agp_to_virt  phys_to_virt

On Xen you would have:

#define virt_to_agp  virt_to_bus
#define agp_to_virt  bus_to_virt

Or, more likely, defined to arbitrary_machine_to_phys
or whatever it was called ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
