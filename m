Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317157AbSFFU2Q>; Thu, 6 Jun 2002 16:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317167AbSFFU2P>; Thu, 6 Jun 2002 16:28:15 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33787 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317157AbSFFU1I>;
	Thu, 6 Jun 2002 16:27:08 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15615.50586.395120.207271@napali.hpl.hp.com>
Date: Thu, 6 Jun 2002 13:27:06 -0700
To: Andi Kleen <ak@suse.de>
Cc: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <p73lm9schms.fsf@oldwotan.suse.de>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 06 Jun 2002 21:49:15 +0200, Andi Kleen <ak@suse.de> said:

  Andi> "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com> writes:
  >> (*Really* ugly is s390x, because we need about twice as much
  >> stack on average than on s390, but page size is still only 4K --
  >> most other 64-bit platforms have 8K page size ...)

  Andi> <minor detail, but perhaps still interesting>

  Andi> Seems to be an old myth. Actually the 4K paged 64bit platforms
  Andi> are in the majority.

  Andi> 64bit linux platforms:

  Andi> 4K page: x86-64, ppc64, s390x, mips64, parisc64(?)  8K: alpha,
  Andi> sparc64 8-64K: ia64

Just a minor nit: for ia64 it's either 32KB (for page sizes up to
16KB) or 64KB (for 64KB page size).  The 32KB is conservative and
based on the assumption that there can be up to 16 nested interrupts
plus some other nested traps (such as unaligned faults).  A separate
irq stack should let us reduce the per-task stack size.

	--david
