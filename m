Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbUJXN3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUJXN3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUJXNWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:22:38 -0400
Received: from holomorphy.com ([207.189.100.168]:6355 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261476AbUJXNVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:21:41 -0400
Date: Sun, 24 Oct 2004 06:21:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: [PATCH] Fix incorrect kunmap_atomic in pktcdvd
Message-ID: <20041024132128.GQ17038@holomorphy.com>
References: <m3wtxhibo9.fsf@telia.com> <20041024032546.52314e23.akpm@osdl.org> <m3oeisz7uh.fsf@telia.com> <20041024041827.664845da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024041827.664845da.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>> Why was the interface made different from kmap()/kunmap() in the first
>> place? Wouldn't it have made more sense to let kunmap_atomic() take a
>> page pointer as the first parameter?

On Sun, Oct 24, 2004 at 04:18:27AM -0700, Andrew Morton wrote:
> No, kmap-atomic() maps a single page into the CPU's address space by making
> a pte point at the page.  To unmap that page we need to get at the pte, not
> at the page.  If kmap_atomic() were to take a pageframe address we'd need
> to search the whole fixmap space for the corresponding page - a reverse
> lookup.

I don't recall anything truly ancient, but fixmap indices should be
enough to recover the virtual address and pte. I think the virtual
address is primarily for checking purposes. The same kind of check
could be done by checking the pfn derived from the page structure
against the contents of the pte at the fixmap index, but I suspect
more damage would ensue from changing the calling convention than
aligning it with common expectations.


-- wli
