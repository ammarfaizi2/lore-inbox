Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282378AbRLMK2M>; Thu, 13 Dec 2001 05:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRLMK2D>; Thu, 13 Dec 2001 05:28:03 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:37391 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280771AbRLMK1n>;
	Thu, 13 Dec 2001 05:27:43 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wayne Whitney <whitney@math.berkeley.edu>
Date: Thu, 13 Dec 2001 11:27:10 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
CC: LKML <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <BDD02BB0D67@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 01 at 22:28, Wayne Whitney wrote:

> BTW, if one were trying to port some code that uses brk() directly and
> even frees memory that way, then it seems that with glibc's malloc(), one
> could make it work by instructing malloc() always to use mmap().

> P.S.  I am 100% sure that the particular application of mine that started
> me thinking about this, MAGMA, uses its own allocator built on top of
> brk() and never calls malloc() itself.

If you have legacy app, how it comes that it uses mmap? And if I do
not use mmap, I have nothing at 1GB:

void main() { sleep(10); brk((void*)0xBF000000); pause(); }

/proc/`pidof x`/maps says during sleep(10):

08048000-080a1000 r-xp 00000000 03:03 230941   /usr/src/linus/x
080a1000-080a5000 rw-p 00058000 03:03 230941   /usr/src/linus/x
080a5000-080a6000 rwxp 00000000 00:00 0
bffff000-c0000000 rwxp 00000000 00:00 0

and after brk() (which suceeded after I did ulimit -d unlimited
and 'echo 1 >/proc/sys/vm/overcommit_memory') I see:

08048000-080a1000 r-xp 00000000 03:03 230941   /usr/src/linus/x
080a1000-080a5000 rw-p 00058000 03:03 230941   /usr/src/linus/x
080a5000-bf000000 rwxp 00000000 00:00 0
bffff000-c0000000 rwxp 00000000 00:00 0

So maybe MAGMA uses some API which it should not use under any
circumstances... Such as that you linked it with libc6 stdio.
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
