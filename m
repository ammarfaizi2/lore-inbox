Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWHRS1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWHRS1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWHRS1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:27:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:37793 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964914AbWHRS1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:27:39 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Linux@sc8-sf-spam2-b.sourceforge.net,
       ckrm-tech@lists.sourceforge.net, Dave Hansen <haveblue@us.ibm.com>,
       List <linux-kernel@vger.kernel.org>, Kirill Korotaev <dev@sw.ru>,
       Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, rohitseth@google.com, hugh@veritas.com,
       Christoph@sc8-sf-spam2-b.sourceforge.net, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1155925065.26155.17.camel@linuxchandra>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <20060818094248.cdca152d.akpm@osdl.org>
	 <1155925065.26155.17.camel@linuxchandra>
Content-Type: text/plain
Organization: IBM
Date: Fri, 18 Aug 2006 11:27:34 -0700
Message-Id: <1155925654.26155.22.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 11:17 -0700, Chandra Seetharaman wrote:
> On Fri, 2006-08-18 at 09:42 -0700, Andrew Morton wrote:
> > On Fri, 18 Aug 2006 07:45:48 -0700
> > Dave Hansen <haveblue@us.ibm.com> wrote:
> > 
> > > On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > > > 
> > > > A) Have separate memory management for each container,
> > > >    with separate buddy allocator, lru lists, page replacement mechanism.
> > > >    That implies a considerable overhead, and the main challenge there
> > > >    is sharing of pages between these separate memory managers.
> > > 
> > > Hold on here for just a sec...
> > > 
> > > It is quite possible to do memory management aimed at one container
> > > while that container's memory still participates in the main VM.  
> > > 
> > > There is overhead here, as the LRU scanning mechanisms get less
> > > efficient, but I'd rather pay a penalty at LRU scanning time than divide
> > > up the VM, or coarsely start failing allocations.
> > > 
> > 
> > I have this mad idea that you can divide a 128GB machine up into 256 fake
> > NUMA nodes, then you use each "node" as a 512MB unit of memory allocation. 
> > So that 4.5GB job would be placed within an exclusive cpuset which has nine
> > "mems" (what are these called?) and voila: the job has a hard 4.5GB limit,
> > no kernel changes needed.
> 
> In this model memory and container are tightly coupled, hence memory
> might be unused/wasted in one container/resource group", while a
> different group is hitting its limit too often.
> 
> In order to minimize this effect, resource controllers should be
> providing both minimum and maximum amount of resources available for a
> resource group.

Forgot to mention... There is a set of patches submitted by KUROSAWA
Takahiro that implements this by creating pseudo zones (It has the same
limitation though). http://marc.theaimsgroup.com/?l=ckrm-
tech&m=113867467006531&w=2

> 
> > 
> > Unfortunately this is not testable because numa=fake=256 doesn't come even
> > vaguely close to working.  Am trying to get that fixed.
> > 
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > _______________________________________________
> > ckrm-tech mailing list
> > https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


