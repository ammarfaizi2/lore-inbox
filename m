Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbTCHOHy>; Sat, 8 Mar 2003 09:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262031AbTCHOHy>; Sat, 8 Mar 2003 09:07:54 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17670 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262027AbTCHOHx>; Sat, 8 Mar 2003 09:07:53 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303081420.h28EKHan001241@81-2-122-30.bradfords.org.uk>
Subject: Re: what's an OOPS
To: ludootje@linux.be (Ludootje)
Date: Sat, 8 Mar 2003 14:20:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1047131229.658.236.camel@libranet> from "Ludootje" at Mar 08, 2003 02:47:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been reading LKML for a few weeks now to understand Linux
> development better, and there's one thing I just can't understand:
> what's an OOPS? What does it stand for, what is it?

It's a report of a bug in the kernel, for example, if the kernel tried
to access an invalid memory location.  It doesn't necessarily indicate
a programming error - faulty hardware can cause an OOPS as well.

The following explaination may not be 100% accurate, hopefully
somebody else will post a better one, but here goes:

As far as I know it doesn't stand for anything, and the name is a
kind-of joke, (as in, "oops, we've found a bug in the kernel").

On X86, an OOPS contains information such as:

Text description - something like "Unable to handle NULL pointer
dereference".  This tells you what sort of error it is.

The number of the oops, (I.E. whether it was the first, second, third,
etc, starting with 0000).

The CPU it occured on, (0 on a single processor machine).  Note, I
think that on a multi processor machine, there isn't a physical
relationship between CPU and number, I.E. CPUs are assigned numbers on
boot, in a semi-random fashion.

The contents of the CPU's registers.

A stack backtrace.

The code the CPU was executing.

A call trace, which is, basically, a list of functions that the
process was in at the moment of the OOPS.  The actual numeric values
are almost completely useless[1], because they depend on your
particular kernel.  Only somebody who has access to the corresponding
symbol map for that kernel can identify the actual names of the
functions, and this is why there are often posts by developers on this
list asking people to decode an OOPS they have posted.

[1] Without it being decoded, you can still check, for example,
whether the CPU was executing data, but it's mostly speculation.

John.
