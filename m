Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVHZVRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVHZVRt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHZVRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:17:49 -0400
Received: from mail2.utc.com ([192.249.46.191]:20362 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S965172AbVHZVRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:17:49 -0400
Message-ID: <430F86E7.9020605@cybsft.com>
Date: Fri, 26 Aug 2005 16:17:27 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc7-rt3 compile fix
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000005000609030303040303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000005000609030303040303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

2.6.13-rc7-rt3 won't compile without the simple patch below.

-- 
    kr

--------------000005000609030303040303
Content-Type: text/x-patch;
 name="rtspinfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtspinfix.patch"

--- linux-2.6.13/kernel/rt.c.orig	2005-08-26 15:51:35.000000000 -0500
+++ linux-2.6.13/kernel/rt.c	2005-08-26 15:51:55.000000000 -0500
@@ -672,7 +672,7 @@
 	struct rt_mutex_waiter *w;
 	struct plist *curr1;
 
-	__raw_spin_lock(old_owner->task->pi_lock);
+	__raw_spin_lock(&old_owner->task->pi_lock);
 	TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
 	TRACE_WARN_ON_LOCKED(lock_owner(lock));
 
@@ -683,7 +683,7 @@
 	}
 	TRACE_WARN_ON_LOCKED(1);
 ok:
-	__raw_spin_unlock(old_owner->task->pi_lock);
+	__raw_spin_unlock(&old_owner->task->pi_lock);
 	return;
 }
 

--------------000005000609030303040303--
