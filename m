Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423510AbWKIBNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423510AbWKIBNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 20:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423985AbWKIBNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 20:13:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6091 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423510AbWKIBNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 20:13:34 -0500
Subject: Re: AMD X2 unsynced TSC fix?
From: john stultz <johnstul@us.ibm.com>
To: sergio@sergiomb.no-ip.org
Cc: tglx@linutronix.de, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1163032780.19484.4.camel@monteirov>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
	 <1162345608.2961.7.camel@localhost.portugal>
	 <20061031184411.E3790@unix-os.sc.intel.com>
	 <1162945339.4455.12.camel@monteirov>
	 <1163015628.8335.52.camel@localhost.localdomain>
	 <1163032780.19484.4.camel@monteirov>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 17:13:24 -0800
Message-Id: <1163034804.25019.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 00:39 +0000, Sergio Monteiro Basto wrote:
> On Wed, 2006-11-08 at 20:53 +0100, Thomas Gleixner wrote:
> > This one is a lock dependency problem, which is fixed in -rc5-mm1
> 
> yes, oops fixed w/ and w/o notsc option.
> Other question, hrtimer in 2.6.18 found acpi_pm clocksource and use it.
> With 2.6.19-rcx can't get acpi_pm clocksource even trying force at boot
> kernel with clocksource=acpi_pm, any idea ?
> because with this clocksource my lost ticket disappears 

Looking at the dmesg in the bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=6419

I noticed you're using x86_64. x86_64 doesn't yet support clocksource
overrides in mainline, as it is not converted to GENERIC_TIME. (Probably
printing out such a warning if an override is used would be nice. I'll
try to get to that soon.)

Now, the code to convert x86_64 is in tglx's hrtimer patch set, so I'm
glad to hear its working for you, however I'm not sure if it really is
solving the issue or just hiding it (as lost ticks won't affect
timekeeping when you use continuous clocksources and GENERIC_TIME).

To use the ACPI PM w/ a 2.6.19-rcX kernel, use "notsc", and you'll see
the line:
 time.c: Using 3.579545 MHz WALL PM GTOD PM timer.

Using the "notsc" option, do you continue to see lost tick messages
after bootup?

thanks
-john


