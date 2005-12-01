Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVLARJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVLARJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVLARJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:09:17 -0500
Received: from hera.kernel.org ([140.211.167.34]:27883 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932340AbVLARJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:09:16 -0500
Date: Thu, 1 Dec 2005 15:08:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
Message-ID: <20051201170850.GA16235@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet> <1133452790.27824.117.camel@localhost.localdomain> <1133453411.2853.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133453411.2853.67.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:10:11PM +0100, Arjan van de Ven wrote:
> > Out of "Cached" value - to get details like
> > 
> > 	<mmap> - xxx KB
> > 	<shared mem> - xxx KB
> > 	<text, data, bss, malloc, heap, stacks> - xxx KB
> > 	<filecache pages total> -- xxx KB
> > 		(filename1 or <dev>, <ino>) -- #of pages
> > 		(filename2 or <dev>, <ino>) -- #of pages
> > 		
> > This would be really powerful on understanding system better.
> 
> to some extend it might be useful.
> I have a few concerns though
> 1) If we make these stats into an ABI then it becomes harder to change
> the architecture of the VM radically since such concepts may not even
> exist in the new architecture. As long as this is some sort of advisory,
> humans-only file I think this isn't too much of a big deal though. 
> 
> 2) not all the concepts you mention really exist as far as the kernel is
> concerned. I mean.. a mmap file is file cache is .. etc.
> malloc/heap/stacks are also not differentiated too much and are mostly
> userspace policy (especially thread stacks). 
> 
> A split in
> * non-file backed
>   - mapped once
>   - mapped more than once
> * file backed
>   - mapped at least once
>   - not mapped
> I can see as being meaningful. Assigning meaning to it beyond this is
> dangerous; that is more an interpretation of the policy userspace
> happens to use for things and I think coding that into the kernel is a
> mistake.
> 
> Knowing which files are in memory how much is, as debug feature,
> potentially quite useful for VM hackers to see how well the various VM
> algorithms work. I'm concerned about the performance impact (eg you can
> do it only once a day or so, not every 10 seconds) and about how to get
> this data out in a consistent way (after all, spewing this amount of
> debug info will in itself impact the vm balances)

Most of the issues you mention are null if you move the stats
maintenance burden to userspace. 

The performance impact is also minimized since the hooks 
(read: overhead) can be loaded on-demand as needed.
