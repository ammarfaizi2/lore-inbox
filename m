Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWHVSe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWHVSe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 14:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWHVSe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 14:34:27 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:61081 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750769AbWHVSe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 14:34:26 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Magnus Damm <magnus@valinux.co.jp>
Cc: rohitseth@google.com, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kirill Korotaev <dev@sw.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156219087.21411.89.camel@localhost>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <1156128426.21411.41.camel@localhost>
	 <1156209379.11127.15.camel@galaxy.corp.google.com>
	 <1156219087.21411.89.camel@localhost>
Content-Type: text/plain
Organization: IBM
Date: Tue, 22 Aug 2006 11:34:18 -0700
Message-Id: <1156271658.6479.89.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 12:58 +0900, Magnus Damm wrote:
> On Mon, 2006-08-21 at 18:16 -0700, Rohit Seth wrote:
> > On Mon, 2006-08-21 at 11:47 +0900, Magnus Damm wrote:
> > > On Fri, 2006-08-18 at 07:45 -0700, Dave Hansen wrote:
> > > > On Fri, 2006-08-18 at 12:08 +0400, Andrey Savochkin wrote:
> > > > > 
> > > > > A) Have separate memory management for each container,
> > > > >    with separate buddy allocator, lru lists, page replacement mechanism.
> > > > >    That implies a considerable overhead, and the main challenge there
> > > > >    is sharing of pages between these separate memory managers.
> > > > 
> > > > Hold on here for just a sec...
> > > > 
> > > > It is quite possible to do memory management aimed at one container
> > > > while that container's memory still participates in the main VM.  
> > > > 
> > > > There is overhead here, as the LRU scanning mechanisms get less
> > > > efficient, but I'd rather pay a penalty at LRU scanning time than divide
> > > > up the VM, or coarsely start failing allocations.
> > > 
> > > This could of course be solved with one LRU per container, which is how
> > > the CKRM memory controller implemented things about a year ago.
> > 
> > Effectively Andrew's idea of faking up nodes is also giving per
> > container LRUs.
> 
> Yes, but the NUMA emulation approach is using fixed size containers
> where the size is selectable at the kernel command line, while the CKRM
> (and pzone) approach provides a more dynamic (and complex) solution.

NUMA emulation does not allow guarantee, only limits. It also doesn't
allow over commit (ove commit issue is present in pzone based approach
also).

> 
> / magnus
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


