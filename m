Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311171AbSCSNM5>; Tue, 19 Mar 2002 08:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311176AbSCSNMs>; Tue, 19 Mar 2002 08:12:48 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29349 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311171AbSCSNMd>; Tue, 19 Mar 2002 08:12:33 -0500
Date: Tue, 19 Mar 2002 14:11:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203132006310.28859-100000@localhost.localdomain>
Message-ID: <Pine.GSO.3.96.1020319134554.12399F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Ingo Molnar wrote:

> i've written a patch for this, it's enclosed in this email. It implements
> a brownean motion of IRQs, based on load patterns. The concept works
> really well on Foster CPUs - eg. it will redirect IRQs to idle CPUs - but
> if all CPUs are idle then the IRQs are randomly and evenly distributed
> between CPUs.

 A nice idea.  One note though -- the code depends on the TSC to be
present.  It would be better to use:

if (cpu_has_tsc)
	rdtscll(random_number);

and either preset random_number to a fixed value or even leave it
uninitialized to have it somewhat randomly set by what was found at the
stack for the TSC-less case. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

