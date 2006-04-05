Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDECBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDECBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWDECBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:01:49 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:33666 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751076AbWDECBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:01:49 -0400
Subject: 2.6.16-rt12: enqueue_hrtimer arguments?
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Tue, 04 Apr 2006 19:01:38 -0700
Message-Id: <1144202498.5255.97.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this chunk has an extra argument to enqueue_hrtimer... I
erased the HRTIMER_INACTIVE it and I'm trying again to compile...

@@ -798,9 +1130,9 @@ static void migrate_hrtimer_list(struct 
 
 	while ((node = rb_first(&old_base->active))) {
 		timer = rb_entry(node, struct hrtimer, node);
-		__remove_hrtimer(timer, old_base);
+		__remove_hrtimer(timer, old_base, HRTIMER_INACTIVE);
 		timer->base = new_base;
-		enqueue_hrtimer(timer, new_base);
+		enqueue_hrtimer(timer, new_base, HRTIMER_INACTIVE);
 	}
 }
 
-- Fernando


