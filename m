Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263341AbTC0Rqq>; Thu, 27 Mar 2003 12:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263347AbTC0Rqp>; Thu, 27 Mar 2003 12:46:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23134 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263341AbTC0Rqo>; Thu, 27 Mar 2003 12:46:44 -0500
Date: Thu, 27 Mar 2003 17:59:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wonderffffffffull ac filemap patch
In-Reply-To: <1048787156.3229.20.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303271750220.2542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2003, Alan Cox wrote:
> On Thu, 2003-03-27 at 17:33, Hugh Dickins wrote:
> > Here's a patch I've stolen from 2.4-ac, which is clearly correct so
> > far as it goes.  I keep wanting to get this integrated into 2.4 and
> > 2.5, then bring shmem.c into line (in 2.5 use generic_write_checks).
> > 
> > But each time I approach it, I get stuck on trying to understand the
> > code it's a good patch to.  I understand that there's a problem with
> > loff_t twice as wide as rlim, and that we need to trim count down near
> > the limit.  But I don't understand why 0xFFFFFFFFULL and (u32) rather
> > than RLIM_INFINITY and (unsigned long): are we really trying to
> > cripple 64-bit arches here?
> 
> For 2.4 I just wanted to handle what we had and fix up the spec violations.
> For 2.5.x rlimit64 is calling 8)

Fixing up a silly in what's there, that I understand; and adding rlimit64,
that too.  But on 64-bit arches, isn't rlimit already rlimit64?

If the answer to that is Yes, then doesn't the 0xFFFFFFFFULL test cripple
them?  If the answer to that is No, then how come we're trying to handle
a case in which limit has more than 32 bits?

Hugh

