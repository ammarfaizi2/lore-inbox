Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWANQPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWANQPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWANQPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:15:51 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:37774 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751060AbWANQPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:15:51 -0500
Date: Sat, 14 Jan 2006 11:10:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Fall back io scheduler for 2.6.15?
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
Message-ID: <200601141113_MC3-1-B5DA-F6EC@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060113174914.7907bf2c.akpm@osdl.org>

On Fri, 13 Jan 2006, Andrew Morton wrote:

> OK.  And I assume that AS wasn't compiled, so that's why it fell back?

As of 2.6.15 you need to use "anticipatory" instead of "as".

Maybe this patch would help?

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.15a.orig/block/elevator.c
+++ 2.6.15a/block/elevator.c
@@ -150,6 +150,13 @@ static void elevator_setup_default(void)
 	if (!chosen_elevator[0])
 		strcpy(chosen_elevator, CONFIG_DEFAULT_IOSCHED);
 
+	/*
+	 * Be backwards-compatible with previous kernels, so users
+	 * won't get the wrong elevator.
+	 */
+	if (!strcmp(chosen_elevator, "as"))
+		strcpy(chosen_elevator, "anticipatory");
+
  	/*
  	 * If the given scheduler is not available, fall back to no-op.
  	 */
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
