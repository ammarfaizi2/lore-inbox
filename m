Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKWNJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKWNJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKWNJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:09:45 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38367 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750776AbVKWNJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:09:44 -0500
Message-ID: <43847B8B.F716E7A4@tv-sign.ru>
Date: Wed, 23 Nov 2005 17:24:11 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] little do_group_exit() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_other_threads() sets SIGNAL_GROUP_EXIT at the very start,
do_group_exit() doesn't need to do it.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/kernel/exit.c~3_DOGE	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15-rc2/kernel/exit.c	2005-11-23 19:33:27.000000000 +0300
@@ -926,7 +926,6 @@ do_group_exit(int exit_code)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
 		else {
-			sig->flags = SIGNAL_GROUP_EXIT;
 			sig->group_exit_code = exit_code;
 			zap_other_threads(current);
 		}
