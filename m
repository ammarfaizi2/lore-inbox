Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWHXBXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWHXBXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965325AbWHXBXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:23:19 -0400
Received: from smtp-out.google.com ([216.239.45.12]:64567 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965326AbWHXBXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:23:18 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=cdVdncWsWGHk7zqPmR7swt5bzu/6uc3KggCQuuFbsJYhZzMvYdC/G+DUyqpw6TCuJ
	NnjXTMqAXhwjupDgxqA7Q==
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Magnus Damm <magnus@valinux.co.jp>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kirill Korotaev <dev@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
Organization: Google Inc
Date: Wed, 23 Aug 2006 18:20:35 -0700
Message-Id: <1156382435.8324.31.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
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
> where the size is selectable at the kernel command line, 
[Apologies for late reply..]

Yup, if we run with fake NUMA support for providing container
functionality then dynamic resizing will be important (and that is why I
made the initial comment of possibly using memory hot-plug)

> while the CKRM
> (and pzone) approach provides a more dynamic (and complex) solution.


...this complexity is not always a positive thing ;-)  (I do like core
of CKRM stuff FWIW).

-rohit

