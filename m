Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVCNSqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVCNSqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVCNSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:45:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:39652 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261681AbVCNSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:43:50 -0500
Date: Mon, 14 Mar 2005 10:42:59 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Prefaulting
Message-ID: <547140000.1110825779@flay>
In-Reply-To: <1110618637.6292.36.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com> <20050311172228.773cf03d.akpm@osdl.org> <1110618637.6292.36.camel@laptopd505.fenrus.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Saturday, March 12, 2005 10:10:36 +0100 Arjan van de Ven <arjan@infradead.org> wrote:

> 
>> > From a quick peek it seems that the patch makes negligible difference for a
>> kernel compilation when prefaulting 1-2 pages and slows the workload down
>> quite a lot when prefaulting up to 16 pages.
> 
> well the last time I saw prefaulting experiments (Ingo was involved
> iirc) the problem was that the hitrate for the prefaults was such that
> the costs for tearing down the extra redundant rmap chains was more
> expensive than taking the "extra" faults. It seems linux has pretty
> cheap faulting logic invalidating some of traditional OS assumptions... 

Yes - is pretty much exactly what I saw with this too, even if we only
prefaulted up to 4 pages that were already in the pagecache. The additional
cost in zap_pte_rage etc killed us, and it was wholly detrimental.

I think we need better locality in glibc, etc before this is of much use.
I had a debug patch somewhere to show how sparse the layout of ptes was,
I'll see if I can find it.

M.

