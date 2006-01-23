Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWAWJUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWAWJUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 04:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWAWJUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 04:20:18 -0500
Received: from mail.suse.de ([195.135.220.2]:32229 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751450AbWAWJUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 04:20:16 -0500
Date: Mon, 23 Jan 2006 10:20:03 +0100
From: Nick Piggin <npiggin@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] split_page function to split higher order pages?
Message-ID: <20060123092002.GA26399@wotan.suse.de>
References: <20060121124053.GA911@wotan.suse.de> <1137853024.23974.0.camel@laptopd505.fenrus.org> <20060123054927.GA9960@wotan.suse.de> <20060123084715.GA9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123084715.GA9241@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 09:47:15AM +0100, Heiko Carstens wrote:
> > > > Just wondering what people think of the idea of using a helper
> > > > function to split higher order pages instead of doing it manually?
> > > 
> > > Maybe it's worth documenting that this is for kernel (or even
> > > architecture) internal use only and that drivers really shouldn't be
> > > doing this..
> > 
> > I guess it doesn't seem like something drivers would need to use
> > (and none appear to do anything like it).
> 
> And I thought this could/should be used together with vm_insert_page() that
> drivers are supposed to use nowadays instead of remap_pfn_range().
> Why shouldn't drivers use this?
> 

Actually fs/ramfs/file-nommu.c does use this (but it need not because
!CONFIG_MMU page allocator already does something similar).

But largely, no in-tree drivers use the facility so I think it would
be good for the mm folk to consider the first use case if and when it
comes up. So I've added a comment in split_page to that effect.

Thanks,
Nick

