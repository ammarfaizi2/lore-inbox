Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTILUJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTILUJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:09:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:28330 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261887AbTILUJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:09:25 -0400
Date: Fri, 12 Sep 2003 22:09:20 +0200 (MEST)
Message-Id: <200309122009.h8CK9KZp006128@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de, davej@redhat.com
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 12:04:35 +0100, Dave Jones wrote:
>On Thu, Sep 11, 2003 at 08:28:16AM +0200, Adrian Bunk wrote:
>
> > - Does the Cyrix III support 686 instructions?
>
>Depends on your definition of 686. If you follow the Intel
>definition (where CMOV is optional), yes. If you follow the gcc
>definition (where CMOV is assumed), no.
>Except for the latest Nehemiah cores (which now have CMOV).

To be fair to gcc, no Intel P6 or above to date has shipped
without CMOV.

> > - Do -march=winchip{2,-c6} and -march=c3{,-2} add anything not in
> >   -march=i686 (except optimizations of otherwise compatible code)?
>
>Not afaik.
>
> > - Which CPUs exactly need X86_ALIGNMENT_16?
>
>Unsure. This could use testing on a few systems.

K7s and P5s (and 486s too if I remember correctly) strongly prefer
code entry points and loop labels to be 16-byte aligned. This is
due to the way code is fetched from L1.

>
> > - X86_GOOD_APIC: Are there really that many processors with a bad APIC?
>
>Mikael ?

Most pre-MMX P5s have a bug which breaks back-to-back writes to
the local APIC space (P5 erratum 11AP), requiring the kernel to
insert a dummy read before each local APIC write. GOOD_APIC is
for P5MMX and above which don't have this bug.

I have a P5 chip with this erratum I sometimes use for testing
(since it's pre-MMX and thus pre-RDPMC), and I know of people
still using dual P5 boxes with these early chips.

/Mikael
