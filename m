Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbTIJK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbTIJK0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:26:24 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:62336 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261643AbTIJK0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:26:23 -0400
Date: Wed, 10 Sep 2003 12:26:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, 2.4.21-pre2 and 2.4.21-pre3 ksymoops
In-Reply-To: <200309092031.h89KVWIA027982@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1030910121939.5295A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Mikael Pettersson wrote:

> Ok, that one is line 295 in io_apic.c. It bombs in 2.4.21-pre{2,3}
> because mp_bus_id_to_pci_bus was changed from a static array to
> a dynamically allocated array. On your machine, smp_read_mpc() in
> mpparse.c doesn't get to the point where it allocates that array,
> so the array is NULL in io_apic.c and you get an oops.

 As I have already written, the system uses a default MP configuration.
smp_read_mpc() isn't called at all.  construct_default_ISA_mptable() is
used instead.

> Fixing the oops is easy (see below), but the real problem is
> that 2.4.21-pre2 apparently broke MP table parsing on your HW.
> I suggest you sprinkle tracing printk()s in setup/smpboot/mpparse
> and compare 2.4.20 (good) and later (bad) to see where things
> start to diverge.

 There is no need to -- the problem is already known.  Mikael, if you need
additional details on how default MP configurations work in our code, feel
free to ask.  Unfortunately, I won't likely be able to do any coding
and/or testing in this area before October.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

