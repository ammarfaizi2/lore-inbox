Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWCCQb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCCQb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 11:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCCQb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 11:31:59 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:39379 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932241AbWCCQb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 11:31:58 -0500
Date: Sat, 04 Mar 2006 01:31:53 +0900 (JST)
Message-Id: <20060304.013153.71086081.anemo@mba.ocn.ne.jp>
To: akpm@osdl.org
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       johnstul@us.ibm.com, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm> I'm not sure how to resolve this, really.  Worried.  Have you
akpm> socialised those changes with architecture maintainers?  If so,
akpm> what was the feedback?

For a short term fix, barrier() might be a safe option.


Add an optimization barrier to prevent prefetching jiffies before
incrementing jiffies_64.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/kernel/timer.c b/kernel/timer.c
index fc6646f..fdd12a5 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -925,6 +925,7 @@ static inline void update_times(void)
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
+	barrier();
 	update_times();
 	softlockup_tick(regs);
 }
