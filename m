Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVAJXWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVAJXWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVAJXTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:19:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:44968 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262745AbVAJXMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:12:17 -0500
Date: Mon, 10 Jan 2005 15:12:06 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] message/mptbase: replace schedule_timeout() with ssleep()
Message-ID: <20050110231206.GI9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip> 

> msleep_interruptible-drivers_message_fusion_mptbase.patch

Please consider replacing with the following patch:

Description: Use ssleep() instead of schedule_timeout() to guarantee
the task delays as expected. The original code does use TASK_INTERRUPTIBLE, but
does not check for signals or early return from schedule_timeout() so ssleep()
seems more appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/message/fusion/mptbase.c	2004-12-24 13:35:50.000000000 -0800
+++ 2.6.10/drivers/message/fusion/mptbase.c	2005-01-05 14:23:05.000000000 -0800
@@ -3137,8 +3137,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 				/* wait 1 sec */
 				if (sleepFlag == CAN_SLEEP) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(1000 * HZ / 1000);
+					ssleep(1);
 				} else {
 					mdelay (1000);
 				}
