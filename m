Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293198AbSBWU3U>; Sat, 23 Feb 2002 15:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293199AbSBWU3K>; Sat, 23 Feb 2002 15:29:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30226 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293198AbSBWU3D>;
	Sat, 23 Feb 2002 15:29:03 -0500
Message-ID: <3C77FB35.16844FE7@zip.com.au>
Date: Sat, 23 Feb 2002 12:27:33 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>,		<1014444810.1003.53.camel@phantasy> 		<3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au> <3C77F503.1060005@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> Andrew Morton wrote:
> 
> >Robert Love wrote:
> >
> >>...
> >>
> >>Question: if (from below) you are going to use atomic operations, why
> >>make it per-CPU at all?  Just have one counter and atomic_inc and
> >>atomic_read it.  You won't need a spin lock.
> >>
> >
> >Oh that works fine.   But then it's a global counter, so each time
> >a CPU marks a page dirty, the counter needs to be pulled out of
> >another CPU's cache.   Which is not a thing I *need* to do.
> >
> >As I said, it's a micro-issue.  But it's a requirement which
> >may pop up elsewhere.
> >
> >
> I can tell you that Irix has just such a global counter for the amount of
> delayed allocate pages - and it gets to be a major point of cache contention
> once you get to larger cpu counts. So avoiding that from the start would
> be good.

Ah, good info.  Thanks.  I'll fix it with a big "FIXME" comment for now,
fix it for real when Rusty's per-CPU infrastructure appears.

-
