Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLLGKx>; Tue, 12 Dec 2000 01:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLLGKn>; Tue, 12 Dec 2000 01:10:43 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:36619 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129319AbQLLGKd>; Tue, 12 Dec 2000 01:10:33 -0500
Date: Mon, 11 Dec 2000 23:39:56 -0600
To: Android <android@abac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18 release notes
Message-ID: <20001211233956.F3199@cadcamlab.org>
In-Reply-To: <E145f1E-0000a9-00@the-village.bc.nu> <00121121242201.00885@cy60022-a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00121121242201.00885@cy60022-a>; from android@abac.com on Mon, Dec 11, 2000 at 09:24:22PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [AC]
> >           ... added basic support for the Pentium IV.
[Android]
> How is the Pentium IV more advanced than the Pentium III, other than
> speed?  Why would LInux care about a 1500 MHz clock or 400 MHz bus
> speed?  Just treat the PIV as a faster PIII.

It all sounds so simple, right?  Several small things to worry about:

- CPU identification and categorization.  The P4 reports itself as CPU
  family 15 rather than family 6 like PPro, PII and PIII.  Thus, Linux
  code that tests for certain features by saying if(cpufamily==6)
  didn't notice that the P4 would work.  Also there was at least one
  format string like sprintf(buf, "i%d86", cpufamily) which is supposed
  to print "i686" but on the P4 would print "i1586"....

- metrics -- L1 cacheline size is the important one: you align array
  elements to this size when you want a per-cpu array, so that multiple
  CPUs do not share a cacheline for accessing their "own" structure.
  Proper alignment avoids "cacheline ping-pong", as it's called,
  whenever two CPUs need to access "their" element of the same array at
  the same time.

- as to the MHz -- there was a wraparound bug if your CPU is faster
  than 2 GHz (highest signed 32-bit int), which isn't a problem today
  but will be tomorrow.

- Tigran's microcode driver -- some small changes were made so that it
  could be used for P4's.

- maybe they'll need to patch lm_sensors to accommodate the increased
  temperature range since the P4 runs so hot. (: (:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
