Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUIONs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUIONs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUIONr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:47:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3458 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266333AbUIONpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:45:41 -0400
Date: Wed, 15 Sep 2004 09:45:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andre Bonin <kernel@bonin.ca>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI coprocessors
In-Reply-To: <41483BD3.4030405@bonin.ca>
Message-ID: <Pine.LNX.4.53.0409150931540.7297@chaos>
References: <41483BD3.4030405@bonin.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Andre Bonin wrote:

> Hey all,
> I'me building an FPGA based pci board for a degree project.  In theory
> this board could be used as a custom, field programmable coprocessor (to
> accelerate processes).  At which point, it might be nice to be able to
> support it as a processor under the kernel.
>
> Yes bandwidth, yes it should be PCI-Express but it is still just a
> degree project, 33mhz is fast enough for the proof of concept.
>

Typically, such a board would use a standard PCI interface chip
like those made by PLX. This would be connected to a FPGA plus
whatever else was needed to perform the needed functions.

If you attempt to make your own PCI interface using a FPGA,
you are going to devote a lot of time to that, alone. You
probably won't even get to your coprocessor until graduation.

> Which leads me to my questions:
>
> 1) Is their support for having two different 'machine types' within one
> kernel? that is for example, certain executables for intel would get run
> on an intel processor, and others would get run on processor with type XXXX.
>

The support is for whatever driver you provide. For instance,
the Analogic's Sky Computer Division produces array processors
with their own CPUs. The Sky-code runs in those processors.
It doesn't (can't) affect the Intel processor kernel code in
the host.

> I heard once someone put native "java" .class support within the kernel
> (it would call the jvm run time if i remember).  I could maby do this
> with my own set of libraries and driver.  But differentiating between
> the types of executable might be hard.
>

You could certainly make a Java engine run on your coprocessor
board or use Intel code, whatever is better at that instant.
This is done with a library that you provide.

> 2) Is their kernel support for PCI coprocessors for thread allocation
> etc.  I couldn't find any but i can try looking through the code again.
>

Things that go on the PCI bus use drivers (modules) for interface.
The kernel doesn't directly determine what functions are handled
by kernel code and what ones are handled by your PCI interface
coprocessor. Your (or the standard) runtime libraries do this.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

