Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTIALbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIALbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:31:41 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:10207 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262234AbTIALbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:31:39 -0400
Date: Mon, 1 Sep 2003 13:30:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Russell King <rmk@arm.linux.org.uk>,
       "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
In-Reply-To: <20030901101224.GB1638@mail.jlokier.co.uk>
Message-ID: <Pine.GSO.4.21.0309011323351.5048-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Jamie Lokier wrote:
> There is a bug in test_l1_only which I just noticed.  It's unlikely,
> but if `dummy' happens to have the same L1 cache address as both words
> being tested, and it's a 2-way (or less) set-associative cache, then
> it will inadvertently flush the cache and say "store buffer not
> coherent" when it means to say "cache not coherent".
> 
> Please try the program below, which is the same as before but with
> test_l1_only hopefully improved, and it prints some more helpful
> numbers.

Results for 68040 with the new version:

cassandra:/tmp# time ./test2
Test separation: 4096 bytes: FAIL - store buffer not coherent
Test separation: 8192 bytes: FAIL - store buffer not coherent
Test separation: 16384 bytes: FAIL - store buffer not coherent
Test separation: 32768 bytes: FAIL - store buffer not coherent
Test separation: 65536 bytes: FAIL - store buffer not coherent
Test separation: 131072 bytes: FAIL - store buffer not coherent
Test separation: 262144 bytes: FAIL - store buffer not coherent
Test separation: 524288 bytes: FAIL - store buffer not coherent
Test separation: 1048576 bytes: FAIL - store buffer not coherent
Test separation: 2097152 bytes: FAIL - store buffer not coherent
Test separation: 4194304 bytes: FAIL - store buffer not coherent
Test separation: 8388608 bytes: FAIL - store buffer not coherent
Test separation: 16777216 bytes: FAIL - store buffer not coherent
VM page alias coherency test: failed; will use copy buffers instead

real	0m0.454s
user	0m0.090s
sys	0m0.210s
cassandra:/tmp# cat /proc/cpuinfo 
CPU:		68040
MMU:		68040
FPU:		68040
Clocking:	24.8MHz
BogoMips:	16.53
Calibration:	82688 loops
cassandra:/tmp# 

New m68k binary at http://home.tvd.be/cr26864/Linux/m68k/jamie_test2.gz

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


