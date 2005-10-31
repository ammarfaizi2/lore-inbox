Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVJaQBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVJaQBj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVJaQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:01:39 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:48396 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932344AbVJaQBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:01:38 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <20051030105118.GW4180@stusta.de> <p73mzkqubf4.fsf@verdi.suse.de>
	<20051030183821.GI4180@stusta.de> <200510302035.49765.ak@suse.de>
	<20051030194951.GJ4180@stusta.de>
From: Nix <nix@esperi.org.uk>
X-Emacs: featuring the world's first municipal garbage collector!
Date: Mon, 31 Oct 2005 15:59:02 +0000
In-Reply-To: <20051030194951.GJ4180@stusta.de> (Adrian Bunk's message of "30
 Oct 2005 19:50:22 -0000")
Message-ID: <87wtjt7k55.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Oct 2005, Adrian Bunk said:
> E.g. it's clear that unused code or unused EXPORT_SYMBOL's in the kernel 
> are bloat, so I am working on eliminating such bloat.

And thank you very much for that!

What's most notable to me is a substantial cross-arch reduction in .data
space consumed. This non-FUSE-2.6.13 versus FUSE-2.6.14 UltraSPARC
comparison shows this effect clearly:

-rwxr-xr-x  1 root root 3460304 Oct 13 00:55 vmlinux-2.6.13.4
-rwxr-xr-x  1 root root 3190448 Oct 29 17:18 vmlinux-2.6.14

                         2.6.13.4     2.6.14 
section                      size       size    diff
.text                     2330144    2341280  +10236
.rodata                    198361     199009    +648
.pci_fixup                   1536       1536       0
__ksymtab                   32352      32336     -16
__ksymtab_gpl                3536       4048    +512
__kcrctab                       0          0       0
__kcrctab_gpl                   0          0       0
__ksymtab_strings           44688      45424    +736
__param                      1640       1640       0
.data                      669288     387576 -281712
.data.cacheline_aligned       704        704       0
.data.read_mostly             428      13144  -12716
.fixup                      18256      18268     +12
__ex_table                  15760      15768      +8
.init.text                 109728      94528  -15200
.init.data                   7280       8712   +1432
.init.setup                   792        816     +24
.initcall.init                784        808     +24
.con_initcall.init             16         16       0
.security_initcall.init         0          0       0
.init.ramfs                   134        134       0
.bss                       226528     226152    -376
.note.GNU-stack                 0          0       0
__ex_table.1                  216        216       0
__ex_table.2                   16        496    +480
Total                     3662187    3392611 -269576

On a similarly-configured Athlon the difference in .data is a little
less pronounced, but still there.

UltraSPARC 2.6.13.4 versus 2.6.14 at boot:

Memory: 511576k available (2280k kernel code, 936k data, 128k init) [fffff80000000000,0000000037ebc000]
Memory: 511848k available (2288k kernel code, 672k data, 112k init) [fffff80000000000,0000000037ebc000]

(that's 264K, the same as the .data size difference above)

Athlon 2.6.13.4 versus 2.6.14 at book:

Memory: 774828k/786432k available (2794k kernel code, 11156k reserved, 1022k data, 148k init, 0k highmem)
Memory: 774996k/786432k available (2833k kernel code, 10988k reserved, 808k data, 152k init, 0k highmem)

(that's 214K different in .data although kernel code has grown a little
here, probably thanks to FUSE).

Most OSes cannot claim to shrink across upgrades. Linux, at least the
kernel, can. :)

-- 
`"Gun-wielding recluse gunned down by local police" isn't the epitaph
 I want. I am hoping for "Witnesses reported the sound up to two hundred
 kilometers away" or "Last body part finally located".' --- James Nicoll
