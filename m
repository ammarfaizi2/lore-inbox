Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRJNG7h>; Sun, 14 Oct 2001 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274634AbRJNG71>; Sun, 14 Oct 2001 02:59:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4932 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S274627AbRJNG7N>; Sun, 14 Oct 2001 02:59:13 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2001 00:49:34 -0600
In-Reply-To: <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>
Message-ID: <m1lmiera0x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 13 Oct 2001, Jamie Lokier wrote:
> >
> > There are applications (GCC comes to mind) which are using mmap() to
> > read files now because it is measurably faster than read(), for
> > sufficiently large source files.
> >
> > I don't know where the optimal costs lie.
> 
> The gcc people tested it, and their cut-off point is at 30kB or so.
> Anything smaller than that is faster to just "read()".
> 
> Now, that's a traditional mmap(), though, which has more overhead than a
> "read-with-PAGE_COPY" would have. The pure mmap() approach has the actual
> page fault overhead too, along with having to do "fstat()" and "munmap()".

Hmm.  read-with-PAGE_COPY may not be any faster than read as you still
read all of the data into memory, so you have almost the same latency.
mmap might work better because of better overlapping of I/O and cpu
processing.

Also read-with-PAGE_COPY has some really interesting implications for the
page out routines.  Because anytime you start the page out you have to
copy the page.  Not exactly when you want to increase the memory presure.
And not at all suitable for shared libraries.

Eric
