Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUIXGXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUIXGXp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUIXGXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:23:44 -0400
Received: from science.horizon.com ([192.35.100.1]:1595 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S268214AbUIXGTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:19:45 -0400
Date: 24 Sep 2004 06:19:39 -0000
Message-ID: <20040924061939.5367.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@certainkey.com
Subject: Re: [PROPOSAL/PATCH] Fortuna PRNG in /dev/random
Cc: cryptoapi@lists.logix.cz, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       tytso@mit.edu
In-Reply-To: <20040924023413.GH28317@certainkey.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, you write:
> It is regarded in crypto circles as the current state-of-the-art
> in cryptographically secure PRNGs.

The question this brings to mind is:
It is?  Can you point me to a single third-party paper on the subject?

There's nothing in the IACR preprint archive.  Nor citeseer,


The big difference between when /dev/random was designed and today:

- USB is a broadcast bus, and a lot (timing, at least) can be sniffed
  by a small dongle.  Wireless keyboards and mice are popular.  That
  sort of user data probably shouldn't be trusted any more.  (No harm
  mixing it in, just in case it is good, but accord it zero weight.)
- Clock speeds are a *lot* higher (> 1 GHz) and the timestamp counter is
  almost universally available.  Even an attacker with multiple antennas
  pointed at the computer is going to have a hard time figuring out on which
  tick of the clock an interrupt arrived even if they can see it.

Thus, the least-significant bits of the TSC are useful entropy on *every*
interrupt, timer included.


For a fun exercise, install a kernel hack to capture the TSC on every
timer interrupt.  Run it for a while on an idle system (processor in the
halt state, waiting for interrupts on a cycle-by-cycle basis).

Take the resultant points, subtract the best-fit line, and throw out any
outliers caused by delayed interrupts.

Now do some statistical analysis of the residue.  How much entropy do
you have from the timer interrupt?  Does it look random?  How many lsbits
can you take and still pass Marsaglia's DIEHARD suite?  Do any patterns
show up in an FFT?
