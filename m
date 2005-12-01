Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVLAUW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVLAUW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVLAUW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:22:27 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27817 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932440AbVLAUW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:22:26 -0500
Date: Fri, 2 Dec 2005 02:12:27 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, david singleton <dsingleton@mvista.com>
Subject: Perf degradation from -rt14 onwards
Message-ID: <20051201204227.GA16035@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I was wondering why the following change was made from -rt14
onwards.


@@ -1634,7 +1531,7 @@ asmlinkage long sys_futex(u32 __user *ua
                          int val3)
 {
        struct timespec t;
-       unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+       unsigned long timeout = 0;

This was introduced in patch-2.6.14-rt13-rf3 by David.

This seems to return spurious -ETIMEDOUT errors even in the
non-robust code and results in userspace (glibc) retrying
several mutex operations before it succeeds. I was chasing
down a degradation of performance of some testcases and was
able to fix those by reverting this change back.

	-Dinakar

