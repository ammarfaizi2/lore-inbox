Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275324AbRIZQvS>; Wed, 26 Sep 2001 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275323AbRIZQvI>; Wed, 26 Sep 2001 12:51:08 -0400
Received: from zok.sgi.com ([204.94.215.101]:7862 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275319AbRIZQvD>;
	Wed, 26 Sep 2001 12:51:03 -0400
Message-ID: <00ad01c146ab$9d4b6340$6501a8c0@pchawkes>
From: "John Hawkes" <hawkes@sgi.com>
To: "Andrew Morton" <akpm@zip.com.au>, <dipankar@in.ibm.com>
Cc: <davem@redhat.com>, <marcelo@connectiva.com.br>, <riel@connectiva.com.br>,
        "Andrea Arcangeli" <andrea@suse.de>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <hawkes@engr.sgi.com>
In-Reply-To: <20010926103424.A8893@in.ibm.com> <3BB16834.4393EEA3@zip.com.au>
Subject: Re: Locking comment on shrink_caches()
Date: Wed, 26 Sep 2001 09:52:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew Morton" <akpm@zip.com.au>
> > John Hawkes from SGI had published some AIM7 numbers that showed
> > pagecache_lock to be a bottleneck above 4 processors. At 32
processors,
> > half the CPU cycles were spent on waiting for pagecache_lock. The
> > thread is at -
> >
> > http://marc.theaimsgroup.com/?l=lse-tech&m=98459051027582&w=2
> >
>
> That's NUMA hardware.   The per-hashqueue locking change made
> a big improvement on that hardware.  But when it was used on
> Intel hardware it made no measurable difference at all.

More specifically, that was on SGI Origin2000 32p mips64 ccNUMA
hardware.  The pagecache_lock bottleneck is substantially less on SGI
Itanium ccNUMA hardware running those AIM7 workloads.  I'm seeing
moderately significant contention on the Big Kernel Lock, mostly from
sys_lseek() and ext2_get_block().

John Hawkes
hawkes@sgi.com


