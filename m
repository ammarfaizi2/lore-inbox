Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWHVD5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWHVD5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 23:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWHVD5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 23:57:54 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:7837 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751156AbWHVD5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 23:57:53 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Magnus Damm <magnus@valinux.co.jp>
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kirill Korotaev <dev@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156209379.11127.15.camel@galaxy.corp.google.com>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
	 <1155752277.22595.70.camel@galaxy.corp.google.com>
	 <1155755069.24077.392.camel@localhost.localdomain>
	 <1155756170.22595.109.camel@galaxy.corp.google.com>
	 <44E45D6A.8000003@sw.ru> <20060817084033.f199d4c7.akpm@osdl.org>
	 <20060818120809.B11407@castle.nmd.msu.ru>
	 <1155912348.9274.83.camel@localhost.localdomain>
	 <1156128426.21411.41.camel@localhost>
	 <1156209379.11127.15.camel@galaxy.corp.google.com>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 12:58:07 +0900
Message-Id: <1156219087.21411.89.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 18:16 -0700, Rohit Seth wrote:
> On Mon, 2006-08-21 at 11:47 +0900, Magnus Damm wrote:
> > On Fri, 2006-08-18 at 07:45 -0700, Dave Hansen wrote:
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
> > 
> > This could of course be solved with one LRU per container, which is how
> > the CKRM memory controller implemented things about a year ago.
> 
> Effectively Andrew's idea of faking up nodes is also giving per
> container LRUs.

Yes, but the NUMA emulation approach is using fixed size containers
where the size is selectable at the kernel command line, while the CKRM
(and pzone) approach provides a more dynamic (and complex) solution.

/ magnus

