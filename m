Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTIBUnN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTIBUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:43:12 -0400
Received: from cc260354-a.hnglo1.ov.home.nl ([213.51.105.170]:16632 "EHLO
	kars.perseus.home") by vger.kernel.org with ESMTP id S264108AbTIBUnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:43:04 -0400
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
From: Kars de Jong <jongk@linux-m68k.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20030901100807.GB1903@mail.jlokier.co.uk>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be>
	 <1062407310.13046.6.camel@laptop.locamation.com>
	 <20030901100807.GB1903@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1062535375.3501.11.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Sep 2003 22:42:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-01 at 12:08, Jamie Lokier wrote:
> Kars de Jong wrote:
> > On Mon, 2003-09-01 at 10:34, Geert Uytterhoeven wrote:
> > > BTW, probably you want us to run your test program on other m68k boxes? Mine
> > > got a 68040, that leaves us with:
> > >   - 68020+68551
> > >   - 68060
> > 
> > I can run it on these boxes if no-one else has done it yet before I come
> > home tonight. I'm sure there are more people with a 68060 out there, not
> > too sure about the 68020+68851.
> 
> I would prefer that you run the attached program.  It fixes a bug in
> the function which tests whether the problem is in the L1 cache or
> store buffer.  The bug probably didn't affect the test, but it might
> have.
> 
> Ideally you could run the program Geert linked to as well?
> Please remember to compile both with optimisation.

OK, here are my results (I'll skip the 68060 because Roman has already
run the program on that one):

This is on a Plessey PME 68-22. It's sooooo fast... Sam, is there a Sun
slower than this?

Original program:

fikkie:/tmp# ./jamie_test
Test separation: 4096 bytes: pass
Test separation: 8192 bytes: pass
Test separation: 16384 bytes: pass
Test separation: 32768 bytes: pass
Test separation: 65536 bytes: pass
Test separation: 131072 bytes: pass
Test separation: 262144 bytes: pass
Test separation: 524288 bytes: pass
Test separation: 1048576 bytes: pass
Test separation: 2097152 bytes: pass
Test separation: 4194304 bytes: pass
Test separation: 8388608 bytes: pass
Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed

New program:

fikkie:/tmp# time ./jamie_test2
(2048) [10000,10000,0] Test separation: 4096 bytes: pass
(2048) [10000,10000,0] Test separation: 8192 bytes: pass
(2048) [10000,10000,0] Test separation: 16384 bytes: pass
(2048) [10000,10000,0] Test separation: 32768 bytes: pass
(2048) [10000,10000,0] Test separation: 65536 bytes: pass
(2048) [10000,10000,0] Test separation: 131072 bytes: pass
(2048) [10000,10000,0] Test separation: 262144 bytes: pass
(2048) [10000,10000,0] Test separation: 524288 bytes: pass
(2048) [10000,10000,0] Test separation: 1048576 bytes: pass
(2048) [10000,10000,0] Test separation: 2097152 bytes: pass
(2048) [10000,10000,0] Test separation: 4194304 bytes: pass
(2048) [10000,10000,0] Test separation: 8388608 bytes: pass
(2048) [10000,10000,0] Test separation: 16777216 bytes: pass
VM page alias coherency test: all sizes passed
                                                                                
real    1m51.210s
user    1m44.950s
sys     0m4.930s
fikkie:/tmp# cat /proc/cpuinfo
CPU:            68020
MMU:            68851
FPU:            68881
Clocking:       15.6MHz
BogoMips:       3.90
Calibration:    19520 loops
fikkie:/tmp#

And no, this board has no way of getting a better time resolution than
the 100 Hz tick timer either ;-)

Regards,

Kars.

