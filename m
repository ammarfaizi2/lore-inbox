Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTIDQdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTIDQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:33:07 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:37001 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265284AbTIDQc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:32:56 -0400
Date: Thu, 4 Sep 2003 18:32:45 +0200 (MEST)
From: peter_daum@t-online.de (Peter Daum)
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.4.22 with CONFIG_M686: networking broken
In-Reply-To: <200309041120.57233.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.30.0309041809001.15286-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Seen: false
X-ID: JOzp8yZXgeMIQKnOVQTKqwAepzCR+R94p9nnfyfcgw2O-95PNbxSQf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

... the APIC settings don't have any effect on that issue.

I had the suspicion, that the compiler version might be a factor,
but this also turned out to be wrong (I tried gcc 2.95.2, 2.95.3,
3.2 and 3.3), but I eventually found out, that the differences I
observed were only a matter of which processor the machine that
the kernel runs on actually has:

- With "CONFIG_M686" or "CONFIG_M586TSC", the problems occur on
  all machines, no matter which compiler or processor

- "CONFIG_M386"-kernels work, but only on a machine with Pentium4 (?!)
   On Pentium Pro or Pentium II, it seems to cause the same
   problems as "CONFIG_M686"

- The only setting that does not cause any obvious problems (and
  seems to work even on Pentium Pro machines - do I have to
  expect more trouble there?)

(As a side note: all the computers I am talking about use ATM/LANE for
network connectivity, but at least to me this does not look like an ATM-
related problem)

On Thu, 4 Sep 2003, Bartlomiej Zolnierkiewicz wrote:
> AFAIR local APIC is enabled by default for CONFIG_M686
> and it is not for CONFIG_MPENTIUM4.
[...]
> On Wednesday 03 of September 2003 13:08, Peter Daum wrote:
> > Hi,
> >
> > It seems, like kernel version 2.4.22 introduced some weird bug,
> > that causes all kinds of network malfunctions, when the kernel is
> > compiled with "CONFIG_M686".
> >
> > I am sorry, that I can't come up with a clearer error
> > description, but the whole issue is pretty mysterious: there is
> > no actual error occurring, but some networking functionality is so
> > slow that it's for all practical purposes useless. The best test
> > cases I could find are:
> >
> > - getting a file via ftp (e.g. wget ftp://...): Data rate over a
> >   normally fast network connection is ~ 200 bytes /second, the
> >   connection soon dies with a timeout
> >
> > - writing to a SMB share (provided, that samba is running on the
> >   machine) is awfully slow and eventually aborted (Windows
> >   complains about "network congestion")
> >   reading via SMB works as usual ...
> >
> > I upgraded the kernel on a bunch of machines - on most of them, I
> > had to immediately go back to the previous kernel because there
> > were obvious problems; some machines, however, worked perfectly
> > normal with the new kernel.
> >
> > I tried lots of different options until I eventually found out,
> > that the single setting that makes all the difference is the
> > processor type: Independently of any other settings, all kernels
> > with "CONFIG_M686" exhibit these problems; when I change this to
> > "CONFIG_MPENTIUM4" and recompile, everything seems to work.
> >
> > (By the way: the affected machines have "Pentium Pro" or "Pentium
> > II" processors - is it safe to run a kernel compiled for "Pentium
> > IV" on such boxes?)
> >
> > Regards,
> >                  Peter Daum
>

