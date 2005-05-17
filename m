Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVEQXkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVEQXkU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEQXjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:39:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:30616 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262021AbVEQXig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:38:36 -0400
Date: Tue, 17 May 2005 16:38:32 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: [RFC][PATCH 4/4] support new soft-timer subsystem on non-NEWTOD archs
Message-ID: <20050517233832.GI2735@us.ibm.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com> <20050517233300.GE2735@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517233300.GE2735@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc4 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2005 [16:33:00 -0700], Nishanth Aravamudan wrote:
> On 13.05.2005 [17:16:35 -0700], john stultz wrote:
> > All,
> > 	This patch implements the architecture independent portion of the new
> > time of day subsystem. For a brief description on the rework, see here:
> > http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
> > easy to understand writeup!)
> > 
> > 	I intend this to be the last RFC release and to submit this patch to
> > Andrew for for testing near the end of this month. So please, if you
> > have any complaints, suggestions, or blocking issues, let me know.
> 
> I have been working closely with John to re-work the soft-timer subsytem
> to use the new timeofday() subsystem. The following patches attempts to
> begin this process. I would greatly appreciate any comments.

Description: Support the new soft-timer interfaces on non-NEWTOD archs
by emulating nanoseconds via jiffies.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.12-rc4-tod/include/linux/timeofday.h	2005-05-17 13:01:12.000000000 -0700
+++ 2.6.12-rc4-tod-timer/include/linux/timeofday.h	2005-05-17 13:02:01.000000000 -0700
@@ -55,5 +55,14 @@ static inline nsec_t timeval_to_ns(struc
 }
 #else /* CONFIG_NEWTOD */
 #define timeofday_init()
+/*
+ * do_monotonic_clock():
+ *    Emulate the monotonically increasing number of nanoseconds
+ *    of NEWTOD archs via jiffies.
+ */
+nsec_t do_monotonic_clock(void)
+{
+	return jiffies_to_nsecs(jiffies);
+}
 #endif /* CONFIG_NEWTOD */
 #endif /* _LINUX_TIMEOFDAY_H */
