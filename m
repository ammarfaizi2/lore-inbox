Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTECOCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTECOCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:02:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49983 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263319AbTECOCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:02:48 -0400
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	<20030502153525.GA11939@krispykreme>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 May 2003 08:12:11 -0600
In-Reply-To: <20030502153525.GA11939@krispykreme>
Message-ID: <m1el3gce6c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:

> Hi,
> 
> > . Included the `kexec' patch - load Linux from Linux.  Various people want
> >   this for various reasons.  I like the idea of going from a login prompt to
> >   "Calibrating delay loop" in 0.5 seconds.
> 
> One thing that bothers me about kexec is how we grab low pages in
> kimage_alloc_page(). On a partitioned ppc64 box I will need to grab
> memory in the low 256MB and the machine might have 500GB of memory
> free. Thats going to take some time :)

Could you explain to me the need to allocate memory in the low 256MB.
Generally the design is that you can allocate the memory anywhere
and then relocate_kernel.S will move where it needs to be kept.

I have had people wanting to use 300MB initial ramdisks and the like.  
If you have 500GB of memory what is the point of keeping anything on a disk?

When you have 4TB on a cluster or a NUMA machine I can understand
wanting to keep things local to a node.  But in those cases you want
to have local node zones so the problem does not come up.

In general I hate restricting the memory you can use, because kexec is
not just about booting linux.  But it is about booting anything that
we reasonably can.  The only case I have seen so far that makes sense
is when your physical memory is larger than your virtual memory.

> Id hate to introduce a separate zone just for this sort of stuff (we
> currently throw all memory in the DMA zone). Could we add a hint to
> the page allocator where it makes a best effort to grab memory below
> a threshold?

I suspect so.  And I can't imagine it would be that hard to implement.

But I think I would like to see why you need that.

Eric
