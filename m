Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135199AbRDROyp>; Wed, 18 Apr 2001 10:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135200AbRDROyi>; Wed, 18 Apr 2001 10:54:38 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16480 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135199AbRDROxx>; Wed, 18 Apr 2001 10:53:53 -0400
Date: Wed, 18 Apr 2001 17:07:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Theodore Tso <tytso@mit.edu>, "David S. Miller" <davem@redhat.com>,
        Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5 Workshop RealVideo streams -- next time, please get better audio.
Message-ID: <20010418170702.B30770@athlon.random>
In-Reply-To: <20010417205722.A3626@think> <200104180246.f3I2kL1192784@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104180246.f3I2kL1192784@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Apr 17, 2001 at 10:46:20PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 10:46:20PM -0400, Albert D. Cahalan wrote:
> support for NUMA hardware (it's not cache coherent) right now

btw, there are three kind of NUMA systems:

        1)      cc-numa first citizens (wildfire alpha, future chips)
        2)      cc-numa second citizens (origin2k)
        3)      non cache coherent numa machines

On the first class numa citizens NUMA means "heuristics for higher performance".
On those systems you don't need any NUMA change for correct operation of the
kernel (besides the fact you may need to use discontigmem to boot the kernel
if there can be huge physical holes in the physical layout of the ram but
that is true also for any other non numa machine with big holes in the physical
ram address space).

On the second and thrid class of NUMA systems NUMA means "required changes
for correct operations of the system". difference between 1 and 2 is that
category 2) needs also to put specialized PIO memory barriers to serialize the
I/O across different nodes. So it "only" additionaly requires total auditing of
the device drivers.

I think linux will need to optimize class 1 of systems and I assume SGI has the
PIO memory barriers patches for the device drivers to support class 2 as well.

Nobody ever considered the non cache coherent numa support so far AFIK and
I guess it will hardly end into mainline (personally I wouldn't be that
excited to deal with that additional complexity ;). If you can tell, what
system is it?

Andrea
