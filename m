Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVERXes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVERXes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVERXes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:34:48 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:44587 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S262404AbVERXe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:34:27 -0400
Date: Wed, 18 May 2005 18:34:25 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: problems with 2.6.12 and ioremap/iounmap
Message-ID: <20050518233425.GB8962@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20050518224353.GL2596@hygelac> <m1zmusyuyq.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmusyuyq.fsf@muc.de>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
User-Agent: Mutt/1.5.6+20040907i
X-OriginalArrivalTime: 18 May 2005 23:34:26.0677 (UTC) FILETIME=[21357A50:01C55C02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 01:29:01AM +0200, ak@muc.de wrote:
> > from looking at the implementation in 2.6.12-pre4, I'm not clear how
> 
> I suppose you mean rc4, not pre4?

yes, just confused.

> > is the intent that iounmap should call remove_vm_area rather than
> > unmap_vm_area (with additional changes to not unlink the vma itself)?
> > or that the guard page should be removed by unmap_ rather than
> > remove_?
> 
> There doesn't seem to be a clear rule, that is where the confusion
> comes from I guess. I would consider it cleaner to handle it in
> the higher level vmalloc code.

that certainly sounds reasonable. I'll try putting together a patch
that does this and send it to our end user to see if it fixes his
problem.

> > when debugging this issue, I also ran into problems with iounmap using
> > virt_to_page on a pci IO region. this problem went away when I tried
> > calling change_page_attr_addr with the virtual address instead. but
> 
> A patch for that already went into mainline.

ok, great.


> > perhaps iounmap should be calling ioremap_change_attr rather than
> 
> What is ioremap_change_attr? 

a static function in ioremap.c that is called by __ioremap. it's a
wrapper function around change_page_attr. I only see it in the x86_64
architecture, not i386.

Thanks,
Terence
