Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287766AbSAFIUz>; Sun, 6 Jan 2002 03:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287768AbSAFIUp>; Sun, 6 Jan 2002 03:20:45 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:35287 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287766AbSAFIUf>; Sun, 6 Jan 2002 03:20:35 -0500
Date: Sun, 6 Jan 2002 03:20:30 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Gerrit Huizenga <gerrit@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020106032030.A27926@redhat.com>
In-Reply-To: <E16LTvs-00016I-00@the-village.bc.nu> <E16Lslt-0001aG-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Lslt-0001aG-00@w-gerrit2>; from gerrit@us.ibm.com on Wed, Jan 02, 2002 at 01:17:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 01:17:59PM -0800, Gerrit Huizenga wrote:
> I don't know if there are real examples of large memory systems
> exhausting the ~1 GB of kernel virtual address space on machines
> with > 12-32 GB of physical memory (we had this problem in PTX which
> created the need for a larger kernel virtual address space in some
> contexts).

The ~800MB or so of kernel address space is exhausted with struct page 
entries around 48GB of physical memory or so

SGI's original highmem patch switched page tables on entry to kernel 
space, so there is code already tested that we can borrow.  But I'm 
not sure if it's worth it as the overhead it adds makes life really 
suck: we would lose the ability to use global pages, as well as always 
encounter tlb misses on the kernel<->userspace transition.  PAE shows 
up as a 5% performance loss on normal loads, and this would make it 
worse.  We're probably better off implementing PSE.  Of course, making 
these kinds of choices is hard without actual statistics of the 
usage patterns we're targetting.

> Would be nice to have a config option like "CONFIG_PCI_36" to imply
> that all devices on a PAE system were able to access all of memory,
> globally removing the need for bounce buffering and allowing a native
> PCI setup for mapping memory addresses...

That would be neat.

		-ben
-- 
Fish.
