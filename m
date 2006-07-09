Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWGINTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWGINTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWGINTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:19:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:60596 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030493AbWGINTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:19:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=gBAUt7YXxF0V46nN/gT1Nxxl0kbEGBCvha/8iP7TMBHKDQx8pjQBbABKe5myMQHxh1d7WH/oSas3WttLxd3zxINXUUozmzHkhx9V7YZ3UMZPdqz5Quh+sSGDBd2KhwD9Di3nioewTPUdZ2tIEEaZe2RHYvTeNAQJPX7gHwht9DA=
Date: Sun, 9 Jul 2006 15:19:55 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] Add try_to_freeze() to rt-test kthreads
Message-ID: <20060709131955.GA24459@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm running kernel 2.6.18-rc1. When CONFIG_RT_MUTEX_TESTER is enabled
kernel refuses to suspend the machine because it's unable to freeze the
rt-test-* threads. This patch adds try_to_freeze() after schedule() so
that the threads will be freezed correctly; I've tested the patch and it
lets the notebook suspends and resumes nicely.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>

--- a/kernel/rtmutex-tester.c	2006-07-09 15:15:08.540456698 +0200
+++ b/kernel/rtmutex-tester.c	2006-07-09 14:39:26.653218497 +0200
@@ -275,6 +275,7 @@
 
 		/* Wait for the next command to be executed */
 		schedule();
+		try_to_freeze();
 
 		if (signal_pending(current))
 			flush_signals(current);


Luca
-- 
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
