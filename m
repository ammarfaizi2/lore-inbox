Return-Path: <linux-kernel-owner+willy=40w.ods.org-S276755AbUKATSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276755AbUKATSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276750AbUKATSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:18:31 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42990 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269030AbUKATHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:07:51 -0500
Date: Mon, 1 Nov 2004 12:07:49 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: janitor@sternwelten.at
Cc: netdev@oss.sgi.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [PATCH] Add ssleep_interruptible()
Message-ID: <20041101200749.GF1730@us.ibm.com>
References: <E1CO1vc-00022t-N2@sputnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <E1CO1vc-00022t-N2@sputnik>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Adds ssleep_interruptible() to allow longer delays to occur
in TASK_INTERRUPTIBLE, similarly to ssleep(). To be consistent with
msleep_interruptible(), ssleep_interruptible() returns the remaining time
left in the delay in terms of seconds. This required dividing the return
value of msleep_interruptible() by 1000, thus a cast to (unsigned long)
to prevent any floating point issues.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.10-rc1-vanilla/include/linux/delay.h	2004-10-30 15:34:03.000000000 -0700
+++ 2.6.10-rc1/include/linux/delay.h	2004-11-01 12:06:11.000000000 -0800
@@ -46,4 +46,9 @@ static inline void ssleep(unsigned int s
 	msleep(seconds * 1000);
 }
 
+static inline unsigned long ssleep_interruptible(unsigned int seconds)
+{
+	return (unsigned long)(msleep_interruptible(seconds * 1000) / 1000);
+}
+
 #endif /* defined(_LINUX_DELAY_H) */
