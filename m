Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUD2M0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUD2M0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUD2M0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:26:54 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:11993 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264348AbUD2M0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:26:50 -0400
Date: Thu, 29 Apr 2004 14:26:49 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ross Dickson <ross@datscreative.com.au>,
       Jesse Allen <the3dfxdude@hotmail.com>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <20040429120017.GB7077@mail.shareable.org>
Message-ID: <Pine.LNX.4.55.0404291403410.11691@jurand.ds.pg.gda.pl>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
 <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local>
 <200404292144.37479.ross@datscreative.com.au> <Pine.LNX.4.55.0404291352200.11691@jurand.ds.pg.gda.pl>
 <20040429120017.GB7077@mail.shareable.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Jamie Lokier wrote:

> >  Not necessarily related to the PSU, but the noise may actually be the
> > reason of spurious timer interrupts.
> 
> With most device interrupts, additional spurious ones don't cause any
> malfunction because the driver's handler checks whether the device
> actually has a condition pending.

 Note the 8254 timer uses edge-triggered interrupts and is just a square
wave signal.  There's no acking to deassert the interrupt -- it goes away
spontaneously after a predefined time.

> This is the basis of shared interrupts, of course.

 Yep, but the timer is non-shareable by definition.

> Is there any way we can check the timer itself to see whether an
> interrupt was caused by it, so that spurious timer interrupts are ignored?

 This may be possible, but complicated and likely unreliable -- an I/O
APIC may deliver a spurious interrupt at the time a real one would be
probable and you can't check if a period between two consecutive timer
interrupts is appropriate without an additional time reference, which may
be unavailable (like the TSC).

 Note the timer is special -- we don't really do any device handling, but
we want to get periodic interrupts at the right times to have a time
reference.  Coalescing interrupts or discarding spurious ones, which is
normal and acceptable for regular devices, doesn't work here.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
