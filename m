Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268917AbRHFRqd>; Mon, 6 Aug 2001 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268914AbRHFRqX>; Mon, 6 Aug 2001 13:46:23 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:60391 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268917AbRHFRqI> convert rfc822-to-8bit; Mon, 6 Aug 2001 13:46:08 -0400
Message-Id: <5.1.0.14.2.20010806184120.04b9b640@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 Aug 2001 18:46:09 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: /proc/<n>/maps growing...
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
        "David S. Miller" <davem@redhat.com>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108061019280.8972-100000@penguin.transmeta.
 com>
In-Reply-To: <20010806143603.C20837@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:20 06/08/2001, Linus Torvalds wrote:

>On Mon, 6 Aug 2001, Andrea Arcangeli wrote:
>
> > On Tue, Aug 07, 2001 at 12:26:50AM +1200, Chris Wedgwood wrote:
> > > mmap does merge in many common cases.
> >
> > (assuming you speak about 2.2 because 2.4 obviously doesn't merge
> > anything and that's the point of the discussion) So what? What do you
> > mean with your observation?
>
>2.4.x _does_ merge. Look for yourself. It doesn't merge mprotects, no. And
>why should glibc do mprotect() for a malloc() call? Electric Fence, yes.
>glibc, no.

Is it possible that is has something to do with what "man malloc" on my 
machine says in the notes section:

---quote from man page, glibc 2.2.3-14 on RedHat 7.something---
Recent versions of Linux libc (later than 5.4.23) and GNU libc (2.x) 
include a malloc implementation which is tunable via environment variables. 
When MALLOC_CHECK_ is set, a special (less efficient) implementation is 
used which is designed to be tolerant against simple errors, such as double 
calls of free() with the same argument, or overruns of a single byte 
(off-by-one bugs). Not all such errors can be proteced against, however, 
and memory leaks can result. If MALLOC_CHECK_ is set to 0, any detected 
heap corruption is silently ignored; if set to 1, a diag­nostic is printed 
on stderr; if set to 2, abort() is called immediately. This can be useful 
because otherwise a crash may happen much later, and the true cause for the 
problem is then very hard to track down.
---eoq---

That sounds like the kind of stuff Electric Fence would be doing, doesn't it?

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

