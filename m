Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289945AbSAPWiW>; Wed, 16 Jan 2002 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290009AbSAPWiM>; Wed, 16 Jan 2002 17:38:12 -0500
Received: from mccammon.ucsd.edu ([132.239.16.211]:52898 "EHLO
	mccammon.ucsd.edu") by vger.kernel.org with ESMTP
	id <S289945AbSAPWiB>; Wed, 16 Jan 2002 17:38:01 -0500
Date: Wed, 16 Jan 2002 14:38:41 -0800 (PST)
From: Alexei Podtelezhnikov <apodtele@mccammon.ucsd.edu>
X-X-Sender: apodtele@chemcca18.ucsd.edu
To: linux-kernel@vger.kernel.org
Subject: [o(1) sched J0] higher priority smaller timeslices, in fact
Message-ID: <Pine.LNX.4.44.0201161412140.3787-100000@chemcca18.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The comment and the actual macros are inconsistent.
positive number * (19-n) is a decreasing function of n!

+ * The higher a process's priority, the bigger timeslices
+ * it gets during one round of execution. But even the lowest
+ * priority process gets MIN_TIMESLICE worth of execution time.
+ */

-#define NICE_TO_TIMESLICE(n)   (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (19 - (n))) / 39)
+#define NICE_TO_TIMESLICE(n) (MIN_TIMESLICE + \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * (19-(n))) / 39)

I still suggest a different set as faster and more readable at least to 
me. Just two operations instead of 4!

#define NICE_TO_TIMESLICE(n) (((n)+21)*(HZ/10))  // should be positive!
#define MAX_TIMESLICE  NICE_TO_TIMESLICE(19)
#define MIN_TIMESLICE  NICE_TO_TIMESLICE(-20)

with later tweaking done in the function, like (((n)+22)*(HZ/25)) instead.

Alexei

