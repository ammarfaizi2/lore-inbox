Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRJaAkp>; Tue, 30 Oct 2001 19:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278189AbRJaAk1>; Tue, 30 Oct 2001 19:40:27 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:60421 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277541AbRJaAkP>;
	Tue, 30 Oct 2001 19:40:15 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15327.18461.543095.591869@cargo.ozlabs.ibm.com>
Date: Wed, 31 Oct 2001 11:38:53 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030183058.O1340@athlon.random>
In-Reply-To: <20011030175417.K1340@athlon.random>
	<XFMail.20011030182326.pochini@shiny.it>
	<20011030183058.O1340@athlon.random>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:

> On Tue, Oct 30, 2001 at 06:23:26PM +0100, Giuliano Pochini wrote:
> > 
> > >> #ifdef ?
> > >
> > > yes, but not for ppc, for alpha and all other archs without accessed bit
> > > provided in hardware (and cached in the tlb).
> > 
> > PPCs have that bits. I'm not sure if they are cached in the tbl.
> 
> yes, this is why it won't need to define the HAVE_NO_ACCESS_BIT_IN_TLB,
> only alpha will.  but again I'm not sure if it worth given we just
> reduced the flush frequency of an order of magnitude.

I don't think it has to do with whether the accessed bit is maintained
by hardware or by software.  On PPC, we actually maintain the accessed
and dirty bits in software - we don't use the hardware-maintained
R (referenced) and C (changed) bits, because they are in the HPTEs
(the PTEs in the hash table), and it is hard to get back from a linux
pte value to the corresponding HPTE.  The performance impact of
maintaining the accessed and dirty bits in software is negligible
according to the benchmarks I have done, and it is much much simpler
than trying to use the hardware R and C bits.

Paul.
