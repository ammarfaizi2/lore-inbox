Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbUKRMkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbUKRMkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUKRMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:40:31 -0500
Received: from holomorphy.com ([207.189.100.168]:13440 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262755AbUKRMjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:39:52 -0500
Date: Thu, 18 Nov 2004 04:39:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>,
       haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-ID: <20041118123921.GA2268@holomorphy.com>
References: <20041118021419.0c0d1dad.akpm@osdl.org> <E1CUjMz-0005DI-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUjMz-0005DI-00@mta1.cl.cam.ac.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk> wrote:
>> Just send 'em to linux-kernel first-up and cc everyone else.  That way you
>> avoid duplication of effort and everyone is on the same page.
>> I'm still struggling to understand the rationale behind the mem.c change
>> btw.  io_remap_page_range() _is_ remap_page_range() (or, now,
>> remap_pfn_range()) on x86.  So whatever the patch is supposed to be doing,
>> it's a no-op.

On Thu, Nov 18, 2004 at 10:18:28AM +0000, Keir Fraser wrote:
> We need to sync up to the current BK tree and see what needs to be
> done. If remap_pfn_range() is arch-dep and only used in contexts where
> you want to remap real physical address ranges (not "kernel physical"
> address ranges) then we can reimplement remap_pfn_range() and remove
> that CONFIG_XEN part of mem.c.

It is not so. It uses pfn_to_page() etc. which means it must be aligned
with kernel physical addresses. Xen's requirement is highly unusual. It
may unfortunately merit another #ifdef in drivers/char/mem.c, as using
io_remap_page_range() without such will break some architecture.


-- wli
