Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVHEPz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVHEPz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVHEPxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:53:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15528 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262447AbVHEPxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:53:08 -0400
Date: Fri, 5 Aug 2005 17:53:07 +0200
From: Andi Kleen <ak@suse.de>
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, christoph@lameter.com,
       dwg@au1.ibm.com
Subject: Re: [RFC] Demand faulting for large pages
Message-ID: <20050805155307.GV8266@wotan.suse.de>
References: <1123255298.3121.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123255298.3121.46.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 10:21:38AM -0500, Adam Litke wrote:
> Below is a patch to implement demand faulting for huge pages.  The main
> motivation for changing from prefaulting to demand faulting is so that
> huge page allocations can follow the NUMA API.  Currently, huge pages
> are allocated round-robin from all NUMA nodes.   

I think matching DEFAULT is better than having a different default for
huge pages than for small pages.

In general more programs are happy with local memory than remote memory.

Also it makes it consistent.

> 
> The default behavior in SLES9 for i386 is to use demand faulting with
> NUMA policy-aware allocations.  To my knowledge, this continues to work

Not sure what you're trying to say here. All allocations are NUMA policy aware.

> well in practice.  Thanks to consolidated hugetlb code, switching the
> behavior requires changing only one fault handler.  The bulk of the
> patch just moves the logic from hugelb_prefault() to
> hugetlb_pte_fault().

Are you sure you fixed get_user_pages to handle this properly? It doesn't
like it.

-Andi
