Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbSLNFRB>; Sat, 14 Dec 2002 00:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbSLNFRB>; Sat, 14 Dec 2002 00:17:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:59571 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267197AbSLNFRA>;
	Sat, 14 Dec 2002 00:17:00 -0500
Message-ID: <3DFAC09A.C5642879@digeo.com>
Date: Fri, 13 Dec 2002 21:24:42 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jason Howard <lists@spectsoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA from SCSI controller to PCI frame buffer memory.
References: <1039806910.21196.29.camel@bmagic.spectsoft.com> <1039837312.25121.115.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 05:24:43.0446 (UTC) FILETIME=[1BC5AD60:01C2A331]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-12-13 at 19:15, Jason Howard wrote:
> > Hello All,
> >
> > I am wondering if the functionality exists in the Linux kernel to DMA
> > from a SCSI controller directly into frame buffer memory of a PCI video
> > card?  Is there a standard method for this (similar to sendfile) or will
> > it require some hacking?
> 
> In theory you can mmap the frame buffer memory, then do O_DIRECT I/O
> into it. In practice it will buffer (I hope it still does).

An O_DIRECT disk read into a mmapped device region will fail (if
it doesn't, it'll oops ;)).  O_DIRECT requires valid pages inside
mem_map[].

See the `vma->vm_flags & VM_IO' test in get_user_pages(), and
the VALID_PAGE() test in get_page_map().

Hacking is required to do this.
