Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWCXQQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWCXQQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWCXQQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:16:38 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:57257 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932443AbWCXQQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:16:36 -0500
Message-ID: <44241AB3.A5E6AF78@tv-sign.ru>
Date: Fri, 24 Mar 2006 19:13:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: [PATCH 2.6.16-mm1 2/3] finish_stop: don't check stop_count < 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an obscure 'stop_count < 0' check in finish_stop().
The previous patch made this case impossible.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/signal.c~3_STCT	2006-03-24 20:01:46.000000000 +0300
+++ MM/kernel/signal.c	2006-03-24 20:48:12.000000000 +0300
@@ -1657,7 +1657,7 @@ finish_stop(int stop_count)
 	 * a group stop in progress and we are the last to stop,
 	 * report to the parent.  When ptraced, every thread reports itself.
 	 */
-	if (stop_count < 0 || (current->ptrace & PT_PTRACED))
+	if (current->ptrace & PT_PTRACED)
 		to_self = 1;
 	else if (stop_count == 0)
 		to_self = 0;
