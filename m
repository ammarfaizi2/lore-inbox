Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbVLOEhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVLOEhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbVLOEhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:37:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:45742 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161043AbVLOEhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:37:13 -0500
Subject: [PATCH 001/003] Export ktime_get_ts()
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: john stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       George Anzinger <george@mvista.com>
In-Reply-To: <1134620987.7372.35.camel@stark>
References: <1134620987.7372.35.camel@stark>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 20:32:20 -0800
Message-Id: <1134621140.7372.37.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export ktime_get_ts() to be used as a timestamp function since it
uses getnstimefoday() and does the wall_to_monotonic adjustment.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.15-rc5-mm1/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/hrtimer.c
+++ linux-2.6.15-rc5-mm1/kernel/hrtimer.c
@@ -106,10 +106,11 @@ void ktime_get_ts(struct timespec *ts)
 	} while (read_seqretry(&xtime_lock, seq));
 
 	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
 				ts->tv_nsec + tomono.tv_nsec);
 }
+EXPORT_SYMBOL_GPL(ktime_get_ts);
 
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
  */


