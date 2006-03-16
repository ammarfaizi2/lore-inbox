Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWCPRkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWCPRkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWCPRkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:40:39 -0500
Received: from mx.pathscale.com ([64.160.42.68]:29126 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752441AbWCPRki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:40:38 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:40:32 -0800
Message-Id: <1142530832.25297.140.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:23 +0000, Hugh Dickins wrote:

> You're safe to drop the VM_SHM everywhere.  But your backport driver will
> have to be using PageReserved still, not relying on __GFP_COMP: although
> __GFP_COMP was defined in 2.6.9 and a few earlier, it used to take effect
> only when #ifdef CONFIG_HUGETLB_PAGE - only in 2.6.15 did we make it
> available to all configurations.  You'll have irritating accounting
> differences between the two drivers: it used to be the case that put_page
> on a PageReserved page did nothing, so you had to avoid get_page on it to
> get the page accounting right; we straightened that out in 2.6.15.

OK, that's very helpful to know, thanks.

> So, if your driver allows userspace to pin an otherwise unlimited
> number of user pages for an indefinite length of time, you ought
> to follow uverbs_mem.c's locked_vm accounting.

This is exactly the case, and we are in fact aping uverbs_mem.c quite
carefully :-)

> And I'll have confused you by mentioning that under VM_LOCKED:
> I was thinking uverbs_mem.c set VM_LOCKED, but it does not, nor
> should it.

OK, thanks.

	<b

