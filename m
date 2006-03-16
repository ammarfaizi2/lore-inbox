Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752412AbWCPQqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbWCPQqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbWCPQqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:46:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37591 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751263AbWCPQqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:46:14 -0500
Date: Thu, 16 Mar 2006 08:46:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, bos@pathscale.com, Hugh@veritas.com,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <ada4q1yu9ze.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0603160841330.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
 <20060315221716.19a92762.akpm@osdl.org> <ada4q1yu9ze.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2006, Roland Dreier wrote:
>
>     Andrew> vm_insert_page() mucks around with rmap-named functions
>     Andrew> which don't actually do rmap and sports
>     Andrew> apparently-incorrect comments wrt PageReserved().  I don't
>     Andrew> know how well-cared-for it is...
> 
> Linus just added vm_insert_page() a few months ago.  Has it already bit-rotted?

Heh. We relaxed the "needs PG_reserved" requirement, but there's a comment 
that still says that it needs to in the internal function, which used to 
be shared between remap_pfn_range and vm_insert_page.

And it uses page_add_file_rmap(), which is misnamed (but that has nothing 
to do with vm_insert_page). 

page_add_file_rmap() doesn't actually do any rmap stuff, it's required for 
_any_ page that is mapped, and in particular pages that are _not_ rmapped. 
So vm_insert_page() is doing the right thing, but it looks a bit scary due 
to bad naming else-where.

		Linus
