Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276708AbRKAAeY>; Wed, 31 Oct 2001 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRKAAeP>; Wed, 31 Oct 2001 19:34:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6499 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276708AbRKAAeB>; Wed, 31 Oct 2001 19:34:01 -0500
Date: Thu, 1 Nov 2001 01:34:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ben Smith <ben@google.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011101013437.L1291@athlon.random>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z2WJ-0000wc-00@starship.berlin> <3BE07730.60905@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BE07730.60905@google.com>; from ben@google.com on Wed, Oct 31, 2001 at 02:12:00PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 02:12:00PM -0800, Ben Smith wrote:
> My test application gets killed (I believe by the oom handler). dmesg
> complains about a lot of 0-order allocation failures. For this test,
> I'm running with 2.4.14pre5aa1, 3.5gb of RAM, 2 PIII 1Ghz.

Interesting, now we need to find out if the problem is the allocator in
2.4.14pre5aa1 that fails too early by mistake, or if this is a true oom
condition. I tend to think it's a true oom condition since mainline
deadlocked under the same workload where -aa correctly killed the task.

Can you provide also a 'vmstat 1' trace of the last 20/30 seconds before
the task gets killed?

A true oom condition could be caused by a memleak in mlock or something
like that (or of course it could be a bug in the userspace testcase, but
I checked the testcase a few weeks ago and I didn't found anything wrong
in it).

Andrea
