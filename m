Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbULHWvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbULHWvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbULHWvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:51:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39911 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261394AbULHWvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:51:02 -0500
Date: Wed, 08 Dec 2004 14:50:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Lameter <clameter@sgi.com>, nickpiggin@yahoo.com.au
cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, hugh@veritas.com,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Anticipatory prefaulting in the page fault handler V1
Message-ID: <156610000.1102546207@flay>
In-Reply-To: <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain><Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org><Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com><Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org><Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com><Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com><20041201223441.3820fbc0.akpm@osdl.org> <41AEBAB9.3050705@pobox.com><20041201230217.1d2071a8.akpm@osdl.org> <179540000.1101972418@[10.10.2.4]><41AEC4D7.4060507@pobox.com> <20041202101029.7fe8b303.cliffw@osdl.org> <Pine.LNX.4.58.0412080920240.27156@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The page fault handler for anonymous pages can generate significant overhead
> apart from its essential function which is to clear and setup a new page
> table entry for a never accessed memory location. This overhead increases
> significantly in an SMP environment.
> 
> In the page table scalability patches, we addressed the issue by changing
> the locking scheme so that multiple fault handlers are able to be processed
> concurrently on multiple cpus. This patch attempts to aggregate multiple
> page faults into a single one. It does that by noting
> anonymous page faults generated in sequence by an application.
> 
> If a fault occurred for page x and is then followed by page x+1 then it may
> be reasonable to expect another page fault at x+2 in the future. If page
> table entries for x+1 and x+2 would be prepared in the fault handling for
> page x+1 then the overhead of taking a fault for x+2 is avoided. However
> page x+2 may never be used and thus we may have increased the rss
> of an application unnecessarily. The swapper will take care of removing
> that page if memory should get tight.

I tried benchmarking it ... but processes just segfault all the time. 
Any chance you could try it out on SMP ia32 system?

M.

