Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTEXJ7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 05:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTEXJ7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 05:59:39 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11696 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264133AbTEXJ7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 05:59:38 -0400
Date: Sat, 24 May 2003 12:12:44 +0200 (MEST)
Message-Id: <200305241012.h4OACiZj011434@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: david@wwns.com, linux-kernel@vger.kernel.org
Subject: Re: Asrock K7S8X Motherboard kernel problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 17:19:31 -0500 (CDT), David R. Wilson wrote:
>I must be missing something, I have an Asrock K7S8X motherboard.
...
>The boot messages mention a missing floppy controller among other 
>problems:

Key words: Asrock (ASUS actually) and no FDC found.

This has been observed before on semi-recent ASUS mainboards.
It's caused by some boot loaders that use an incorrect "out"
instruction intended to reset the FDC. That "out" instruction
was acceptable for ancient FDCs, but it locks up the FDCs in
newer super-I/O chips found in some ASUS mainboards. The correct
approach is to issue a BIOS call instead, or use a real driver
that knows how to identify and drive newer FDCs.

This bug existed in the kernel's boot loader up until 2.4.13 or
so when I fixed it to eliminate the FDC lock up problem on my
ASUS P4T-E. Lilo and syslinux-2.02 don't have the bug. I have
seen GRUB lock up the FDC, however, which is yet another reason
why I don't use that POS.

What boot loader are you using? If the bug goes away with another
boot loader, then file a bug report with your vendor.

/Mikael
