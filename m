Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWHUCiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWHUCiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 22:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWHUCiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 22:38:15 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:5311 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751810AbWHUCiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 22:38:14 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Magnus Damm <magnus@valinux.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Christoph@sc8-sf-spam2-b.sourceforge.net,
       List <linux-kernel@vger.kernel.org>, Kirill Korotaev <dev@sw.ru>,
       Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux@sc8-sf-spam2-b.sourceforge.net, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Pavel Emelianov <xemul@openvz.org>, devel@openvz.org,
       Andi Kleen <ak@suse.de>
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
Date: Mon, 21 Aug 2006 11:38:40 +0900
Message-Id: <1156127920.21411.32.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
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
> Unfortunately this is not testable because numa=fake=256 doesn't come even
> vaguely close to working.  Am trying to get that fixed.

You may be looking for the NUMA emulation patches posted here:

http://marc.theaimsgroup.com/?l=linux-mm&m=112806587501884&w=2

There is a slightly updated x86_64 version here too:

http://marc.theaimsgroup.com/?l=linux-mm&m=113161386520342&w=2

/ magnus

