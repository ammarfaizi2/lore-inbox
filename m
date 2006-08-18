Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWHRU0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWHRU0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 16:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWHRU0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 16:26:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:37512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932521AbWHRU0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 16:26:24 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E33C8A.6030705@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 13:26:19 -0700
Message-Id: <1155932779.26155.87.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kirill,

IMO, a UBC with resource constraint(limit in this case) should behave no
different than a kernel with limited memory. i.e it should do
reclamation before it starts failing allocation requests. It could even
do it preemptively.

There is no guarantee support which is required for providing QoS.

Each controller modifying the infrastructure code doesn't look good. We
can have proper interfaces to add a new resource controller.
 
chandra
On Wed, 2006-08-16 at 19:40 +0400, Kirill Korotaev wrote:
> Introduce UB_KMEMSIZE resource which accounts kernel
> objects allocated by task's request.
> 
> Reference to UB is kept on struct page or slab object.
> For slabs each struct slab contains a set of pointers
> corresponding objects are charged to.
> 
> Allocation charge rules:
>  define1. Pages - if allocation is performed with __GFP_UBC flag - page
>     is charged to current's exec_ub.
>  2. Slabs - kmem_cache may be created with SLAB_UBC flag - in this
>     case each allocation is charged. Caches used by kmalloc are
>     created with SLAB_UBC | SLAB_UBC_NOCHARGE flags. In this case
>     only __GFP_UBC allocations are charged.
> 
> Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@sw.ru>
> 
<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


