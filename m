Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUGMKSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUGMKSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbUGMKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:18:13 -0400
Received: from holomorphy.com ([207.189.100.168]:20884 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264640AbUGMKSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:18:10 -0400
Date: Tue, 13 Jul 2004 03:14:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       ck@vds.kolivas.org, devenyga@mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Message-ID: <20040713101446.GV21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	ck@vds.kolivas.org, devenyga@mcmaster.ca,
	linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <20040713025502.GR21066@holomorphy.com> <20040712210701.46e2cd40.akpm@osdl.org> <cone.1089696847.507419.12958.502@pc.kolivas.org> <40F377BD.4080201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F377BD.4080201@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:48:45PM +1000, Nick Piggin wrote:
> cond_resched_lock just below this needs something similar.

Maybe it does.

Index: mm7-2.6.7/include/linux/sched.h
===================================================================
--- mm7-2.6.7.orig/include/linux/sched.h	2004-07-13 03:06:12.759495000 -0700
+++ mm7-2.6.7/include/linux/sched.h	2004-07-13 03:14:00.122445032 -0700
@@ -1053,7 +1053,8 @@
 		preempt_enable_no_resched();
 		__cond_resched();
 		spin_lock(lock);
-	}
+	} else
+		touch_preempt_timing();
 }
 
 /* Reevaluate whether the task has signals pending delivery.
