Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSJWDEz>; Tue, 22 Oct 2002 23:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262791AbSJWDEz>; Tue, 22 Oct 2002 23:04:55 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:43182 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262789AbSJWDEy>; Tue, 22 Oct 2002 23:04:54 -0400
Date: Wed, 23 Oct 2002 01:10:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andi Kleen <ak@muc.de>
cc: Gerrit Huizenga <gh@us.ibm.com>, <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
In-Reply-To: <m3fzuxq2k5.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44L.0210230108550.28073-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 2002, Andi Kleen wrote:
> Gerrit Huizenga <gh@us.ibm.com> writes:
>
> > If the shared pte patch had mmap support, then all shared libraries
> > would benefit.  Might need to align them to 4 MB boundaries for best
> > results, which would also be easy for libraries with unspecified
> > attach addresses (e.g. most shared libraries).
>
> But only if the shared libraries are a multiple of 2/4MB, otherwise
> you'll waste memory. Or do you propose to link multiple mmap'ed
> libraries together into the same page ?

Using shared page tables all you'll waste is virtual space.

The shared page table for eg. /lib/libc.so will eventually
end up mapping all of the libc pages that are used by the
system's workload and processes won't pagefault on any libc
page that's already present in ram.

Sounds like a win/win solution, cutting down both on pagetable
overhead and on pagefaults.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

