Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLLTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTLLTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:46:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261872AbTLLTq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:46:56 -0500
Date: Fri, 12 Dec 2003 14:47:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
In-Reply-To: <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0312121435570.1356@chaos>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se>
 <Pine.LNX.4.53.0312121000150.10423@chaos> <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, John Bradford wrote:

> Quote from "Richard B. Johnson" <root@chaos.analogic.com>:
> > On Fri, 12 Dec 2003, [iso-8859-1] M=E5ns Rullg=E5rd wrote:
> >
> > > Dale Mellor <dale@dmellor.dabsol.co.uk> writes:
> > >
> > > > 1. Floppy motor spins when floppy module not installed.
> > >
> > > It's a known problem.  Some broken BIOSes don't turn off the motor
> > > after probing for a disk.  One solution is to change the boot priorit=
> > y
> > > in the BIOS settings so the hard disk is tried before floppy.  If you
> > > ever need to boot from a floppy, you can change it back.
> > >
> > > --
> > > M=E5ns Rullg=E5rd
> > > mru@kth.se
> >
> > It is not a broken BIOS! The BIOS timer that ticks 18.206 times
> > per second has an ISR that, in addition to keeping time, turns
> > OFF the FDC motor after two seconds of inactivity. This ISR is taken
> > away by Linux. Therefore Linux must turn off that motor! It is a
> > Linux bug, not a BIOS bug. Linux took control away from the BIOS
> > during boot.
>
> We discussed almost exactly the same problem at length on LKML just
> two months ago:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106545766213063&w=2
>
> John.

Yes, and I recall we agreed to disagree where the FDC stop must
be put, but we both agreed that it must be stopped. I still contend
that since the Linux startup code takes control away from the BIOS,
it's that codes responsibility to turn OFF things that the BIOS
might have left ON.

Funny thing. It's so trivial, anybody/everybody could turn the
floppy motor off, but all the fingers point to somebody else's
code.

It's a bug in Linux, not in a boot-loader. That bug was covered up
until the FDC code got modularized. Once we were able to compile
a kernel without the FDC, the bug was exposed. So, I suggest that
we just fix the bug and be done with it. It's not a performance
problem, the write to the port occurs exactly once during the nest
999 days of up-time. It's just an attempt to make a mountain out
of a mole-hill.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


