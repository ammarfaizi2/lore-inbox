Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263132AbRFEScV>; Tue, 5 Jun 2001 14:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbRFEScL>; Tue, 5 Jun 2001 14:32:11 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:17862 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263132AbRFEScH>; Tue, 5 Jun 2001 14:32:07 -0400
Date: Tue, 5 Jun 2001 20:32:50 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <20010605214107.A566@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010605201147.26115F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Ivan Kokshaysky wrote:

> Hmm, yes. However, your patch isn't pretty, too. You may check
> the same area twice, and won't satisfy requested address > TASK_UNMAPPED_BASE.

 Only a single address may be checked twice.  There is no second loop I'm
trying to avoid.  The loop starts from addr or TASK_UNMAPPED_BASE,
whichever is lower.  If that won't succeed you won't be able to mmap
anything anyway.

> What do you think about following? Everything is scanned only once, and
> returned address matches specified one as close as possible.

 No, no, no...  The address specified is a hint only and the system is
free to use any other.  Actually this patch made me curious, why we should
change the limit -- TASK_SIZE is fine in all cases.  After a bit of
studying of Alpha headers, I concluded none of the patches is needed at
all, because TASK_UNMAPPED_BASE is set to:

((current->personality & ADDR_LIMIT_32BIT) ? 0x40000000 : TASK_SIZE / 2)

to support 32-bit binaries.  So if the personality is set appropriately
for netscape, mmap() should work fine as is, placing maps in the low 4GB.
No need to patch arch_get_unmapped_area(), but OSF/1 compatibility code
might need fixing.  I suppose an OSF/1 binary must have an appropriate
flag set in its header after building with the -taso option so that the
system knows the binary wants 32-bit addressing.

 I have no Alpha/Linux system available anymore -- could anyone else check
what the real problem with netscape is?

 Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

