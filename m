Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131998AbRAVWVy>; Mon, 22 Jan 2001 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRAVWVe>; Mon, 22 Jan 2001 17:21:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59404 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131160AbRAVWVQ>;
	Mon, 22 Jan 2001 17:21:16 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222147.f0MLlxe01758@flint.arm.linux.org.uk>
Subject: Re: Is this kernel related (signal 11)?
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 22 Jan 2001 21:47:58 +0000 (GMT)
Cc: rmager@vgkk.com (Rainer Mager), linux-kernel@vger.kernel.org
In-Reply-To: <200101220753.IAA12360@cave.bitwizard.nl> from "Rogier Wolff" at Jan 22, 2001 08:53:13 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
> Harware problems are normally not reproducable. Can you attach a
> debugger to your X server, and catch it when things go bad? (And
> give the Xfree86 people a backtrace)

Bad RAM can be extremely reproducable though, and can certainly produce
SEGVs.

Evidence: I recently had a bad 128MB SDRAM which *always* failed at byte
address 0x220068, which was the middle of the mem_map array.  All I
needed to do was 'dd if=/dev/hda of=/dev/null' and the machine would
die within 5 minutes due to an invalid buffer_head pointer.

The SDRAM naturally passed each and every single memory test I could
throw at it.  However, a new SDRAM fixed the problem.

It is quite common for SDRAMs to fail in this way - think about the
failure mode.  Some of the silicon in the SDRAM is damaged.  This isn't
going to move about, so its going to be in a fixed position.  A fixed
position means a specific set of transistors, gate, and therefore
memory location.

In answer to the original posters question, the first step would be
to grab a copy of memtest86 (iirc its a program that is run from floppy
disk) and run that on your system.  That /should/ (and I stress should
there) detect any RAM problems you have.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
