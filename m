Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVCDCty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVCDCty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVCDCtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:49:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:27102 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262714AbVCDCqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:46:14 -0500
Date: Fri, 4 Mar 2005 03:47:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ian Molton <spyro@f2s.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Matthew Wilcox <matthew@wil.cx>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@au.ibm.com>,
       "David S. Miller" <davem@davemloft.net>,
       "William L. Irwin" <wli@holomorphy.com>, Andi Kleen <ak@suse.de>,
       Richard Henderson <rth@twiddle.net>
Subject: [PATCH][0/10] verify_area cleanup
Message-ID: <Pine.LNX.4.62.0503040247220.2801@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that 2.6.11 is out the door it's time to try and submit this again.

The following patches convert all users of verify_area to access_ok and 
the final patch then deprecates verify_area acros all archs with the 
intention of removing it completely later. These patches get rid of 99+% 
of all users, there's still one or two macros left using it and there are 
still a few comments left refering to it that could be cleaned up - I'll 
get to those, but what remains after these patches is extremely little.

The reason for doing this is that verify_area is just a wrapper for 
access_ok anyway, so there's no good reason to keep it around - access_ok 
also seems more readable anyway with saner return values.

Since these patches touch things all over the tree the CC list would be 
enormous if I CC'd everyone involved on all patches, so I'll just CC this 
initial mail to a few key people I think are relevant (I hope I got that 
list right), and the actual patches I'll just send to linux-kernel and 
Andrew (or directly to people who ask for that).

I've split this into 10 patches like this :

[1] drivers part 1
	This patch cleans up the first half of drivers/

[2] drivers part 2
	This patch cleans up the second half of drivers/

[3] sound
	Cleans up everything in sound/

[4] i386 and misc.
	This cleans up arch/i386 plus kernel/ and a few other bits that 
	got left over from the other patches

[5] mips
	Everything in arch/mips
	
[6] ppc, ppc64, m68k, m68knommu
	ppc, ppc64, m68k and m68knommu cleanup are in this on

[7] sparc and sparc64
	Thi patch takes care of sparc and sparc64

[8] x86_64 and ia64
	cleanups for x86_64 and ia64 are in this patch

[9] misc remaining archs
	all remaining archs are cleaned up in one bunch by this patch
	
[10] deprecate
	This final patch deprecates verify_area across all archs.


I've been hoping that these could perhaps (after proper review of course) 
go into -mm to actually get some testing beyond what I'm able to do, so 
that maybe they could migrate into mainline within a release or two...

Speaking of testing, the changes in [4] are what affect my box here, so 
those I've been able to both build and boot. As for the rest, I've only 
been able to verify that a make of allyesconfig doesn't seem to have 
issues with these patches, but I don't have any way to actually boot test 
on anything but i386. But I think these patches are fairly low risk since 
the change from verify_area to access_ok is resonably simple in most 
cases.

I hope you will find the patches acceptable and I look forward to any 
feedback you might have.


-- 
Jesper Juhl




