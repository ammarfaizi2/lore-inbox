Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTIJQ7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTIJQ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:59:30 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19084 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S265253AbTIJQ7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:59:02 -0400
Date: Wed, 10 Sep 2003 18:58:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: PROBLEM: APIC on a Pentium Classic SMP, 2.4.21-pre2 and 2.4.21-pre3 ksymoops
In-Reply-To: <16223.20183.242571.608500@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.3.96.1030910185546.12084B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Mikael Pettersson wrote:

> First I found one very strange thing in Mathieu's boot log:
> 
> --- mpbug-2.4.20	Wed Sep 10 17:19:05 2003
> +++ mpbug-2.4.23-pre3	Wed Sep 10 17:18:44 2003
> ...
> +DMI not present.
>  Intel MultiProcessor Specification v1.1
>  Virtual Wire compatibility mode.
>  Default MP configuration #6
> 
> This means construct_default_ISA_mptable() still gets called.
> Ok so far.

 Yep -- I've been aware of this.

> At this point I was thinking "memory corruption",
> and the following struck me:
> 
> What used to be arrays (mp_irqs[] etc) are now pointers to
> memory which is sized and allocated by smp_read_mpc().
> In the case when construct_default_ISA_mptable() is called,
> smp_read_mpc() is _not_ called, the pointers never get initialised,
> and reads and writes of these arrays end up in la-la land.

 Exactly.

> The fix would be to add allocation and initialisation of
> these pointers at the start of construct_default_ISA_mptable().

 Possibly -- I haven't thought on how to fix it yet.

> I'll prepare a patch doing this sometime tomorrow.

 Thanks a lot for taking care.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

