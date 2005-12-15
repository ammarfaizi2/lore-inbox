Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbVLOEel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVLOEel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161042AbVLOEek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:34:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52933 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161039AbVLOEej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:34:39 -0500
Subject: [PATCH 000/003] Remove getnstimestamp()
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       George Anzinger <george@mvista.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 20:29:46 -0800
Message-Id: <1134620987.7372.35.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This series removes the getnstimestamp() function from kernel/time.c in
favor of kernel/hrtimer.c's ktime_get_ts() function which currently does
exactly the same thing: retrieves a high-resolution (ns) timespec
structure and performs the wall_to_monotonic adjustment.

	As Jay Lan suggested I was going to replace calls to getnstimestamp()
with do_posix_clock_monotonic_gettime() but the hrtimer patches switched
that to a macro. ktime_get_ts() is shorter and avoids unnecessary
association with posix timers (though it does not emphasize monotonicity
or resolution).

The series:

001/003 export-ktime_get_ts.patch
	Exports ktime_get_ts()

002/003 proc-events-use-ktime-for-timestamp.patch
	Switches the only user of getnstimestamp() to ktime_get_ts()

003/003 rm-getnstimestamp.patch
	Remove getnstimestamp() from kernel/time.c


Thanks,
	-Matt Helsley


