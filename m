Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUG1MjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUG1MjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUG1MjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:39:23 -0400
Received: from main.gmane.org ([80.91.224.249]:17053 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266896AbUG1MjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:39:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Wed, 28 Jul 2004 08:38:59 -0400
Message-ID: <87k6wocnmk.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
 <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
 <4106013E.30408@namesys.com> <87vfg9nyqv.fsf@osu.edu>
 <410698FA.40400@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:Fo2XpDAbdoXrvGv+wZuj+7k2u3U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> fsync performance gives you different performance.  Better to write
> more stuff to flush the cache.

I'm trying to understand how that would work.  Let's take an example
of a 64GB file that I'm writing out from scratch.  I start a timer
before writing.  With my fsync() way of testing, I expect to stop the
timer the moment last byte has been written and fsync() has been
called.

I gather you're saying that continuing writing past the 64GB mark,
causing LRU expiration of the last bytes of the 64GB bytes from write
buffers is a more fair way to test, versus just calling fsync() once
at the end.  I'm happy to write my benchmarks this way too, except I
need to know two configuration values now:

1) when to stop the timer?
2) how much more to write past 64GB?

>>  Not including
>>fsync() time would only test the ability of the various parts of the
>>I/O systems to do write buffering.  It's easy to do lots of write
>>buffering, if you buy enough memory.  Forcing the disks to write is
>>the only fair way to compare writes between I/O systems.
>>  
>>
> It isn't fair.  fsync is a different code path, and may be less
> efficient.  Or more, depending on the fs.  reiser4 is currently not
> well optimized for fsync, maybe next year I will change that but not
> this week....

I think we agree that forcing the disks to write all of the data
before the timer stops is a fair way to compare between filesystems.
Otherwise we're "almost" measuring disk throughput, except for what
has been write-buffered...a real gray area.  But I think you're
pointing out that the results could be different depending on whether
the fsync() method or your "write past the intented amount" method for
flushing is used.  I'd be happy to run these benchmarks both ways, as
long as I knew how.  If you can help me answer my above questions,
I'll run them both ways.

Thanks,
-- 
Benjamin Rutt

