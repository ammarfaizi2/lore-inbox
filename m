Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRJaB5n>; Tue, 30 Oct 2001 20:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279806AbRJaB5e>; Tue, 30 Oct 2001 20:57:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:873 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S279519AbRJaB5Z>; Tue, 30 Oct 2001 20:57:25 -0500
Date: Wed, 31 Oct 2001 02:57:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011031025759.H1340@athlon.random>
In-Reply-To: <20011030175417.K1340@athlon.random> <XFMail.20011030182326.pochini@shiny.it> <20011030183058.O1340@athlon.random> <15327.8495.767553.389519@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <15327.8495.767553.389519@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Oct 31, 2001 at 08:52:47AM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Wed, Oct 31, 2001 at 08:52:47AM +1100, Paul Mackerras wrote:
> pte value to the corresponding HPTE.  The performance impact of
> maintaining the accessed and dirty bits in software is negligible

The accessed bit is worthless to be maintained in software. Infact if it
is true that ppc doesn't have an hardware maintained accessed bit (like
alpha) this means ppc _doesn't_ want the tlb flush, just like alpha,
unlike said previously today in other emails. the whole
ptep_test_and_clear_young section + tlb flush should be #ifndeffed out
for those archs. The waste is to care about this non existent  accessed
bit in first place for those archs. Those archs enterely depend on the
minor faults to activate the cache and so we can only unmap
unconditionally the inactive cache on those archs. Infact on those archs
we should probably deactivate all the cache, not only the inactive one,
so that it has a better change to keep the working set in active cache.

with regard to the dirty bit while fixing x86 smp races, Ben did
benchmarks that showed the performance hit isn't negligible if
maintained in software, you know it generates the doube of page faults
with the "right" benchmark, but maybe this is the only sane approch for
ppc.

Andrea
