Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVAGViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVAGViV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVAGVhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:37:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:63703 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261634AbVAGVeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:34:06 -0500
Date: Fri, 7 Jan 2005 13:34:00 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: [UPDATE PATCH] ieee1394/sbp2: use ssleep() instead of schedule_timeout()
Message-ID: <20050107213400.GD2924@us.ibm.com>
References: <20041225004846.GA19373@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225004846.GA19373@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 01:48:46AM +0100, Domen Puncer wrote:
> Hi.
> 
> Santa brought another present :-)
> 
> I'll start mailing new patches these days, and after external trees get
> merged, I'll be bugging you with the old ones.
> 
> 
> Patchset is at http://coderock.org/kj/2.6.10-kj/

<snip>

> all patches:
> ------------

<snip>

> msleep-drivers_ieee1394_sbp2.patch

Please consider updating to the following patch:

Description: Use ssleep() instead of schedule_timeout() to guarantee the task
delays as expected. The existing code should not really need to run in
TASK_INTERRUPTIBLE, as there is no check for signals (or even an early return
value whatsoever). ssleep() takes care of these issues.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.10-v/drivers/ieee1394/sbp2.c	2004-12-24 13:34:00.000000000 -0800
+++ 2.6.10/drivers/ieee1394/sbp2.c	2005-01-05 14:23:05.000000000 -0800
@@ -902,8 +902,7 @@ alloc_fail:
 	 * connected to the sbp2 device being removed. That host would
 	 * have a certain amount of time to relogin before the sbp2 device
 	 * allows someone else to login instead. One second makes sense. */
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(HZ);
+	ssleep(1);
 
 	/*
 	 * Login to the sbp-2 device
