Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265455AbRGCIWm>; Tue, 3 Jul 2001 04:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265583AbRGCIWd>; Tue, 3 Jul 2001 04:22:33 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13992 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265455AbRGCIWX>;
	Tue, 3 Jul 2001 04:22:23 -0400
Message-ID: <3B4180BB.ED7B45F@mandrakesoft.com>
Date: Tue, 03 Jul 2001 04:22:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <3963.994148157@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> > Russell King wrote:
> > >
> > > On Mon, Jul 02, 2001 at 05:56:56PM +0100, Alan Cox wrote:
> > > > Case 1:
> > > >       You pass a single cookie to the readb code
> > > >       Odd platforms decode it
> > >
> > > Last time I checked, ioremap didn't work for inb() and outb().
> >
> > It should :)
> 
> Surely it shouldn't... ioremap() is for mapping "memory-mapped I/O" resources
> into the kernel's virtual memory scheme (at least on the i386 arch). There's
> no way to tell the CPU/MMU that a particular pages should assert the IO access
> pin rather than memory access pin (or however it is done externally).

The "at least on the i386 arch" part is the key caveat.  On PPC AFAIK,
PIO is remapped and treated very similarly to MMIO.  ioremap on x86, for
PIO, could probably be a no-op, simply returning the same address it was
given.  For other arches which want to do more complex mappings, ioremap
is IMHO the perfect part of the API for the job.

Basically I don't understand the following train of thought:

* We needed to remap MMIO, therefore ioremap was created.
* Now, we need to remap PIO too [on some arches].  Let's hide the
remapping in arch-specific code.

That's an understandable train of thought from an
implement-it-now-in-2.4 standpoint, but not from a
2.5-design-something-better standpoint.

	Jeff


-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
