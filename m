Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264876AbSJOWWq>; Tue, 15 Oct 2002 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264952AbSJOWWf>; Tue, 15 Oct 2002 18:22:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:51432 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264880AbSJOWP3>;
	Tue, 15 Oct 2002 18:15:29 -0400
Message-ID: <3DAC94DE.BB6F4B4E@digeo.com>
Date: Tue, 15 Oct 2002 15:21:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Marcus Alanen <marcus@infa.abo.fi>, maalanen@ra.abo.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.5] __vmalloc allocates spurious page?
References: <Pine.LNX.4.44.0210152221080.14143-100000@tuxedo.abo.fi> <200210152158.AAA18031@infa.abo.fi> <20021015230506.D7702@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 22:21:18.0156 (UTC) FILETIME=[2EAAD0C0:01C27499]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Wed, Oct 16, 2002 at 12:58:12AM +0300, Marcus Alanen wrote:
> > >The unnecessary page is allocated only if size is initially a multiple
> > >of PAGE_SIZE, which sounds like a common case.
> >
> > Actually, size is already PAGE_ALIGNed, so we get the amount of pages
> > even easier.
> 
> IIRC, back in the dim and distant past, the extra page was originally to
> catch things running off the end of their space (eg, modules).  The
> idea was that modules (and other vmalloc'd areas) would be separated
> by one unmapped page.
> 
> It looks like this got broken recently though.

Still there I think.

struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
{
	...

        /*
         * We always allocate a guard page.
         */
        size += PAGE_SIZE;


Marcus's patch looks reasonable.
