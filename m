Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVBXL7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVBXL7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVBXL7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:59:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:59452 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262265AbVBXL70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:59:26 -0500
Date: Thu, 24 Feb 2005 11:58:42 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
In-Reply-To: <1109224777.5177.33.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au> 
    <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston> 
    <20050217230342.GA3115@wotan.suse.de> 
    <20050217153031.011f873f.davem@davemloft.net> 
    <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> 
    <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com> 
    <421B0163.3050802@yahoo.com.au> 
    <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com> 
    <421D1737.1050501@yahoo.com.au> 
    <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com> 
    <1109224777.5177.33.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005, Nick Piggin wrote:
> 
> pud_addr_end?

		next = pud_addr_end(addr, end);

Hmm, yes, I'll go with that, thanks (unless a better idea follows).

Something I do intend on top of what I sent before, is another set
of three macros, like

		if (pud_none_or_clear_bad(pud))
			continue;

to replace all the p??_none, p??_bad clauses: not to save space,
but just for clarity, those loops now seeming dominated by the
unlikeliest of cases.

Has anyone _ever_ seen a p??_ERROR message?  I'm inclined to just
put three functions into mm/memory.c to do the p??_ERROR and p??_clear,
but that way the __FILE__ and __LINE__ will always come out the same.
I think if it ever proves a problem, we'd just add in a dump_stack.

Hugh
