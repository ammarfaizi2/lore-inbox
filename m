Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWJBSin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWJBSin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWJBSin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:38:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:7564 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964834AbWJBSil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:38:41 -0400
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
	 <1159796582.1386.9.camel@localhost.localdomain>
	 <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 11:38:36 -0700
Message-Id: <1159814317.5873.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 14:25 -0400, Valdis.Kletnieks@vt.edu wrote:
> (Sorry for the size of the note, there's some 50K of logs attached)
>
> On Mon, 02 Oct 2006 15:43:02 +0200, Thomas Gleixner said:
> > Can you please send me the bootlog and further dmesg output (especially
> > when related to timers / cpufreq).
> 
> I booted the box to single-user both times, and then started cpuspeed.
> I then did a cat of /proc/interrupts, /proc/uptime, and a date command,
> waited 60 seconds according to my watch, and repeated.  I then dumped
> the dmesg.  The -dyntick kernel moved 'uptime' almost exactly 45 seconds
> (almost certainly a by-product of running at 1.2Ghz rather than 1.6Ghz).
> Does the dyntick code make any unwritten assumptions about a jiffie or
> bogomips remaining constant?
> 
> Attached - config diff, date and /proc dumps from both -mm2 and -mm2-dyntick,
> and the dmesg's from both boots.
> 
> Yell if you have any other questions/suggestions/etc..

Hmmm. So w/ -mm2 we're seeing the TSC get detected as running too slowly
(and its replaced w/ the ACPI PM), but for some reason that doesn't
happen w/ the dynticks patch.

Now, how is cpuspeed changing the cpufreq? Is it using the /sys
interface? I've got hooks in so when the cpufreq changes we should mark
it unstable and fall back to ACPI PM, but maybe I missed whatever hook
cpuspeed is using.

thanks
-john

