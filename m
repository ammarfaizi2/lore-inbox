Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVKUTTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVKUTTT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKUTTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:19:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:35460 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750961AbVKUTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:19:19 -0500
Subject: Re: 2.6.14-rt13 does not build
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1132599511.29178.69.camel@mindpipe>
References: <1132599511.29178.69.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 21 Nov 2005 14:19:14 -0500
Message-Id: <1132600755.29178.80.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 13:58 -0500, Lee Revell wrote:
>   CC      kernel/ktimers.o
> kernel/ktimers.c: In function 'enqueue_ktimer':
> kernel/ktimers.c:756: error: incompatible type for argument 1 of
> 'trace_special_u64'
> make[1]: *** [kernel/ktimers.o] Error 1
> make: *** [kernel] Error 2

The problem is specific to !CONFIG_HIGH_RES_TIMERS.  This seems to fix
it (untested):

--- include/linux/ktimer.h~	2005-11-21 13:43:37.000000000 -0500
+++ include/linux/ktimer.h	2005-11-21 14:10:25.000000000 -0500
@@ -167,7 +167,7 @@
 	return 0;
 }
 
-#define ktimer_trace(a,b)		trace_special_u64(a,b)
+#define ktimer_trace(a,b)		trace_special(ktime_get_high(a),ktime_get_low(a),b)
 
 #endif
 

