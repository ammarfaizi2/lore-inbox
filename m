Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKAMyW>; Wed, 1 Nov 2000 07:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbQKAMyK>; Wed, 1 Nov 2000 07:54:10 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:63740 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129655AbQKAMxw>;
	Wed, 1 Nov 2000 07:53:52 -0500
Date: Wed, 1 Nov 2000 13:51:55 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200011011251.NAA24041@harpo.it.uu.se>
To: tigran@veritas.com
Subject: Re: Linux-2.4.0-test10
Cc: dr@bofh.de, linux-kernel@vger.kernel.org, richard.schaal@intel.com,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Tigran Aivazian wrote:

>But it contains an erroneous part in microcode.c:
>
>-       if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6){
>+       if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 != 6){
>                printk(KERN_ERR "microcode: CPU%d not an Intel P6\n",
>cpu_num);
>
>
>It was not in Daniel's cleanup patch which I saw but came from elsewhere.
>Are there Intel CPUs with family>6 which do not support the same mechanism
>for microcode update as family=6? The manuals suggest that test for ">" is
>correct, i.e. that Intel will maintain compatibility with P6 wrt microcode
>update.

The patch came from me, as part of the patch kit to make the kernel
safe(r) for the Pentium IV processor. There were several places
which made unwarranted assumptions about ->x86 not exceeding 6, and
they would break since Pentium IV has family 15.

[Reading #243192 ...]
Concerning the microcode update driver, I cannot find anything in
the IA32-Vol3 manual to suggest it is not P6 specific.
The Pentium IV is not a P6, hence the stricter test.

Of course, this should be reviewed once the PentiumIV-updated
IA32-Vol3 manual has been released.

You say the manuals suggest testing for family >= 6.
Exactly which manual does that, and where?

(But I should have passed the patch to you Tigran before Linus.
Mea culpa, but it seemed such an obvious bug&fix ...)

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
