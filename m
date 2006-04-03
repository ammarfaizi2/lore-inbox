Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWDCSAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWDCSAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWDCSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:00:50 -0400
Received: from users.ccur.com ([66.10.65.2]:61144 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S964824AbWDCSAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:00:49 -0400
Date: Mon, 3 Apr 2006 14:00:37 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add cpu_relax to hrtimer_cancel
Message-ID: <20060403180037.GA21038@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a cpu_relax() to the hand-coded spinwait in hrtimer_cancel().

Signed-off-by: Joe Korty <joe.korty@ccur.com>


 2.6.17-rc1-jak/kernel/hrtimer.c |    1 +
 1 file changed, 1 insertion(+)

diff -puNa kernel/hrtimer.c~add.cpu_relax.to.hrtimer_cancel kernel/hrtimer.c
--- 2.6.17-rc1/kernel/hrtimer.c~add.cpu_relax.to.hrtimer_cancel	2006-04-03 13:40:05.000000000 -0400
+++ 2.6.17-rc1-jak/kernel/hrtimer.c	2006-04-03 13:41:06.000000000 -0400
@@ -501,6 +501,7 @@ int hrtimer_cancel(struct hrtimer *timer
 
 		if (ret >= 0)
 			return ret;
+		cpu_relax();
 	}
 }
 

_
