Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWHRSAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHRSAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHRSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:00:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:1271 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751449AbWHRSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:00:40 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=o694lq2V+3prXdIZANp6dIYVwqfXdgIdUXDgMlsh0+0gGnPHd+Px2Rqpvzj8u5npM
	Lnl9q4/vGuhG/oDFG0pJg==
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrey Savochkin <saw@sw.ru>,
       Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <20060818094248.cdca152d.akpm@osdl.org>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <20060818094248.cdca152d.akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 18 Aug 2006 10:59:06 -0700
Message-Id: <1155923946.23242.21.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 09:42 -0700, Andrew Morton wrote:
> On Fri, 18 Aug 2006 07:45:48 -0700
> Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > > 
> > > A) Have separate memory management for each container,
> > >    with separate buddy allocator, lru lists, page replacement mechanism.
> > >    That implies a considerable overhead, and the main challenge there
> > >    is sharing of pages between these separate memory managers.
> > 
> > Hold on here for just a sec...
> > 
> > It is quite possible to do memory management aimed at one container
> > while that container's memory still participates in the main VM.  
> > 
> > There is overhead here, as the LRU scanning mechanisms get less
> > efficient, but I'd rather pay a penalty at LRU scanning time than divide
> > up the VM, or coarsely start failing allocations.
> > 
> 
> I have this mad idea that you can divide a 128GB machine up into 256 fake
> NUMA nodes, then you use each "node" as a 512MB unit of memory allocation. 
> So that 4.5GB job would be placed within an exclusive cpuset which has nine
> "mems" (what are these called?) and voila: the job has a hard 4.5GB limit,
> no kernel changes needed.
> 
Sounds like an interesting idea.  Will have to depend on something like
memory hot-plug to get the things move around...

-rohit

> Unfortunately this is not testable because numa=fake=256 doesn't come even
> vaguely close to working.  Am trying to get that fixed.

