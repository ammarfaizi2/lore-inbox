Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULBWkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULBWkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbULBWkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:40:19 -0500
Received: from users.ccur.com ([208.248.32.211]:19951 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261794AbULBWkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:40:14 -0500
Date: Thu, 2 Dec 2004 17:39:51 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix uninitialized variable in waitid(2)
Message-ID: <20041202223951.GA22488@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041201232204.GA29829@tsunami.ccur.com> <200412012358.iB1Nwk3C002166@magilla.sf.frob.com> <20041202175418.GA9716@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202175418.GA9716@tsunami.ccur.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specify an initial value signal_struct's field stop_state
whenever a signal_struct variable is created.

Bug was discovered through the occasional failure of
telnet(1) to connect.

Signed-off-by: Joe Korty <joe.korty@ccur.com>

--- base/kernel/fork.c	2004-12-02 17:18:39.340843441 -0500
+++ new/kernel/fork.c	2004-12-02 17:24:27.085305563 -0500
@@ -733,6 +733,7 @@
 	sig->group_exit_code = 0;
 	sig->group_exit_task = NULL;
 	sig->group_stop_count = 0;
+	sig->stop_state = 0;
 	sig->curr_target = NULL;
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
