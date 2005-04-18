Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVDROLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVDROLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVDROLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 10:11:16 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:4053 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262078AbVDROLB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 10:11:01 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc2-mm3
From: Alexander Nyberg <alexn@dsv.su.se>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk
In-Reply-To: <1113822898.6274.41.camel@laptopd505.fenrus.org>
References: <200504172339.j3HNdIDF011543@harpo.it.uu.se>
	 <1113822345.365.14.camel@localhost.localdomain>
	 <1113822898.6274.41.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 18 Apr 2005 16:10:50 +0200
Message-Id: <1113833450.365.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mån 2005-04-18 klockan 13:14 +0200 skrev Arjan van de Ven:
> On Mon, 2005-04-18 at 13:05 +0200, Alexander Nyberg wrote:
> > [Proper patch now that goes all the way, sorry for spamming]
> > 
> > Patch below uses RETIRED_UOPS for a more constant rate of NMI sending.
> > This makes x64 deliver NMI interrupts every fourth second at a constant
> > rate when going through the local apic. Makes both cpus on my box to get
> > NMIs at constant rate that it previously did not, there could be long
> > delays when a CPU was idle.
> 
> 
> isn't this dangerous in the light of the mobile cpus that either scale
> back or stop entirely in idle or lower load situations ?
> 

I don't see any real problem, at each nmi_watchdog_tick() the next NMI
is calculated accounting cpu_khz so the NMIs might not come at a
constant rate while frequency scaling, but over time there will still be
one every fourth second.

And if stop entirely as you say, are there even any uops run? And even
if so the watchdog that is now currently would also have a few events
accounted on it and could fire NMI aswell.

