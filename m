Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279985AbRJ3Pvn>; Tue, 30 Oct 2001 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279984AbRJ3PvY>; Tue, 30 Oct 2001 10:51:24 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16756 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279962AbRJ3PvQ>; Tue, 30 Oct 2001 10:51:16 -0500
Date: Tue, 30 Oct 2001 16:51:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011030165119.I1340@athlon.random>
In-Reply-To: <20011030162008.G1340@athlon.random> <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0110301324410.2963-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Oct 30, 2001 at 01:34:50PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 01:34:50PM -0200, Rik van Riel wrote:
> On Tue, 30 Oct 2001, Andrea Arcangeli wrote:
> > On Mon, Oct 29, 2001 at 09:25:46PM -0500, Benjamin LaHaise wrote:
> > > I fully well expect it to be.  However, from the point of view of stability
> > > we *want* to be conservative and correct.  If Al had to demonstrate with
> >
> > Dave just told you what this change has to do with stability, not sure
> > why you keep reiterating about stability and correctness.
> >
> > But of course going from page flush to the mm flush is fine from my part
> > too. As Linus noted a few days ago during swapout we're going to block
> > and reschedule all the time, so the range flush is going to be a noop in
> 
> Only on architectures where the TLB (or equivalent) is
> small and only capable of holding entries for one address
> space at a time.
> 
> It's simply not true on eg PPC.

I thought at alpha of course but alpha doesn't provide an hardware
accessed bit in first place :).

my view was too x86-64/x86/alpha centric (incidentally the only archs I
test personally :), I really didn't considered the case of tagged tlb +
accessed bit both provided by the cpu while making that change, so we
hurted ia64 and ppc, but it will be trivial to fix now that Ben promptly
noticed the problem, thanks Ben, good catch, that's really appreciated!

Anwyays this have _nothing_ to do at the very least with stability
unlike the above subliminal messages are implying, see above, it can
only potentially be less responsive under very heavy swap on ia64 and
ppc (dunno sparc64?), period. mentioning real life workloads like Oracle
and RHDB in relation to the tlb flush for the accessed bit is further
subliminal bullshit, Oracle definitely isn't supposed to swap heavily
during the benchmarks, and I'm sure it's not the case for mainline
postrgres either (dunno about RHDB).

Andrea
