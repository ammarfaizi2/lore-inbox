Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTLOUTB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTLOUTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:19:01 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264108AbTLOUS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:18:57 -0500
Date: Mon, 15 Dec 2003 20:24:19 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312152024.hBFKOJIK000359@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0312150938540.9281@chaos>
References: <16345.51504.583427.499297@l.a>
 <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos>
 <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0312121435570.1356@chaos>
 <200312131040.hBDAeisM000455@81-2-122-30.bradfords.org.uk>
 <Pine.LNX.4.53.0312150938540.9281@chaos>
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yes, and I recall we agreed to disagree where the FDC stop must
> > > be put, but we both agreed that it must be stopped. I still contend
> > > that since the Linux startup code takes control away from the BIOS,
> > > it's that codes responsibility to turn OFF things that the BIOS
> > > might have left ON.
> >
> > Well, on a practical level, yes, I agree with you, it is the easiest
> > way to solve the problem.
> >
> > On a technical level, I still think that the BIOS configuration is
> > broken if it leaves the floppy motor on, on a system running a kernel
> > without the floppy code compiled in.
> 
> Hmmm. The BIOS doesn't know that you have a kernel without any
> floppy code.

No, but the user does, and if the machine in question boots fast
enough that interrupts are disabled less than two seconds after the
last BIOS floppy access, they should currently avoid configuring the
BIOS in such a way that it accesses floppy drive if there is not going
to be any code to turn it off, which currently means having floppy
support compiled in, (or as a module).

> The BIOS also doesn't know that its timer queue
> is going to be destroyed by the data (code) that it's properly
> reading from some disk. All it knows is that every time the
> floppy is accessed, the motor must be turn ON before access
> and must be turned OFF two seconds after the last access. Since
> it doesn't know when the last access will be (it doesn't know the
> future), it resets a timer-variable upon every access. The timer-
> queue bumps the variable and if it gets to zero, turns OFF the
> FDC motor.
> 
> The BIOS code is properly doing its job. When control is
> taken away from the BIOS, the code that took control

The code that took control is the bootloader, which may never load a
Linux kernel.  Imagine a theoretical future bootloader which disabled
interrupts, thereby stopping the two second floppy motor timeout, and
offered things such as a serial console, monitor, or other diagnostic
features.

> must
> tie up any loose-ends that the BIOS wasn't able to finish.

Possibly, but I still consider the BIOS configuration broken if there
are infact any loose-ends to tie up.

> It's not the job of the boot-loader because it didn't alter
> the BIOS in any way. It used the BIOS to put the kernel in
> it's correct place. Then it gives control to the kernel
> code. It's that kernel code that takes control away from
> the BIOS. It's the responsibility of that kernel code
> to handle the consequences of doing that.

At the end of the day, though, I agree that it's the best way to fix
it, but we shouldn't convince ourselves that it's particularly
elegant.

John.
