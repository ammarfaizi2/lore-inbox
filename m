Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131459AbQKTIM3>; Mon, 20 Nov 2000 03:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbQKTIMT>; Mon, 20 Nov 2000 03:12:19 -0500
Received: from Prins.externet.hu ([212.40.96.161]:34568 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S130440AbQKTIMD>; Mon, 20 Nov 2000 03:12:03 -0500
Date: Mon, 20 Nov 2000 08:41:52 +0100 (CET)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 36 bit MTRRs (fix for some big memory machines)
In-Reply-To: <Pine.LNX.4.10.10011191815160.850-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.02.10011200825550.11321-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus!

Will you consider applying the following patchset? You will find it at
ftp://ftp.externet.hu/pub/people/zboszor/mtrr-new2.tar.gz

I know that you like plain text patches inlined in the mail
but I do not know how to get pine to inline the (plain text)
attachments...

Here is the README from the package:

********************************************
This patchset contains fixes and enhancements for mtrr.c, the patches are
against 2.4.0-test11-pre5 and should be applied in the following
order:

1. mtrr-vs-new-cpuid.diff
    This is David Wragg's 36 bit MTRR patch (so big memory machines
    do not slow down) updated for HPA's new CPUID code.

2. mtrr-x86-64.diff
    This allows the AMD Hammer to use its 40 (or more) bits wide MTRRs
    using the phyical address width query feature.

3. mtrr-sizefix.diff
    This fixes a problem: do not allow wider base/size parameters
    than the arch could handle. (E.g. my PIII happily accepted and
    MTRR entry with 4GB size starting at 64 GB - since the base was
    correctly masked, the result was a 4GB MTRR starting at 0.

4. mtrr-page.diff
    David's patch changed mtrr.c's internal functions to pass the
    base and size  parameters in page granular units.
    This patch exposes this feature in the kernel,
    providing mtrr_add_page() and mtrr_del_page().

5. mtrr-proc.diff
    This enables setting MTRRs above 4GB through /proc/mtrr.
    (To achieve this, I had to add simple_strtoull() to lib/vsprintf.c.)

6. mtrr-ioctl.diff
    This enables setting MTRRs above 4GB through ioctls.

It is very likely that if you leave out one patch, the next ones will
not apply. (There will be rejects.)
********************************************

I discussed these changes with David Wragg, he blessed it. :-)

Three notes, though:

This patchset was tested on Athlon, PPro (by David Wragg), dual PIII and
dual Celeron machines. (by me)

Patch #3 tries to correctly handle those CPUs where the MTRRs/ARRs/MCRs
are 32 bit wide.

Patch #5 _required_ 64 bit arithmetics, but egcs-1.1.2 seems to
handle this correctly.

Regards,
Zoltan Boszormenyi <zboszor@mail.externet.hu>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
