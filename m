Return-Path: <linux-kernel-owner+w=401wt.eu-S1030356AbXAKN0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbXAKN0G (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 08:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbXAKN0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 08:26:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:59926 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030356AbXAKN0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 08:26:05 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: O_DIRECT question
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Aubrey <aubreylee@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Reply-To: 7eggert@gmx.de
Date: Thu, 11 Jan 2007 14:20:19 +0100
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> <7C18X-1zo-5@gated-at.bofh.it> <7C1iw-22q-7@gated-at.bofh.it> <7C1Vb-2Ny-3@gated-at.bofh.it> <7C256-2ZR-27@gated-at.bofh.it> <7C2eE-3rT-15@gated-at.bofh.it> <7C31d-4qb-11@gated-at.bofh.it> <7C3kj-55E-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1H4zqt-000344-FQ@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Aubrey wrote:
>> On 1/11/07, Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>> What you _really_ want to do is avoid large mallocs after boot, or use
>>> a CPU with an mmu. I don't think nommu linux was ever intended to be a
>>> simple drop in replacement for a normal unix kernel.
>> 
>> 
>> Is there a position available working on mmu CPU? Joking, :)
>> Yes, some problems are serious on nommu linux. But I think we should
>> try to fix them not avoid them.
> 
> Exactly, and the *real* fix is to modify userspace not to make > PAGE_SIZE
> mallocs[*] if it is to be nommu friendly.

IMO it's better to go back to a 16-bit segmented system like 80286 than
to artificially limit yourself to 12 bit memory chunks. Even if you don't
have segments, offering a DOS or old MacOS-like memory management
(allocating a fixed block on program start) is way better than "We want
to cache, no matter what it costs".

If you throw away the cache, maybe you'll be slow, but if you throw away
the application, you'll go backwards. If the cache is a problem, allocate
one block of cache, and everybody will be happy. Maybe it's oldscool, but
it works.

> It is the kernel hacks to do things
> like limit cache size that are the bandaids.

Limiting the cache is a feature, since it avoids constantly swapping out
e.g. X11's keyboard mouse routines just because you opened a large picture
in gimp*. Playing with the provided knobs did help for some cases, but I
didn't succeed for the serious cases, and I'm not the world's dumbest
computer user. Having a simple knob "don't grow larger than $num if you
have to evict programs, don't go below $num2" would be THE knob any joe
luser can understand and mostly DTRT or at least what you'd expect.



* I hope the vm_pps will help, but I did not yet read it's docs
