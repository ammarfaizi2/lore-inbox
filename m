Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbUBECEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUBECEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:04:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:35254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265059AbUBECEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:04:47 -0500
Date: Wed, 4 Feb 2004 18:04:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Mannthey <kmannth@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
 <60330000.1075939958@flay> <64260000.1075941399@flay>
 <Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org>
  <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
 <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Keith Mannthey wrote:
> 
> Martin sent me a patch that fixed the X panics (NUMA and DISCONTIG
> enabled).  (Thanks Martin!) I don't have the same X panics and issues I
> had before. I don't know if this will work for the generic case. It
> compiles with a simple memory situation just fine but I didn't boot it. 

Looks ok, but the thing should be made a function (possibly inline, 
depending on how big the code generated ends up being). As it is, it now 
uses its arguments several times, and while I don't see anything where 
that could screw up, it's just a tad scary.

Also, related to this whole mess, what the _heck_ is this in mm/rmap.c:

        if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
                return pte_chain;

that "pfn_valid(page_to_pfn(page))" just looks totally nonsensical. Can
somebody really pass in random page pointers to this thing, and if so, are
they guaranteed to be "not-random enough" to not cause bogus behaviour
when the "page_to_pfn()" happens to be valid..

If VM_IO gets rid of this, then we should immediately apply the patch.

			Linus
