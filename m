Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUG0RbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUG0RbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUG0RbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:31:21 -0400
Received: from main.gmane.org ([80.91.224.249]:27529 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266488AbUG0RbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:31:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Tue, 27 Jul 2004 13:31:04 -0400
Message-ID: <87vfg9nyqv.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
 <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
 <4106013E.30408@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:zzMsvun0ufFfkT6UXjI3QKk5iAw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> when benchmarking, please be careful that you don't end up
> benchmarking umount/mount, or sync, or..... it can be remarkably hard
> to avoid such mistakes.....

I agree, I've made some blunders like that in the past.  However for
write tests, we are including fsync() time, once, at the end of a file
write, since I feel it's unfair to trim that time.  Not including
fsync() time would only test the ability of the various parts of the
I/O systems to do write buffering.  It's easy to do lots of write
buffering, if you buy enough memory.  Forcing the disks to write is
the only fair way to compare writes between I/O systems.

> I tend to try to use large enough filesets that small things like
> cache flush happenstance or bitmap loading overhead do not sway the
> benchmark.

Sounds familiar...we cycle among file sizes at every power of 2 point
from 8MB to 64GB.  So by the time we access the 64GB file, all the
previous accesses for 8M..32GB will probably have pushed all of the
64GB file out of cache.

> Rebooting tends to work for resetting the OS thoroughly, though I
> would be curious to hear comments on whether one ought to power down
> the disk drive so that its cache flushes......;-)

With the mass storage environment I'm working in, you'd need to power
down the whole storage cluster, then remove that batteries that back
the controller cache...yes, clearing kernel cache is often just the
beginning. :)
-- 
Benjamin Rutt

