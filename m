Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVKBF4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVKBF4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVKBF4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:56:48 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:13318 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751499AbVKBF4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:56:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
X-Message-Flag: Warning: May contain useful information
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
	<20051031160557.7540cd6a.akpm@osdl.org>
	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
	<20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
	<Pine.LNX.4.64.0511012142200.27915@g5.osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 01 Nov 2005 21:56:41 -0800
In-Reply-To: <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 1 Nov 2005 21:43:28 -0800 (PST)")
Message-ID: <52u0eva8yu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Nov 2005 05:56:42.0353 (UTC) FILETIME=[32EC2610:01C5DF72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> I really don't see the point of shaving less than a kB with
    Linus> ugly calling convention magic, when switching to -Os can
    Linus> save us much more, and when the networking code is several
    Linus> hundred kB.

Fair enough, although to be fair the savings are still there even with
-Os enabled.  With CONFIG_CC_OPTIMIZE_FOR_SIZE=y:

   text	   data	    bss	    dec	    hex	filename
 682564	 197172	 116384	 996120	  f3318	vmlinux-before
 681824	 197244	 116384	 995452	  f307c	vmlinux-after

And with a realistic config rather than allnoconfig, you could easily
save as much as 3 or even 4 KB of text!

BTW, allnoconfig has CONFIG_NET=n, so we have to find someone else to
blame here.

    Linus> If we start doing size optimizations, we need to think big.

No pun intended I'm sure...

Anyway, it would be great to find ways to make big improvements.  But
I think the most realistic way to shrink the kernel is the same way it
grows in the first place -- one small piece at a time.

 - R.
