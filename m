Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWCAQNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWCAQNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWCAQNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:13:11 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:60142 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750711AbWCAQNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:13:10 -0500
Date: Thu, 02 Mar 2006 01:13:04 +0900 (JST)
Message-Id: <20060302.011304.75185944.anemo@mba.ocn.ne.jp>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: jiffies_64 vs. jiffies
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4405B700.1080607@yahoo.com.au>
References: <44059915.3010800@yahoo.com.au>
	<20060301.235750.25910018.anemo@mba.ocn.ne.jp>
	<4405B700.1080607@yahoo.com.au>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 02 Mar 2006 02:00:16 +1100, Nick Piggin <nickpiggin@yahoo.com.au> said:

>> Well, do you mean it should be like this ?
>> 
>> jiffies_64++;
>> update_times(jiffies_64);

nick> Yeah. It makes your patch a line smaller too!

Another solution might be simplifying update_times() like this.  It
looks there is no point to calculate ticks in update_times().

diff --git a/kernel/timer.c b/kernel/timer.c
index fe3a9a9..6188c99 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -906,14 +906,9 @@ void run_local_timers(void)
  */
 static inline void update_times(void)
 {
-	unsigned long ticks;
-
-	ticks = jiffies - wall_jiffies;
-	if (ticks) {
-		wall_jiffies += ticks;
-		update_wall_time(ticks);
-	}
-	calc_load(ticks);
+	wall_jiffies++;
+	update_wall_time(1);
+	calc_load(1);
 }
   
 /*


As for long term solution, using an union for jiffies and jiffies_64
would be robust.  But it affects so many codes ...

---
Atsushi Nemoto
