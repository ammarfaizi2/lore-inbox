Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWHURfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWHURfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 13:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWHURfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 13:35:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:9665 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964990AbWHURfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 13:35:23 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1155955116.2510.445.camel@stark>
References: <44E33893.6020700@sw.ru>  <44E33BB6.3050504@sw.ru>
	 <1155866328.2510.247.camel@stark>  <44E5A637.1020407@sw.ru>
	 <1155955116.2510.445.camel@stark>
Content-Type: text/plain
Organization: IBM
Date: Mon, 21 Aug 2006 10:35:16 -0700
Message-Id: <1156181716.6479.2.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 19:38 -0700, Matt Helsley wrote:

<snip>

> > > 
> > >>+	for (p = ub; p != NULL; p = p->parent) {
> > > 
> > > 
> > > Seems rather expensive to walk up the tree for every charge. Especially
> > > if the administrator wants a fine degree of resource control and makes a
> > > tall tree. This would be a problem especially when it comes to resources
> > > that require frequent and fast allocation.
> > in heirarchical accounting you always have to update all the nodes :/
> > with flat UBC this doesn't introduce significant overhead.
> 
> Except that you eventually have to lock ub0. Seems that the cache line
> for that spinlock could bounce quite a bit in such a hot path.
> 
> Chandra, doesn't Resource Groups avoid walking more than 1 level up the
> hierarchy in the "charge" paths?

Yes, charging happens at one level only (except the case where the group
is over its guarantee, it has to borrow from its parent, it will go up).

<snip>
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


