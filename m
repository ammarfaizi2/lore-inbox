Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWCNVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWCNVBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCNVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:01:35 -0500
Received: from fmr20.intel.com ([134.134.136.19]:27826 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932371AbWCNVBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:01:34 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: [PATCH] provide hrtimer exports for module use [Was: Exports for hrtimer APIs]
Date: Tue, 14 Mar 2006 13:01:25 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A13@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] provide hrtimer exports for module use [Was: Exports for hrtimer APIs]
Thread-Index: AcZHNFRaHv2I3pnxRoqOQZ+7P7ycJQAdJEvQ
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2006 21:01:26.0562 (UTC) FILETIME=[755C1820:01C647AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Stone, Joshua I" <joshua.i.stone@intel.com> wrote:
>> I have noticed that the hrtimer APIs in 2.6.16 RCs are not exported,
>> and therefore modules are unable to use hrtimers.  I have not seen
>> any discussion on this point, so I presume that this is either an
>> oversight, or there has not been any case presented for exporting
>> hrtimers. 
>> 
>> I would like to add hrtimer support to SystemTap, which by design
>> requires the use of dynamically loaded kernel modules.  Can the
>> appropriate exports for hrtimers please be added?
> 
> Please send a patch, so we can see what's needed.
> 
> EXPORT_SYMBOL_GPL would be preferred.

This patch adds the exports needed for modules to use the
hrtimer APIs.

Signed-off-by: Josh Stone <joshua.i.stone@intel.com>

--- linux-2.6.16-rc6/kernel/hrtimer.c	2006-03-14 10:44:13.000000000
-0800
+++ linux-2.6.16-rc6-hrtexp/kernel/hrtimer.c	2006-03-14
11:13:48.000000000 -0800
@@ -238,6 +238,7 @@ ktime_t ktime_add_ns(const ktime_t kt, u
 
 	return ktime_add(kt, tmp);
 }
+EXPORT_SYMBOL_GPL(ktime_add_ns);
 
 #else /* CONFIG_KTIME_SCALAR */
 
@@ -319,6 +320,7 @@ hrtimer_forward(struct hrtimer *timer, k
 
 	return orun;
 }
+EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 /*
  * enqueue_hrtimer - internal function to (re)start a timer
@@ -439,6 +441,7 @@ hrtimer_start(struct hrtimer *timer, kti
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(hrtimer_start);
 
 /**
  * hrtimer_try_to_cancel - try to deactivate a timer
@@ -467,6 +470,7 @@ int hrtimer_try_to_cancel(struct hrtimer
 	return ret;
 
 }
+EXPORT_SYMBOL_GPL(hrtimer_try_to_cancel);
 
 /**
  * hrtimer_cancel - cancel a timer and wait for the handler to finish.
@@ -486,6 +490,7 @@ int hrtimer_cancel(struct hrtimer *timer
 			return ret;
 	}
 }
+EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
  * hrtimer_get_remaining - get remaining time for the timer
@@ -504,6 +509,7 @@ ktime_t hrtimer_get_remaining(const stru
 
 	return rem;
 }
+EXPORT_SYMBOL_GPL(hrtimer_get_remaining);
 
 #ifdef CONFIG_NO_IDLE_HZ
 /**
@@ -538,6 +544,7 @@ ktime_t hrtimer_get_next_event(void)
 		mindelta.tv64 = 0;
 	return mindelta;
 }
+EXPORT_SYMBOL_GPL(hrtimer_get_next_event);
 #endif
 
 /**
@@ -561,6 +568,7 @@ void hrtimer_init(struct hrtimer *timer,
 
 	timer->base = &bases[clock_id];
 }
+EXPORT_SYMBOL_GPL(hrtimer_init);
 
 /**
  * hrtimer_get_res - get the timer resolution for a clock
@@ -580,6 +588,7 @@ int hrtimer_get_res(const clockid_t whic
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hrtimer_get_res);
 
 /*
  * Expire the per base hrtimer-queue:
@@ -761,6 +770,7 @@ long hrtimer_nanosleep(struct timespec *
 
 	return -ERESTART_RESTARTBLOCK;
 }
+EXPORT_SYMBOL_GPL(hrtimer_nanosleep);
 
 asmlinkage long
 sys_nanosleep(struct timespec __user *rqtp, struct timespec __user
*rmtp)
