Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVKCPKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVKCPKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKCPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:10:23 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:48199 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1030266AbVKCPKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:10:21 -0500
Date: Thu, 3 Nov 2005 17:09:39 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051103150939.GF22185@minantech.com>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com> <20051103143713.GB31134@mellanox.co.il> <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511031447080.23441@goblin.wat.veritas.com>
X-OriginalArrivalTime: 03 Nov 2005 15:10:19.0940 (UTC) FILETIME=[B48F6E40:01C5E088]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 02:59:44PM +0000, Hugh Dickins wrote:
> > By the way, as a separate issue, we still have a problem with DMA to pages
> > which are *needed* by the child process. What do you think about VM_COPY
> > (to do the old unix thing of actually copying the page instead of
> > setting the COW flag) and a matching madvise call to set/clear it?
> 
> I don't much want to add another path into copy_pte_range, actually
> copying pages.  If the process really wants DMA into such areas,
> then it should contain the code for the child to COW them itself?
> 
I think MPI is the main consumer of Infiniband currently. Unfortunately
it's only a library and can't control what users do before or after
fork in their applications. It is good to have possibility to copy partially 
registered pages, there shouldn't be many after all.

--
			Gleb.
