Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVCQAuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVCQAuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVCQAsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:48:54 -0500
Received: from ozlabs.org ([203.10.76.45]:17375 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262925AbVCQAhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:37:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16952.53719.150647.638710@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 11:39:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: Rik van Riel <riel@redhat.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
	<16952.41973.751326.592933@cargo.ozlabs.ibm.com>
	<200503161406.01788.jbarnes@engr.sgi.com>
	<Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:

> Thing is, the rest of the kernel uses virt_to_phys for
> two different things.  Only one of them has to do with
> the real physical address, the other is about getting
> the page frame number.

So fix the places that are using virt_to_phys to get the page frame
number to use virt_to_pfn instead. :)

> On native x86, x86-64 and others, the page frame number
> and physical address are directly related to each other.
> Under Xen, however, the two are different - and the
> AGPGART really needs to have the physical address ;)

If Xen is letting the kernel program the GART, you just lost any
memory isolation between partitions you might have been trying to
enforce. :)

Paul.
