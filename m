Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTIOGTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTIOGTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:19:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:31872 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262456AbTIOGTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:19:08 -0400
Date: Mon, 15 Sep 2003 07:32:49 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309150632.h8F6WnHb000589@81-2-122-30.bradfords.org.uk>
To: davidsen@tmr.com, zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We just got a start on making Linux smaller to encourage embedded use, I
> > don't see adding 300+ bytes of wasted code so people can run
> > misconfigured kernels.
> > 
> > I rather have to patch this in for my Athlon kernels than have people
> > who aren't cutting corners trying to avoid building matching kernels
> > have to live with the overhead.
>
> Overhead? Really you could save more memory by cleaning up a lot of 
> drivers. Andi already said it before, there are better places to be 
> looking at.

That's a non-issue.  300 bytes matters a lot on some systems.  The
fact that there are drivers that are bloated is nothing to do with
it.

> Also 'patching' for Athlon kernels doesn't cut it for people who need to 
> distribute kernels which run on various hardware (such as distros). This 
> alone is benefit enough to justify this supposed 'bloat'.

No it's not.  Most distributions heavily patch the kernel anyway.

It should be possible, and straightforward, to compile a kernel which:

1. Supports, (I.E. has workarounds for), any combination of CPUs.
   E.G. a kernel which supports 386s, and Athlons _only_ would not
   need the F00F bug workaround.  Currently '386' kernels include it,
   because '386' means 'support 386 and above processors'.

2. Has compiler optimisations for one particular CPU.
   E.G. the 386 and Athlon supporting kernel above could have
   alignment optimised for either 386 or Athlon.

This makes it trivial to:

* Make a kernel for a distribution's initial install
  Select all CPUs as supported, and optimise for 686.

* Make an optimised kernel for any system
  Select only the target CPU as supported, and optimise for it

* Make a generic kernel for PIV, and Athlon
  Select PIV and Athlon only as supported.  Optimise for either, or
  optimise for 386, (yes, even though it is not supported), for a
  small kernel, on the basis that it will maximise cache usage, and be
  fairly optimal on both systems.

John.
