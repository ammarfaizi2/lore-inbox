Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWHRQo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWHRQo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 12:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWHRQo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 12:44:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751298AbWHRQo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 12:44:26 -0400
Date: Fri, 18 Aug 2006 09:42:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrey Savochkin <saw@sw.ru>, Kirill Korotaev <dev@sw.ru>,
       Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Message-Id: <20060818094248.cdca152d.akpm@osdl.org>
In-Reply-To: <1155912348.9274.83.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	<44E33C3F.3010509@sw.ru>
	<1155752277.22595.70.camel@galaxy.corp.google.com>
	<1155755069.24077.392.camel@localhost.localdomain>
	<1155756170.22595.109.camel@galaxy.corp.google.com>
	<44E45D6A.8000003@sw.ru>
	<20060817084033.f199d4c7.akpm@osdl.org>
	<20060818120809.B11407@castle.nmd.msu.ru>
	<1155912348.9274.83.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 07:45:48 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > 
> > A) Have separate memory management for each container,
> >    with separate buddy allocator, lru lists, page replacement mechanism.
> >    That implies a considerable overhead, and the main challenge there
> >    is sharing of pages between these separate memory managers.
> 
> Hold on here for just a sec...
> 
> It is quite possible to do memory management aimed at one container
> while that container's memory still participates in the main VM.  
> 
> There is overhead here, as the LRU scanning mechanisms get less
> efficient, but I'd rather pay a penalty at LRU scanning time than divide
> up the VM, or coarsely start failing allocations.
> 

I have this mad idea that you can divide a 128GB machine up into 256 fake
NUMA nodes, then you use each "node" as a 512MB unit of memory allocation. 
So that 4.5GB job would be placed within an exclusive cpuset which has nine
"mems" (what are these called?) and voila: the job has a hard 4.5GB limit,
no kernel changes needed.

Unfortunately this is not testable because numa=fake=256 doesn't come even
vaguely close to working.  Am trying to get that fixed.
